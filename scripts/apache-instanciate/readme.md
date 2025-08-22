# apache-instanciate.sh

A bash script to quickly set up a new Apache virtual host and project directory on Debian-based systems (like Ubuntu).

It automates creating the web directory, finding an available port (starting from 8080), generating the vhost configuration, and safely enabling the new site.


## Requirements
A Debian-based Linux distribution (e.g., Ubuntu, Debian).

Apache2 web server installed.

Root or sudo privileges.


## Usage
Run the script with sudo and provide a project name. The name should be in a domain-like format (e.g., `my-project.com`).


```bash
sudo ./apache-instanciate.sh <project-name>
```
Example:
```bash
sudo ./apache-instanciate.sh my-cool-site.dev
```

Example Output:
```bash
🟡 Project directory created: /var/www/my-cool-site.dev
🟡 Vhost created: /etc/apache2/sites-available/my-cool-site.dev.conf (port 8080)
🟢 Project running on: http://192.168.1.10:8080
```
