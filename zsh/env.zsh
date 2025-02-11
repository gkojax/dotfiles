HISTFILE=$HOME/.zsh-history
# メモリ内の履歴
HISTSIZE=10000
# 保存される履歴
SAVEHIST=100000
function history-all { history -E 1 }

# 複数ファイルのリネーム　-nでdryrun
autoload -Uz zmv

# cd と同時に ls
function chpwd() {
    gls --color=auto
}

# plugins.zsh-command-timeの設定
ZSH_COMMAND_TIME_MIN_SECONDS=3
ZSH_COMMAND_TIME_MSG="Execution time: %s sec"
ZSH_COMMAND_TIME_COLOR="cyan"
ZSH_COMMAND_TIME_EXCLUDE=(vim mcedit)

export FZF_DEFAULT_OPTS='--height 40% --tmux bottom,40% --layout reverse --border top'
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --select-1 --exit-0"

export FZF_CTRL_R_OPTS="
--bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
--color header:italic"

eval "$(zoxide init zsh)"
zle -N zi
bindkey '^z' zi

function ghq-fzf() {
  local src=$(ghq list | fzf --preview "ls -laTp $(ghq root)/{} | tail -n+4 | awk '{print \$9\"/\"\$6\"/\"\$7 \" \" \$10}'")
  if [ -n "$src" ]; then
    BUFFER="cd $(ghq root)/$src"
    zle accept-line
  fi
  zle -R -c
}
zle -N ghq-fzf
bindkey '^]' ghq-fzf

autoload -Uz vcs_info
 setopt prompt_subst
 zstyle ':vcs_info:git:*' check-for-changes true
 zstyle ':vcs_info:git:*' stagedstr "%F{magenta}!"
 zstyle ':vcs_info:git:*' unstagedstr "%F{yellow}+"
 zstyle ':vcs_info:*' formats "%F{cyan}%c%u[%b]%f"
 zstyle ':vcs_info:*' actionformats '[%b|%a]'
 precmd () { vcs_info }

 # プロンプト
 PROMPT='%! %n:$vcs_info_msg_0_%f%F{yellow}%f %(!.#.>) '

 # プロンプト右端
 RPROMPT='[%~]'

zshaddhistory() {
    local line="${1%%$'\n'}"
    [[ ! "$line" =~ "^(cd|la|l|ls|rm|rmdir|exit|history-all)($| )" ]]
}

compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION
zstyle ':completion:*' cache-path $XDG_CACHE_HOME/zsh/zcompcache
