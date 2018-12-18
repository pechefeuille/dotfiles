export LANG=ja_JP.UTF-8
export PATH=/usr/local/bin:$PATH
export TERM=xterm-256color
export GOPATH=$HOME/Workspaces/Go
export BROWSER=google-chrome

ANDROID_SDK_HOME=$HOME/Library/Android/sdk
JAVA_HOME=`/System/Library/Frameworks/JavaVM.framework/Versions/A/Commands/java_home -v "1.8.0_144"`

export PATH=$GOPATH/bin:$PATH
export PATH=$HOME/.gobrew/bin:$PATH
export PATH=$ANDROID_SDK_HOME/platform-tools:$PATH
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH=$HOME/Workspaces/mergepbx:$PATH
export PATH=$JAVA_HOME/bin:$PATH
export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"

autoload -Uz colors
colors

bindkey -v

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

PROMPT="%c $ "

autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

autoload -Uz compinit
compinit

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

# vcs_info
autoload -Uz vcs_info
autoload -Uz add-zsh-hook
setopt prompt_subst

function _update_vcs_info_msg() {
    LANG=en_US.UTF-8 vcs_info
    RPROMPT="${vcs_info_msg_0_}"
}
add-zsh-hook precmd _update_vcs_info_msg

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '%F{yellow}'
zstyle ':vcs_info:*' unstagedstr '%f%F{blue}'
zstyle ':vcs_info:*' formats '%F{green}%c%u [%b]%f'
zstyle ':vcs_info:*' actionformats '%F{red} [%b|%a]%f'

setopt print_eight_bit
setopt no_beep
setopt no_flow_control
setopt ignore_eof
setopt interactive_comments
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt extended_glob

bindkey '^R' history-incremental-pattern-search-backward

alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
alias la='ls -al'
alias ll='ls -l'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias sudo='sudo '
alias -g L='| less'
alias -g G='| grep'

if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
    # Linux
    alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    # Cygwin
    alias -g C='| putclip'
fi

case ${OSTYPE} in
    darwin*)
        #For Mac
        export CLICOLOR=1
        alias ls='ls -G -F'
        ;;
    linux*)
        #For Linux
        alias ls='ls -F --color=auto'
        ;;
esac

attachToWearable() {
  adb -d forward tcp:5601 tcp:5601
}

# The next line updates PATH for the Google Cloud SDK.
source $HOME/Library/google-cloud-sdk/path.zsh.inc

# The next line enables shell command completion for gcloud.
source $HOME/Library/google-cloud-sdk/completion.zsh.inc
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
