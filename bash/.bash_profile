PATH=/usr/lib/colorgcc/bin:$PATH:/opt/bin:~/bin
export CCACHE_PATH=/usr/bin
export LANG=en_US.UTF-8

[[ -z $DISPLAY && $XDG_VTNR -eq 9 ]] && exec startx

GREP=$(which grep)
GAWK=$(which gawk)

alias ls="ls --color"
alias ll="ls -lh"
alias l="ll"
alias lt="l -t"
alias la="l -a"
alias lat="l -at"
alias vi="vim"
alias et="emacs -nw"
alias ec="emacsclient -a \"\" -c -n"
alias ect="emacsclient -a \"\" -c -nw"
alias grep="grep --exclude-dir=.svn --exclude-dir=.git --exclude-dir=.hg --exclude=TAGS --color=always -n"
alias psf="ps xuf"
alias sb="sudo bash"
alias minicom="minicom -c on -w"
alias tmux="tmux -2"
[[ -f /usr/bin/colorsvn ]] && {
    alias svn="colorsvn"
}
[[ -f /usr/bin/grc ]] && {
  alias ping="grc --colour=auto ping"
  alias traceroute="grc --colour=auto traceroute"
  alias netstat="grc --colour=auto netstat"
}

# cleanly reset terminal
alias cls="echo -ne '\033c'"

export LESS="-FRX"

alias pp="sudo sh -c 'echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor; echo performance > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor'"
alias pc="sudo sh -c 'echo conservative > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor; echo conservative > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor'"

complete -cf sudo
complete -cf xargs
complete -cf man

# Git me harder!
__git_ps1 ()
{
    local g="$(git rev-parse --git-dir 2>/dev/null)"
    if [ -n "$g" ]; then
        local r
        local b
        if [ -d "$g/../.dotest" ]
        then
            local b="$(git symbolic-ref HEAD 2>/dev/null)"
            r="|REBASING"
        elif [ -d "$g/.dotest-merge" ]
        then
            r="|REBASING"
            b="$(cat $g/.dotest-merge/head-name)"
        elif [ -f "$g/MERGE_HEAD" ]
        then
            r="|MERGING"
            b="$(git symbolic-ref HEAD 2>/dev/null)"
        else
            if [ -f $g/BISECT_LOG ]
            then
                r="|BISECTING"
            fi
            if ! b="$(git symbolic-ref HEAD 2>/dev/null)"
            then
                b="$(cut -c1-7 $g/HEAD)..."
            fi
        fi
        if [ -n "$1" ]; then
            printf "$1" "${b##refs/heads/}$r"
        else
            printf " (%s)" "${b##refs/heads/}$r"
        fi
    fi
}

PS1="\[\e[0;31m\](\[\e[0;33m\]\u\[\e[0;36m\]@\[\e[0;37m\]\H\[\e[0;31m\]|\[\e[0;32m\]\t\[\e[0;31m\]|\[\e[1;34m\]\w\[\e[0;31m\])\n\[\e[0;31m\]*~>\[\e[0m\]"
PS1="${PS1//\\w/\\w\$(__git_ps1)}"
XTERM_TITLE='\[\033]0;\W@\u@\H\007\]'

export BC_ENV_ARGS=-l
HISTIGNORE='&'

function ew() {
    emacs "$@" >/dev/null 2>&1 &
}
function ediff() {
    ew -eval "(ediff-files \"$1\" \"$2\")"
}
function heff() {
    ew -eval "(ediff-hexl \"$1\" \"$2\")"
}
function hexl() {
    ew -eval "(hexl-find-file \"$1\")"
}

function notify() {
	TITLE='successfully completed'
	eval $@
	if [[ $? > 0 ]]; then TITLE='completed with error'; fi
	notify-send -i typing-monitor "$TITLE" "$*"
}

function wtitle() {
	TITLE=$1
	wmctrl -i -r $(xprop -root | $GREP "_NET_ACTIVE_WINDOW(WINDOW)" | $GAWK -F '# ' '{print $2}') -T "$TITLE"
	if [[ -n "$TMUX" ]]; then
		tmux rename-session $TITLE
	fi
}

function tptoggle() {
	synclient TouchpadOff=$(synclient -l| $GREP TouchpadOff | $GAWK -F'= ' '{print !$2}')
}

function tags_c() {
    rm -f TAGS
    find ./ -name '*.[ch]' -o -name '*.cpp' -o -name '*.cxx' | xargs etags -a
}
function tags_py() {
    rm -f TAGS
    find ./ -name '*.py' | xargs etags -a
}

# pretty man pages
export LESS_TERMCAP_mb=$'\e[01;31m'        # begin blinking
export LESS_TERMCAP_md=$'\e[01;33m'        # begin bold
export LESS_TERMCAP_so=$'\e[01;31m'        # begin standout-mode - info box
export LESS_TERMCAP_us=$'\e[01;04;34m'     # begin underline
export LESS_TERMCAP_me=$'\e[0m'            # end mode
export LESS_TERMCAP_se=$'\e[0m'            # end standout-mode
export LESS_TERMCAP_ue=$'\e[0m'            # end underline

COLORTERM=y
export COLORTERM

