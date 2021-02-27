# users generic .zshrc file for zsh(1)

## Environment variable configuration
#
# LANG
#
export LANG=ja_JP.UTF-8


## Default shell configuration
#
# set prompt
#
autoload colors
colors
case ${UID} in
0)
  PROMPT="%B%{${fg[red]}%}%/#%{${reset_color}%}%b "
  PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
  SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
    PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
  ;;
*)
  PROMPT="${HOST} %{${fg_bold[green]}%}%/%%%{${reset_color}%} "
  PROMPT2="%{${fg_bold[green]}%}%_%%%{${reset_color}%} "
  SPROMPT="%{${fg_bold[green]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
#  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
#    PROMPT="%{${fg_bold[white]}%}${HOST%%.*} ${PROMPT}"
  ;;
esac

# auto change directory
#
setopt auto_cd

# auto directory pushd that you can get dirs list by cd -[tab]
#
setopt auto_pushd

# command correct edition before each completion attempt
#
setopt correct

# compacked complete list display
#
setopt list_packed

# no remove postfix slash of command line
#
setopt noautoremoveslash

# no beep sound when complete list displayed
#
setopt nolistbeep

## Keybind configuration
#
# emacs like keybind (e.x. Ctrl-a goes to head of a line and Ctrl-e goes
# to end of it)
#
bindkey -e

# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

## Command history configuration
#
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups # ignore duplication command history list
setopt share_history # share command history data
function history-all { history -E 1 }

function less_with_unbuffer() {
    unbuffer "$@" |& less -R
}


## Completion configuration
#
autoload -U compinit
compinit -u

## Alias configuration
#
# expand aliases before completing
#
setopt complete_aliases # aliased ls needs if file/dir completions work

alias where="command -v"
alias j="jobs -l"

case "${OSTYPE}" in
freebsd*|darwin*)
  alias ls="ls -G -w"
  ;;
linux*)
  alias ls="ls -F --color=auto"
  ;;
esac

#alias less='~/local_linux/bin/lv'
alias l='ls -F --color=auto'
alias ls='ls -F --color=auto'
alias ll='ls -Fl --color=auto'
alias la='ls -Fla --color=auto'
alias le='less'
alias cp='cp -i'
alias history='history 1000'
alias grep='grep --color=auto'
alias find_space='find . -type f -exec egrep -l " +$" {} \;'
alias ts=find_space
alias trailingspace=find_space
alias find_tab='find . -type f -exec egrep -l "\t" {} \;'

## Terminal configuration
unset LSCOLORS
case "${TERM}" in
xterm)
  export TERM=xterm-color
  export GREP_COLORS='ms=01;31:mc=01;31:sl=:cx=:fn=36:ln=32:bn=32:se=36'
  ;;
kterm)
  export TERM=kterm-color
  # set BackSpace control character
  stty erase
  ;;
cons25)
  unset LANG
  export LSCOLORS=ExFxCxdxBxegedabagacad
  export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
  zstyle ':completion:*' list-colors \
    'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
  ;;
cygwin)
  export LANG=C
  ;;
esac


# set terminal title including current directory
#
    case "${TERM}" in
    kterm*|xterm*|cygwin)
    precmd() {
	echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
	export LSCOLORS=exfxcxdxbxegedabagacad
	#  export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
	export LS_COLORS='no=00:fi=00:di=00;33:ln=00;36:pi=40;33:so=00;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=00;32:*.cmd=00;32:*.exe=00;32:*.com=00;32:*.btm=00;32:*.bat=00;32:*.sh=00;32:*.csh=00;32:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.bz=00;31:*.tz=00;31:*.rpm=00;31:*.cpio=00;31:*.jpg=00;35:*.gif=00;35:*.bmp=00;35:*.xbm=00;35:*.xpm=00;35:*.png=00;35:*.tif=00;35:'
  zstyle ':completion:*' list-colors \
    'di=33' 'ln=36' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
  ;;
esac

export EDITOR="emacs"

