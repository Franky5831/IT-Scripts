# #!/usr/bin/env bash
#
# Author: Francesco Ciannavei
# Author Email: francesco@ciannavei.dev
# Author Website: https://www.ciannavei.link
# Author GitHub: https://github.com/Franky5831


# Function to read individual variables from a config file
# This function has been copied from the following stackexchange thread: https://unix.stackexchange.com/a/331965
config_read_file() {
  (grep -E "^${2}=" -m 1 "${1}" 2>/dev/null || echo "VAR=__UNDEFINED__") | head -n 1 | cut -d '=' -f 2-;
}

# Function to read config files
# This function has been copied from the following stackexchange thread: https://unix.stackexchange.com/a/331965
config_get() {
  val="$(config_read_file config.cfg "${1}")";
  if [ "${val}" = "__UNDEFINED__" ]; then
      val="$(config_read_file config.cfg.defaults "${1}")";
  fi
  printf -- "%s" "${val}";
}
