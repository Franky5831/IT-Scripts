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
# --- config ---------------------------------------------------------------

PUBLIC_IP=$(curl ipinfo.io/ip) # Gets public IP
EXPOSED_IP="YOUR-PUBLIC-IP-GOES-HERE"
SMB_INTERNAL_IP="THE-INTERNAL-IP-FOR-THE-NAS-GOES-HERE"
SMB_SHARE="YOUR-SMB-DIRECTORY-GOES-HERE"
SMB_PORT="THE-NAS-PORT-GOES-HERE" # The default port for smb is 445

# Get username and password from keychain, both have the same user and password
# If you ever logged in MacOs has already asked you if you want to save your password in the keychain
# The first time you run this script MacOs might ask you if you want to allow the terminal to access your keychain
USERNAME=$(security find-internet-password -s "${SMB_INTERNAL_IP}" -g 2>&1 | grep -E 'acct' |  sed 's/^ *//' | sort | rev  | cut -d'"' -f2 | rev)
PASSWORD=$(security find-internet-password -s "${SMB_INTERNAL_IP}" -g 2>&1 | grep -E 'password' |  sed 's/^ *//' | sort | rev  | cut -d'"' -f2 | rev )

# --- helpers ---------------------------------------------------------------




# --- main ------------------------------------------------------------------

umount /Volumes/${SMB_SHARE} # Unmounts drive to then mount it again
if [ "$PUBLIC_IP" == "$EXPOSED_IP" ]; then # Checks if the current ip of the network matches the exposed ip, if not it can not mount the smb drive
	open smb://${USERNAME}:${PASSWORD}@${SMB_INTERNAL_IP}:${SMB_PORT}/${SMB_SHARE} # Mounts drive from private network
fi
