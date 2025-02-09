export SHELDON_CONFIG_DIR=~/dotfiles/sheldon
eval "$(sheldon source)"

# 初回シェル時のみ tmux実行
if [ $SHLVL = 1 ]; then
  tmux
fi

# Emacs風ショートカットキー設定
bindkey -e

# エディタ
export EDITOR="/usr/bin/vim"

setopt IGNORE_EOF
setopt NO_FLOW_CONTROL
setopt NO_BEEP

# カーソル位置は保持したままファイル名一覧を順次その場で表示する
setopt always_last_prompt

# ディレクトリ名を打つだけでcd出来る
setopt auto_cd

# cdコマンドで移動した場所を記録する。 使う時はcd -[TAB]で
setopt auto_pushd

# 補完で末尾に補われた / を自動的に削除
setopt auto_remove_slash

# 履歴ファイル（HISTFILE）に開始時刻と経過時間を記録
setopt extended_history

# 補完時にヒストリを自動的に展開
# setopt hist_expand

# ヒストリで、重複するコマンドは古い方を削除
setopt hist_ignore_all_dups

# コマンドの先頭にスペースを入れた場合は、ヒストリに保存されない
setopt hist_ignore_space

# 履歴をインクリメンタルに追加
setopt inc_append_history

# C-s/C-q によるフロー制御を使わない
setopt no_flow_control

# ビープ音を消す
setopt no_beep

# プロンプトに escape sequence (環境変数) を通す
setopt prompt_subst

# ディレクトリスタックで、重複する物は古い方を削除
setopt pushd_ignore_dups

# 複数のpromptでログインした時など、履歴を共有する
setopt share_history

HISTFILE=$HOME/.zsh-history
# メモリ内の履歴
HISTSIZE=10000
# 保存される履歴
SAVEHIST=100000
function history-all { history -E 1 }

# 1分毎に時刻表示
PERIOD=60
function periodic_function1() {
  echo "$(date)\n"
}
periodic() {
  periodic_function1
}

# 複数ファイルのリネーム　-nでdryrun
autoload -Uz zmv

# cd と同時に ls
function chpwd() {
    gls --color=auto
}

# プロンプト
PROMPT='%! %n:%m %(!.#.>) '

# プロンプト右端
RPROMPT='[%~]'

# plugins.zsh-command-timeの設定
ZSH_COMMAND_TIME_MIN_SECONDS=3
ZSH_COMMAND_TIME_MSG="Execution time: %s sec"
ZSH_COMMAND_TIME_COLOR="cyan"
ZSH_COMMAND_TIME_EXCLUDE=(vim mcedit)

function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

## コマンド履歴検索
function peco-history-selection() {
  BUFFER=`history -n 1 | tac  | awk '!a[$0]++' | peco`
  CURSOR=$#BUFFER
  zle reset-prompt
}
zle -N peco-history-selection
bindkey '^R' peco-history-selection

## コマンド履歴からディレクトリ検索・移動
if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
  autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
  add-zsh-hook chpwd chpwd_recent_dirs
  zstyle ':completion:*' recent-dirs-insert both
  zstyle ':chpwd:*' recent-dirs-default true
  zstyle ':chpwd:*' recent-dirs-max 1000
  zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/chpwd-recent-dirs"
fi
function peco-cdr () {
  local selected_dir="$(cdr -l | sed 's/^[0-9]* *//' | peco)"
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
}
zle -N peco-cdr
bindkey '^X' peco-cdr

# エイリアス
alias -g L='| less'
alias -g G='| \grep -n'
alias ..='cd ..'
alias ls='gls --color=auto'
alias l='ls -lh'
alias lt='ls -ltr'
alias la='ls -a'
alias rm='rm -i'
alias h='history'
alias jk='jobs; kill %%'
alias grep='grep -n'

alias gs='git status'
alias gl='git log --oneline'
alias gln='git log --name-only'
alias gd='git diff'
alias gdn='git diff --name-only'
alias gcm='git commit -m'

if [ -f ~/.alias ]; then
	source ~/.alias
fi
