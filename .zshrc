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

# 補完機能
autoload -U compinit
compinit

autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
bindkey "^o" history-beginning-search-backward-end

autoload -Uz add-zsh-hook
autoload -Uz chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ":chpwd:*" recent-dirs-max 200
zstyle ":chpwd:*" recent-dirs-default true

autoload -Uz zmv

zstyle ':completion:*:default' menu select=1

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

# プロンプト
PROMPT='%! %n:%m %(!.#.>) '

# プロンプト右端
RPROMPT='[%~]'

function chpwd() {
	echo -n "\e]2;$(pwd)\a"
	ls -CFqv | tail
}

# 以下エイリアス
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

fpath=(~/dotfiles/zsh-completions/src $fpath)
source ~/dotfiles/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# eval $(dircolors ~/dotfiles/dircolors-solarized/dircolors.ansi-universal)
# zinit light zsh-users/zsh-autosuggestions

eval "$(gh completion -s zsh)"

# 初回シェル時のみ tmux実行
if [ $SHLVL = 1 ]; then
  tmux
fi
