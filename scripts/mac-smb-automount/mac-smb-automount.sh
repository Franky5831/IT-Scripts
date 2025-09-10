# #!/usr/bin/env bash
#
# Author: Francesco Ciannavei
# Author Email: francesco@ciannavei.dev
# Author Website: https://www.ciannavei.link
# Author GitHub: https://github.com/Franky5831
#
#
# This script automatically mounts your SMB NAS
# The script is not supposed to be ran by cli but rather to be launched by the os
# The script requires no parameters
# The configuration for the 
#

# --- helpers ---------------------------------------------------------------

get_public_ip() {
  # Keep it fast & quiet; fall back to empty on failure
  curl -sS --max-time 2 https://ifconfig.me || true
}

is_share_mounted() {
  mount | grep -q "/Volumes/${SMB_SHARE}"
}

# --- config ---------------------------------------------------------------
source ../../libraries/config.sh;
echo "$(config_get othervar)";

PUBLIC_IP=$(curl ipinfo.io/ip) # Gets public IP
EXPOSED_IP="YOUR-PUBLIC-IP-GOES-HERE"
SMB_INTERNAL_IP="THE-INTERNAL-IP-FOR-THE-NAS-GOES-HERE"
SMB_SHARE="YOUR-SMB-DIRECTORY-GOES-HERE"

# Get username and password from keychain, both have the same user and password
# If you ever logged in MacOs has already asked you if you want to save your password in the keychain
# The first time you run this script MacOs might ask you if you want to allow the terminal to access your keychain
USERNAME=$(security find-internet-password -s "${SMB_INTERNAL_IP}" -g 2>&1 | grep -E 'acct' |  sed 's/^ *//' | sort | rev  | cut -d'"' -f2 | rev)
PASSWORD=$(security find-internet-password -s "${SMB_INTERNAL_IP}" -g 2>&1 | grep -E 'password' |  sed 's/^ *//' | sort | rev  | cut -d'"' -f2 | rev )

# --- main ------------------------------------------------------------------

umount /Volumes/${SMB_SHARE} # Unmounts drive to then mount it again
if [ "$PUBLIC_IP" == "$EXPOSED_IP" ]; then # Checks if the current ip of the network matches the exposed ip, if not it can not mount the smb drive

	MOUNT_POINT="/Volumes/$SMB_SHARE"
  if [ ! -d "$MOUNT_POINT" ]; then # Checks if the mounting point exists, if not it creats it
    mkdir -p $MOUNT_POINT
  fi
  mount_smbfs "//$USERNAME:$PASSWORD@$SMB_INTERNAL_IP/$SMB_SHARE" $MOUNT_POINT
fi
