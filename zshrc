# sheldon実行
export SHELDON_CONFIG_DIR=~/dotfiles/sheldon
sheldon_toml="${SHELDON_CONFIG_DIR}/plugins.toml"

cache_dir=$HOME/.cache
sheldon_cache="$cache_dir/sheldon.zsh"

if [[ ! -r "$sheldon_cache" || "$sheldon_toml" -nt "$sheldon_cache" ]]; then
  mkdir -p $cache_dir
  sheldon source > $sheldon_cache
fi
source "$sheldon_cache"
unset cache_dir sheldon_cache sheldon_toml
