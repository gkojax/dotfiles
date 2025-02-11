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

# プロンプト
PROMPT='%! %n:%m %(!.#.>) '

# プロンプト右端
RPROMPT='[%~]'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_OPTS='--height 40% --tmux bottom,40% --layout reverse --border top'
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --select-1 --exit-0"

export FZF_CTRL_R_OPTS="
--bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
--color header:italic"
