PATH=/usr/lib/colorgcc/bin:/opt/bin:~/bin:~/.local/bin/:$PATH
PATH=/opt/homebrew/bin:$PATH

function _has() {
    which $1 >/dev/null 2>&1
}

if _has brew; then
    PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        . $(brew --prefix)/etc/bash_completion
    fi
fi

if _has ruby && _has gem; then
	export GEM_HOME=$(ruby -e 'print Gem.user_dir')
	PATH=$GEM_HOME/bin:$PATH
fi

export GOPATH=~/.local/go
PATH=$PATH:$GOPATH/bin

PATH=$PATH:~/.luarocks/bin

export CCACHE_PATH=/usr/bin

export LANG=en_US.UTF-8

# ignore ^D
set -o ignoreeof

GAWK=$(which gawk)

GREP=$(which grep)
if _has ggrep; then
    GREP=$(which ggrep)
fi
GREP_ARGS="--exclude-dir venv --exclude-dir=.svn --exclude-dir=.git --exclude-dir=.hg --exclude-dir=obj --exclude-dir=build --exclude=TAGS --exclude=rusty-tags.emacs --exclude='cscope.*' --exclude '*.d' --color=always"
alias grep="$GREP $GREP_ARGS"
alias rgrep="$GREP -rI \$(_rgrep_opt) $GREP_ARGS"
function _rgrep_opt() {
    _opts=$PWD/.rgrep
    if [[ -f $_opts ]]; then
        cat $_opts | tr '\n' ' '
    fi
}

LS=$(which ls)
if _has gls; then
    LS=$(which gls)
fi
alias ls="$LS --color"
alias ll="ls -lh"
alias l="ll"
alias lt="l -t"
alias la="l -a"
alias lat="l -at"

alias vi="vim"
alias et="emacs -nw"
alias sb="sudo bash"
alias minicom="minicom -c on -w"
alias tmux="tmux -2"

# misspelling
alias gti=git
alias hot=git

if _has colorsvn; then
    alias svn="colorsvn"
fi

if _has grc; then
    GRC="$(which grc) --colour=auto"
    alias ping="$GRC ping"
    alias traceroute="$GRC traceroute"
    alias netstat="$GRC netstat"
    alias ps="$GRC ps"
fi

# cleanly reset terminal
alias cls="reset; echo -ne '\033c'"

# exit bracketed paste mode
alias rbr="printf '\e[?2004l'; printf '\e[?2004h'"

export LESS="-FRX"

complete -cf sudo
complete -cf xargs
complete -cf man

# Do not prompt to edit merge message
export GIT_MERGE_AUTOEDIT=no

function _git () {
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

function _kontext() {
    if ! _has kubectl; then
        return
    fi

    local k=$(kubectl config current-context)
    local ns=$(kubectl config get-contexts $k --no-headers | awk '{print $5}')
    case $k in
        *dev*|*staging*)
            printf "\e[0;32m"
            ;;
        *prod*)
            printf "\e[0;31m"
            ;;
        *)
            ;;
    esac
    printf "${k}\e[0;35m:${ns}\e[0;31m|"
}

PS1="\[\e[0;31m\](\[\e[0;33m\]\u\[\e[0;36m\]@\[\e[0;37m\]\H\[\e[0;31m\]|\[\e[0;32m\]\t\[\e[0;31m\]|\$(_kontext)\[\e[1;34m\]\w\[\e[0;31m\])\n\[\e[0;31m\]*~>\[\e[0m\]"
PS1="${PS1//\\w/\\w\$(_git)}"

if [[ ( $TILIX_ID || $VTE_VERSION ) && -f /etc/profile.d/vte.sh ]]; then
    source /etc/profile.d/vte.sh
fi

XTERM_TITLE='\[\033]0;\W@\u@\H\007\]'

export BC_ENV_ARGS=-l
HISTIGNORE='&'

export PROMPT_COMMAND='history -a'
export HISTSIZE=20000
export HISTFILESIZE=20000

function wtitle() {
	local title=$1
    if _has wmctrl; then
	    wmctrl -i -r $(xprop -root | $GREP "_NET_ACTIVE_WINDOW(WINDOW)" | $GAWK -F '# ' '{print $2}') -T "$title"
    fi
	if [[ -n "$TMUX" ]]; then
		tmux rename-session $title
	fi
}

function ttitle {
    local title=$1
    echo -ne "\033]0;${title}\007"
}

function cscope_c() {
    rm -f cscope.*
    find . -name '*.[ch]' -o -name '*.cpp' -o -name '*.cxx' > cscope.files
    cscope -bq
}

function tags_c() {
    rm -f TAGS
    find . -name '*.[ch]' -o -name '*.cpp' -o -name '*.cxx' -o -name '*.java' | xargs ctags -a -e
}
function tags_py() {
    rm -f TAGS
    find . -name '*.py' | xargs etags -a
}
function tags_rb() {
    rm -f TAGS
    ripper-tags -f TAGS -R
}
function tags_rs() {
    rm -f rusty-tags.emacs
    rusty-tags -f emacs
}

function enable_rvm() {
    unset GEM_HOME
    PATH=$PATH:~/.rvm/bin
    [[ -s ~/.rvm/scripts/rvm ]] && source ~/.rvm/scripts/rvm
}

# pretty man pages
export LESS_TERMCAP_mb=$'\e[01;31m'        # begin blinking
export LESS_TERMCAP_md=$'\e[01;33m'        # begin bold
export LESS_TERMCAP_so=$'\e[01;31m'        # begin standout-mode - info box
export LESS_TERMCAP_us=$'\e[01;04;34m'     # begin underline
export LESS_TERMCAP_me=$'\e[0m'            # end mode
export LESS_TERMCAP_se=$'\e[0m'            # end standout-mode
export LESS_TERMCAP_ue=$'\e[0m'            # end underline

export COLORTERM=y

alias k=kubectl
# kubectx and kubens come from https://github.com/ahmetb/kubectx
alias ktx=kubectx
alias kns=kubens
alias klog="kubectl logs --all-containers=true"
function _kube_contexts() {
  local curr_arg;
  curr_arg=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=( $(compgen -W "- $(kubectl config get-contexts --output='name')" -- $curr_arg ) );
}
complete -F _kube_contexts kubectx ktx
function _kube_namespaces() {
  local curr_arg;
  curr_arg=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=( $(compgen -W "- $(kubectl get ns -o jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.status.startTime}{"\n"}{end}')" -- $curr_arg ) );
}
complete -F _kube_namespaces kubens kns

BASHRC_USER=~/.bashrc_user
[[ -s $BASHRC_USER ]] && source $BASHRC_USER

export RUST_BACKTRACE=1
. "$HOME/.cargo/env"
