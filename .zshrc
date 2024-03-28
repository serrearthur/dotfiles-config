# Activate extended globbing
setopt EXTENDED_GLOB

# Include dotfiles in globs
setopt GLOB_DOTS

# Activate correction
setopt CORRECT

# Don't reduce background processes performance
unsetopt BG_NICE

# History configuration
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt EXTENDED_HISTORY

# Completion configuration
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END
setopt PROMPT_SUBST
unsetopt MENU_COMPLETE
setopt AUTO_MENU

# We don't expand '~'
export fignore=(\~)

# If in a tmux session, we disable CTRL+D
[ ! -z "$TMUX" ] && setopt ignoreeof

# WSL-only configuration
if uname -a | tr '[:upper:]' '[:lower:]' | grep -q '^linux.*microsoft'; then
    ## connect to our VcXsrv instance
    export DISPLAY=:0.0
    ## we ignore windows dlls for autocompletion
    zstyle ':completion:*:-command-:*' ignored-patterns '*.(DLL|dll)'
    alias open="wslview"


#OSX only configuration
elif uname -a | grep -q '^Darwin'; then
    export LS_COLORS='di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
    export CLICOLOR=1
    export LC_ALL=en_US.UTF-8

   # coreutils configuration
   export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
   export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
   alias vi="nvim"
fi

# Hyphen-insensitive completion. Case sensitive completion must be off.
HYPHEN_INSENSITIVE="true"

# We don't need 'ohmyzsh' updates
DISABLE_AUTO_UPDATE="true"

# Enables command auto-correction.
ENABLE_CORRECTION="true"

# Displays red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Optional formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd.mm.yyyy"

# Autosuggest plugin configuration
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=3"
ZSH_AUTOSUGGEST_STRATEGY=(history)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# Powerlevel9k configuration
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_SHORTEN_DELIMITER=".."

POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND='black'
POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND='178'
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND="blue"
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND="015"
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='245'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='black'
POWERLEVEL9K_TIME_FORMAT='%D{%H:%M}'
POWERLEVEL9K_TIME_ICON="\uF017 "

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(root_indicator dir dir_writable vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs command_execution_time time)

# Tmux plugin configuration
ZSH_TMUX_FIXTERM="false"

#if ps -p $PPID | grep -iq java; then
if [[ "$isIntelliJ" = "true" ]] || (ps -p $PPID | grep -iq java); then
    # don't start tmux when launched in intellij
    ZSH_TMUX_AUTOSTART="false";
else
    # Tmux plugin configuration (only outside intellij)
    ZSH_TMUX_AUTOSTART="true";
    ZSH_TMUX_AUTOSTART_ONCE="true"
    ZSH_TMUX_AUTOCONNECT="false"
    ZSH_TMUX_AUTOQUIT="true"
fi

# load zgenom
source "${HOME}/.zgenom/zgenom.zsh"

# check for plugin and zgenom updates every 7 days
zgenom autoupdate --background

# Reset zgenom init file when zshrc is modified
ZGEN_RESET_ON_CHANGE=(${HOME}/.zshrc)

if ! zgenom saved; then
    zgenom ohmyzsh

    # plugins
    zgenom ohmyzsh plugins/tmux
    zgenom ohmyzsh plugins/gitfast
    zgenom ohmyzsh plugins/git
    zgenom ohmyzsh plugins/sudo
    zgenom ohmyzsh plugins/command-not-found
    zgenom ohmyzsh plugins/extract
    zgenom ohmyzsh plugins/docker
    zgenom ohmyzsh plugins/docker-compose

    # completions and syntax highlighting
    zgenom load zsh-users/zsh-syntax-highlighting
    zgenom load zsh-users/zsh-completions
    zgenom load zsh-users/zsh-autosuggestions
    zgenom load "MichaelAquilina/zsh-you-should-use"

    # theme
    zgenom load bhilburn/powerlevel9k powerlevel9k

    # save all to init script
    zgenom save
fi

## load local aliases
if [ -f ~/.aliases ]; then
    . ~/.aliases
fi
