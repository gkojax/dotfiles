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
alias op='open .'

alias gs='git status'
alias gl='git log --oneline'
alias gln='git log --name-only'
alias gd='git diff'
alias gdn='git diff --name-only'
alias gcm='git commit -m'
alias ga='git add'
alias gaa='git add --all'
alias gam='git am'
alias gama='git am --abort'
alias gamc='git am --continue'
alias gams='git am --skip'
alias gamscp='git am --show-current-patch'
alias gap='git apply'
alias gapa='git add --patch'
alias gapt='git apply --3way'
alias gau='git add --update'
alias gav='git add --verbose'
alias gb='git branch'
alias gbD='git branch --delete --force'
alias gba='git branch --all'
alias gbd='git branch --delete'
alias gbg='LANG=C git branch -vv | grep ": gone\]"'
alias gbgD='LANG=C git branch --no-color -vv | grep ": gone\]" | cut -c 3- | awk '\''{print $1}'\'' | xargs git branch -D'
alias gbgd='LANG=C git branch --no-color -vv | grep ": gone\]" | cut -c 3- | awk '\''{print $1}'\'' | xargs git branch -d'
alias gbl='git blame -w'
alias gbm='git branch --move'
alias gbnm='git branch --no-merged'
alias gbr='git branch --remote'
alias gbs='git bisect'
alias gbsb='git bisect bad'
alias gbsg='git bisect good'
alias gbsn='git bisect new'
alias gbso='git bisect old'
alias gbsr='git bisect reset'
alias gbss='git bisect start'
alias gc='git commit --verbose'
alias 'gc!'='git commit --verbose --amend'
alias gcB='git checkout -B'
alias gca='git commit --verbose --all'
alias 'gca!'='git commit --verbose --all --amend'
alias gcam='git commit --all --message'
alias 'gcan!'='git commit --verbose --all --no-edit --amend'
alias 'gcann!'='git commit --verbose --all --date=now --no-edit --amend'
alias 'gcans!'='git commit --verbose --all --signoff --no-edit --amend'
alias gcas='git commit --all --signoff'
alias gcasm='git commit --all --signoff --message'
alias gcb='git checkout -b'
alias gcd='git checkout $(git config gitflow.branch.develop)'
alias gcf='git config --list'
alias gch='git checkout $(git config gitflow.prefix.hotfix)'
alias gcl='git clone --recurse-submodules'
alias gclean='git clean --interactive -d'
alias gclf='git clone --recursive --shallow-submodules --filter=blob:none --also-filter-submodules'
alias gcm='git checkout $(git_main_branch)'
alias gcmsg='git commit --message'
alias gcn='git commit --verbose --no-edit'
alias 'gcn!'='git commit --verbose --no-edit --amend'
alias gco='git checkout'
alias gcor='git checkout --recurse-submodules'
alias gcount='git shortlog --summary --numbered'
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'
alias gcr='git checkout $(git config gitflow.prefix.release)'
alias gcs='git commit --gpg-sign'
alias gcsm='git commit --signoff --message'
alias gcss='git commit --gpg-sign --signoff'
alias gcssm='git commit --gpg-sign --signoff --message'
alias gd='git diff'
alias gdca='git diff --cached'
alias gdct='git describe --tags $(git rev-list --tags --max-count=1)'
alias gdcw='git diff --cached --word-diff'
alias gdn='git diff --name-only'
alias gds='git diff --staged'
alias gdt='git diff-tree --no-commit-id --name-only -r'
alias gdup='git diff @{upstream}'
alias gdw='git diff --word-diff'
alias gf='git fetch'
alias gfa='git fetch --all --tags --prune --jobs=10'
alias gfg='git ls-files | grep'
alias gfl='git flow'
alias gflf='git flow feature'
alias gflff='git flow feature finish'
alias gflffc='git flow feature finish ${$(git_current_branch)#feature/}'
alias gflfp='git flow feature publish'
alias gflfpc='git flow feature publish ${$(git_current_branch)#feature/}'
alias gflfpll='git flow feature pull'
alias gflfs='git flow feature start'
alias gflh='git flow hotfix'
alias gflhf='git flow hotfix finish'
alias gflhfc='git flow hotfix finish ${$(git_current_branch)#hotfix/}'
alias gflhp='git flow hotfix publish'
alias gflhpc='git flow hotfix publish ${$(git_current_branch)#hotfix/}'
alias gflhs='git flow hotfix start'
alias gfli='git flow init'
alias gflr='git flow release'
alias gflrf='git flow release finish'
alias gflrfc='git flow release finish ${$(git_current_branch)#release/}'
alias gflrp='git flow release publish'
alias gflrpc='git flow release publish ${$(git_current_branch)#release/}'
alias gflrs='git flow release start'
alias gfo='git fetch origin'
alias gg='git gui citool'
alias gga='git gui citool --amend'
alias ggpull='git pull origin "$(git_current_branch)"'
alias ggpush='git push origin "$(git_current_branch)"'
alias ggsup='git branch --set-upstream-to=origin/$(git_current_branch)'
alias ghf='git hf'
alias ghff='git hf feature'
alias ghfh='git hf hotfix'
alias ghfr='git hf release'
alias ghfs='git hf support'
alias ghfu='git hf update'
alias ghh='git help'
alias gignore='git update-index --assume-unchanged'
alias gignored='git ls-files -v | grep "^[[:lower:]]"'
alias git-svn-dcommit-push='git svn dcommit && git push github $(git_main_branch):svntrunk'
alias github='web_search github'
alias gk='\gitk --all --branches &!'
alias gke='\gitk --all $(git log --walk-reflogs --pretty=%h) &!'
alias gl='git pull'
alias glfsi='git lfs install'
alias glfsls='git lfs ls-files'
alias glfsmi='git lfs migrate import --include='
alias glfst='git lfs track'
alias glg='git log --stat'
alias glgg='git log --graph'
alias glgga='git log --graph --decorate --all'
alias glgm='git log --graph --max-count=10'
alias glgp='git log --stat --patch'
alias gln='git log --name-only'
alias glo='git log --oneline --decorate'
alias glod='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset"'
alias glods='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset" --date=short'
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'
alias glol='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset"'
alias glola='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --all'
alias glols='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --stat'
alias glp=_git_log_prettily
alias gluc='git pull upstream $(git_current_branch)'
alias glum='git pull upstream $(git_main_branch)'
alias gm='git merge'
alias gma='git merge --abort'
alias gmc='git merge --continue'
alias gmff='git merge --ff-only'
alias gmom='git merge origin/$(git_main_branch)'
alias gms='git merge --squash'
alias gmtl='git mergetool --no-prompt'
alias gmtlvim='git mergetool --no-prompt --tool=vimdiff'
alias gmum='git merge upstream/$(git_main_branch)'
alias gp='git push'
alias gpd='git push --dry-run'
alias gpf='git push --force-with-lease --force-if-includes'
alias 'gpf!'='git push --force'
alias gpoat='git push origin --all && git push origin --tags'
alias gpod='git push origin --delete'
alias gpr='git pull --rebase'
alias gpra='git pull --rebase --autostash'
alias gprav='git pull --rebase --autostash -v'
alias gpristine='git reset --hard && git clean --force -dfx'
alias gprom='git pull --rebase origin $(git_main_branch)'
alias gpromi='git pull --rebase=interactive origin $(git_main_branch)'
alias gprum='git pull --rebase upstream $(git_main_branch)'
alias gprumi='git pull --rebase=interactive upstream $(git_main_branch)'
alias gprv='git pull --rebase -v'
alias gpsup='git push --set-upstream origin $(git_current_branch)'
alias gpsupf='git push --set-upstream origin $(git_current_branch) --force-with-lease --force-if-includes'
alias gpu='git push upstream'
alias gpv='git push --verbose'
alias gr='git remote'
alias gra='git remote add'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbd='git rebase $(git_develop_branch)'
alias grbi='git rebase --interactive'
alias grbm='git rebase $(git_main_branch)'
alias grbo='git rebase --onto'
alias grbom='git rebase origin/$(git_main_branch)'
alias grbs='git rebase --skip'
alias grbum='git rebase upstream/$(git_main_branch)'
alias grev='git revert'
alias greva='git revert --abort'
alias grevc='git revert --continue'
alias grf='git reflog'
alias grh='git reset'
alias grhh='git reset --hard'
alias grhk='git reset --keep'
alias grhs='git reset --soft'
alias grm='git rm'
alias grmc='git rm --cached'
alias grmv='git remote rename'
alias groh='git reset origin/$(git_current_branch) --hard'
alias grrm='git remote remove'
alias grs='git restore'
alias grset='git remote set-url'
alias grss='git restore --source'
alias grst='git restore --staged'
alias grt='cd "$(git rev-parse --show-toplevel || echo .)"'
alias gru='git reset --'
alias grup='git remote update'
alias grv='git remote --verbose'
alias gs='git status'
alias gsb='git status --short --branch'
alias gsd='git svn dcommit'
alias gsh='git show'
alias gsi='git submodule init'
alias gsps='git show --pretty=short --show-signature'
alias gsr='git svn rebase'
alias gss='git status --short'
alias gst='git status'
alias gsta='git stash push'
alias gstaa='git stash apply'
alias gstall='git stash --all'
alias gstc='git stash clear'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash show --patch'
alias gsu='git submodule update'
alias gsw='git switch'
alias gswc='git switch --create'
alias gswd='git switch $(git_develop_branch)'
alias gswm='git switch $(git_main_branch)'
alias gta='git tag --annotate'
alias gtl='gtl(){ git tag --sort=-v:refname -n --list "${1}*" }; noglob gtl'
alias gts='git tag --sign'
alias gtv='git tag | sort -V'
alias gunignore='git update-index --no-assume-unchanged'
alias gunwip='git rev-list --max-count=1 --format="%s" HEAD | grep -q "\--wip--" && git reset HEAD~1'
alias gwch='git whatchanged -p --abbrev-commit --pretty=medium'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign --message "--wip-- [skip ci]"'
alias gwipe='git reset --hard && git clean --force -df'
alias gwt='git worktree'
alias gwta='git worktree add'
alias gwtls='git worktree list'
alias gwtmv='git worktree move'
alias gwtrm='git worktree remove'

if [ -f ~/.local.zsh ]; then
	source ~/.local.zsh
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
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
