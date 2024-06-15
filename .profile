# shellcheck shell=sh

# env
if [ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/env.sh ]; then
  # shellcheck source=.config/env.sh
  . "${XDG_CONFIG_HOME:-$HOME/.config}"/env.sh
fi

### Complete Messages
# echo "Loading .profile completed!!"
