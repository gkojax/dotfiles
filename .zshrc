if [ -x /usr/libexec/path_helper ]; then
        eval `/usr/libexec/path_helper -s`
fi

bindkey -e
export CVSROOT="/Volumes/LikeWater/cvs"
export EDITOR="/usr/bin/vim"
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export JAVA_HOME="/Library/Java/Home"
export SCALA_HOME="/opt/local/share/scala-2.9"
export USE_FSC=yes

setopt always_last_prompt
setopt auto_cd
setopt auto_pushd
setopt auto_remove_slash
setopt extended_history
# setopt hist_expand
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt inc_append_history
setopt no_flow_control
setopt no_beep
setopt prompt_subst
setopt pushd_ignore_dups
setopt share_history

HISTFILE=$HOME/.zsh-history
HISTSIZE=10000
SAVEHIST=10000
function history-all { history -E 1 }

autoload -U compinit
compinit

zstyle ':completion:*:default' menu select=1
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' use-cache true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

PROMPT='%! %n:$HOST %(!.#.>) '
RPROMPT='[%~]'

if [ "$TERM" = "screen" ]; then
	chpwd () { echo -n "_`dirs`\\" }
	preexec() {
		# see [zsh-workers:13180]
		# http://www.zsh.org/mla/workers/2000/msg03993.html
		emulate -L zsh
		local -a cmd; cmd=(${(z)2})
		case $cmd[1] in
			fg)
				if (( $#cmd == 1 )); then
					cmd=(builtin jobs -l %+)
				else
					cmd=(builtin jobs -l $cmd[2])
				fi
				;;
			%*)
				cmd=(builtin jobs -l $cmd[1])
				;;
			cd)
				if (( $#cmd == 2)); then
					cmd[1]=$cmd[2]
				fi
				;&
			*)
				echo -n "k$cmd[1]:t\\"
				return
				;;
		esac

		local -A jt; jt=(${(kv)jobtexts})

		$cmd >>(read num rest
			cmd=(${(z)${(e):-\$jt$num}})
			echo -n "k$cmd[1]:t\\") 2>/dev/null
	}
	chpwd
fi

function chpwd() {
	echo -n "\e]2;$(pwd)\a"
	ls -CFqv
}

function cdup() {
	echo
	cd ..
	zle push-line-or-edit
	zle accept-line
}
zle -N cdup
# bindkey '\^' cdup

if [ -f ~/.alias ]; then
	source ~/.alias
fi
