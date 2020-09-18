# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git git-extras git-flow z zsh-completions zsh-syntax-highlighting)
autoload -U compinit && compinit

# Path to your oh-my-zsh installation
export ZSH=$ZDOTDIR/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
if [ -n "$INSIDE_EMACS" ]; then
    export ZSH_THEME="rawsyntax"
else
    export ZSH_THEME="geometry"
fi

source $ZSH/oh-my-zsh.sh

# environment for
# export ARDUINO_DIR=/Applications
# export ARDMK_DIR=/home/sudar/Dropbox/code/Arduino-Makefile
# export AVR_TOOLS_DIR=/usr

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TERM=xterm-256color

# newline before every prompt
precmd() { echo }

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Configure terminal to run emacs with same buffer and application instances
alias t='open -a /Applications/iTerm.app/Contents/MacOS/iTerm2 "$@"'
alias e='open $emacs $1'
alias et='emacsclient -nw'

# kubernetes shortcut
alias k8=kubectl
alias kns=kubens
# quick access to terminal
function k8t() {
    kubectl exec -it $1 -- bash
}

function k8p() {
    while getopts ":n" option; do
        case $option in
            n)
                TEMPLATE_STR="{{range .items}}{{.metadata.name}}{{"'"\n"'"}}{{end}}"
                TEMPLATE_ARGS=(--template ${TEMPLATE_STR})
                shift
                ;;
            *)
                break
                ;;
        esac
    done
    if [[ $# -eq 0 ]]; then
        kubectl get pods
    elif [[ $# -gt 2 ]]; then
        echo "invalid argument length" 1>&2
    elif [[ -n "$2" ]]; then
        kubectl get pods -l instance=$1,component=$2 ${TEMPLATE_ARGS[@]}
    elif [[ -n "$1" ]]; then
        kubectl get pods -l instance=$1 ${TEMPLATE_ARGS[@]}
    fi
}

function k8pc() {
    target=$(k8p -n $@ | head -1)
    if [[ -z "$target" ]]; then
        echo "No target was found!"
    else
        echo $target | pbcopy
        echo "Copied '$target' k8 pod name to clipboard."
    fi
}

function k8aplt() {
    token=$(aws eks get-token --cluster-name=eks-prod-cluster | jq ".status.token" | tr -d '"')
    if [[ -z "$token" ]]; then
        echo "Token can't be generated!"
    else
        echo $token | pbcopy
        echo "Copied '$token' to clipboard"
    fi
}

# other aliases
# alias pip=pip3
export EDITOR="emacsclient"
setopt rm_star_silent

# git shorcuts
alias gcm="git commit -m"
alias gpo="git push origin"
alias gdc="git diff --cached"
alias gdd="git diff"

# hubble main folders
alias hbemapi="cd /Users/asdingfs/Adventures/hubble/hubble_api_master"
alias hbedapi="cd /Users/asdingfs/Adventures/hubble/hubble_api_develop"
alias hbemv3api="cd /Users/asdingfs/Adventures/hubble/hubble_api_master_v3/"
alias hbedv3api="cd /Users/asdingfs/Adventures/hubble/hubble_api_develop_v3/"
alias hfemweb="cd /Users/asdingfs/Adventures/hubble/hubble_web_base"
alias hbejqgem="cd /Users/asdingfs/Adventures/hubble/job_queue_container/gems/job_queue"
alias hbejqapi="cd /Users/asdingfs/Adventures/hubble/job_queue_server/app"

# copy aliases to emacs eshell alias
if [[ -e $HOME/.emacs.d/eshell/alias ]]; then
   alias | sed -E "s/^alias ([^=]+)='(.*)'$/alias \1 \2 \$*/g; s/'\\\''/'/g;" > $HOME/.emacs.d/eshell/alias
fi

# if shell is interactive only, source rvm too
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function* on login shells

if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi

