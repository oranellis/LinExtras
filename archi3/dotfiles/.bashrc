#
# Oran's bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ $DISPLAY ]] && shopt -s checkwinsize

# Colour setup
if [ -n "$SSH_CLIENT" ]
then
	PS1='\[\e[1;36m\]\u\[\e[0;36m\](\h) \[\e[0;97m\]\w\[\e[0m\]\$ '
else
	PS1='\[\e[1;36m\]\u \[\e[0;97m\]\w\[\e[0m\]\$ '
fi

# no colour PS1
# PS1='\u@\h \W\$ '

alias ls='ls --color=auto'
alias grep='grep --color=auto'

case ${TERM} in
  xterm*|rxvt*|Eterm|aterm|kterm|gnome*)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'

    ;;
  screen*)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
    ;;
esac

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion
bind 'set completion-ignore-case on'

# Convenience Scripts

alias d=pwd

# NNN Config

n () {
	if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
		echo "nnn is already running"
		return
	fi
	export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
	nnn -Rd "$@"
	if [ -f "$NNN_TMPFILE" ]; then
		. "$NNN_TMPFILE"
		rm -f "$NNN_TMPFILE" > /dev/null
	fi
}
export NNN_USE_EDITOR=1
export NNN_BMS='h:~/;r:/;d:~/Dev;g:~/GRDev;o:~/Downloads;m:/run/media/oran'
