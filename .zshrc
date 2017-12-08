# Hyphen-insensitive completion. Case sensitive completion must be off.
HYPHEN_INSENSITIVE="true"

# We don't need 'oh-my-zsh' updates
DISABLE_AUTO_UPDATE="true"

# Enables command auto-correction.
ENABLE_CORRECTION="true"

# Displays red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Optional formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd.mm.yyyy"

# Tmux plugin configuration
ZSH_TMUX_AUTOSTART="true"
ZSH_TMUX_AUTOCONNECT="false"

# Powerlevel9k configuration
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_SHORTEN_DELIMITER=".."

POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND='black'
POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND='178'
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND="blue"
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND="015"
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='245'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='black'

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(root_indicator dir dir_writable vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs command_execution_time)

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
if uname -a | grep -q '^Linux.*Microsoft'; then
    ## connect to our VcXsrv instance
    export DISPLAY=:0.0
    ## we ignore windows dlls for autocompletion
    zstyle ':completion:*:-command-:*' ignored-patterns '*.(DLL|dll)'
    ## source our ssh-agent settings
    [ -e "/home/keupon/.ssh/environment" ] && source "/home/keupon/.ssh/environment" >/dev/null
    ## start ssh-agent if failed to launch on startup
    alias ssh-agent-start='schtasks.exe /run /tn ssh-agent-bash && sleep 1 && source ~/.ssh/environment'
    ## add all of our current keys
    alias ssh-add-all='ssh-add ~/.ssh/id_^*.pub'
    ## maven alias
    alias mvn='cmd.exe /C mvn.cmd'
fi

source "${HOME}/.zgen/zgen.zsh"

if ! zgen saved; then
    zgen oh-my-zsh

    # plugins
    zgen oh-my-zsh plugins/gitfast
    zgen oh-my-zsh plugins/sudo
    zgen oh-my-zsh plugins/debian
    zgen oh-my-zsh plugins/autojump
    zgen oh-my-zsh plugins/command-not-found
    zgen oh-my-zsh plugins/extract
    zgen oh-my-zsh plugins/docker
    zgen load zsh-users/zsh-syntax-highlighting

    # completions
    zgen load zsh-users/zsh-completions src

    # theme
    zgen load bhilburn/powerlevel9k powerlevel9k

    # save all to init script
    zgen save
fi
