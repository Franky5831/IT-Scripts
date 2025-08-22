# #!/usr/bin/env bash
#
# Author: Francesco Ciannavei
# Author Email: francesco@ciannavei.dev
# Author Website: https://www.ciannavei.link
# Author GitHub: https://github.com/Franky5831
#
# This script creates a new Apache project directory and sets permissions
# 1. It creates the directory for the project inside the /var/www directory.
# 2. It configures apache to serve the project on the next available port.
# 3. It restarts apache to apply the changes.
#
# Usage:
# sh ./apache-instanciate.sh <project-name>
#
# Example:
# sh ./apache-instanciate.sh my-project.com
# sh ./apache-instanciate.sh github.com

set -eu

# --- helpers ---------------------------------------------------------------

require_root() {
  if [ "$(id -u)" -ne 0 ]; then
    echo "🔴 Please run as root (e.g., sudo sh $0 <project-name>)" >&2
    exit 1
  fi
}

find_free_port() {
  start="${1:-8080}"
  port="$start"
  while :; do
    in_use=0
    if command -v ss >/dev/null 2>&1; then
      # match ":PORT" at end or before whitespace
      if ss -tuln | awk -v p=":$port" '$5 ~ p"($|[[:space:]])" {found=1} END{exit !(found)}'
      then in_use=1; fi
    elif command -v netstat >/dev/null 2>&1; then
      if netstat -tuln | awk -v p=":$port" '$0 ~ p"($|[[:space:]])" {found=1} END{exit !(found)}'
      then in_use=1; fi
    fi

    declared=$(grep -R "^[[:space:]]*Listen[[:space:]]*$port\\b" /etc/apache2 2>/dev/null | wc -l | tr -d ' ')

    if [ "$in_use" -eq 0 ] && [ "$declared" -eq 0 ]; then
      echo "$port"
      return 0
    fi
    port=$((port + 1))
  done
}

configtest() {
  if command -v apache2ctl >/dev/null 2>&1; then
    apache2ctl -t
  else
    apachectl -t
  fi
}

reload_apache() {
  if command -v systemctl >/dev/null 2>&1; then
    systemctl reload apache2
  else
    service apache2 reload
  fi
}

# --- main ------------------------------------------------------------------

require_root

project="${1:-}"
if [ -z "$project" ]; then
  echo "Usage: sudo sh $0 <project-name>" >&2
  exit 1
fi

webroot="/var/www/$project"
sites_avail="/etc/apache2/sites-available"
conf="$sites_avail/$project.conf"

if [ -e "$conf" ]; then
  echo "🔴 Vhost already exists: $conf" >&2
  exit 1
fi
if [ -e "$webroot" ]; then
  echo "🔴 Directory already exists: $webroot" >&2
  exit 1
fi

mkdir -p "$webroot"
chmod 755 "$webroot"
printf '<h1>%s</h1>\n' "$project" > "$webroot/index.html"
echo "🟡 Project directory created: $webroot"

port="$(find_free_port 8080)"

# Write a minimal vhost that also declares its own Listen
cat > "$conf" <<EOF
# Auto-generated vhost for $project
Listen $port

<VirtualHost *:$port>
    ServerName $project.local
    DocumentRoot $webroot

    <Directory $webroot>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/$project-error.log
    CustomLog \${APACHE_LOG_DIR}/$project-access.log combined
</VirtualHost>
EOF

echo "🟡 Vhost created: $conf (port $port)"

# Enable site, test config, then reload
a2ensite "$project.conf" >/dev/null

if configtest >/dev/null 2>&1; then
  reload_apache
else
  echo "🔴 Apache config test failed. Rolling back..." >&2
  a2dissite "$project.conf" >/dev/null 2>&1 || true
  rm -f "$conf"
  exit 1
fi

# Determine an IP to print
ipaddr=""
if command -v ip >/dev/null 2>&1; then
  ipaddr=$(ip -4 route get 1.1.1.1 2>/dev/null | awk '{for(i=1;i<=NF;i++) if($i=="src"){print $(i+1); exit}}')
fi
[ -z "$ipaddr" ] && ipaddr=$(hostname -I 2>/dev/null | awk '{print $1}')
[ -z "$ipaddr" ] && ipaddr="127.0.0.1"

echo "🟢 Project running on: http://$ipaddr:$port"
