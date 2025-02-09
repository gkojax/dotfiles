# 初回シェル時のみ tmux実行
if [ $SHLVL = 1 ]; then
  tmux
fi

export SHELDON_CONFIG_DIR=~/dotfiles/sheldon
eval "$(sheldon source)"

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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--height 40% --tmux bottom,40% --layout reverse --border top'
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

export FZF_CTRL_R_OPTS="
--bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
--color header:italic
--header 'Press CTRL-Y to copy command into clipboard'"

eval "$(zoxide init zsh)"
zle -N zi
bindkey '^z' zi
