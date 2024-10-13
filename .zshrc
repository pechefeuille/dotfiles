echo -e "\n. $(brew --prefix asdf)/libexec/asdf.sh" >> ${ZDOTDIR:-~}/.zshrc

autoload -Uz colors
colors

bindkey -v

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

FOLDER_ICON=$'\uF07C'
RIGHT_BREAK_ICON=$'\uE0C8'
OCTOCAT_ICON=$'\uE708'
GHOST_ICON=$'\uE007'

setopt prompt_subst

# vcs_info
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' max-exports 3
zstyle ':vcs_info:git:*' stagedstr "+"
zstyle ':vcs_info:git:*' unstagedstr "-"
zstyle ':vcs_info:git:*' formats "%{$bg[white]%}%{$fg[black]%} $OCTOCAT_ICON %b%c%u  %{$reset_color%}%{$reset_color%}%{$fg[white]%}$RIGHT_BREAK_ICON%{$reset_color%}"
zstyle ':vcs_info:git:*' actionformats "%{$bg[red]%}%{$fg[white]%} $OCTOCAT_ICON %b%c%u  %{$reset_color%}%{$reset_color%}%{$fg[red]%}$RIGHT_BREAK_ICON%{$reset_color%}" "%a"

function _update_vcs_info_msg() {
    LANG=en_US.UTF-8 vcs_info
    if [[ -n "${vcs_info_msg_0_}" ]]; then
        if [[ -n "${vcs_info_msg_1_}" ]]; then
          echo "%{$fg[yellow]%}%{$bg[red]%}$RIGHT_BREAK_ICON%{$reset_color%}%{$reset_color%}${vcs_info_msg_0_}"
        else
          echo "%{$fg[yellow]%}%{$bg[white]%}$RIGHT_BREAK_ICON%{$reset_color%}%{$reset_color%}${vcs_info_msg_0_}"
        fi
    else
        echo "%{$fg[yellow]%}$RIGHT_BREAK_ICON%{$reset_color%}"
    fi
}

function _update_prompt() {
  echo "
%{$fg[black]%}%{$bg[yellow]%} $FOLDER_ICON  %~ %{$reset_color%}%{$reset_color%}`_update_vcs_info_msg` $GHOST_ICON  "
}

PROMPT='`_update_prompt`'

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

alias vi='env LANG=ja_JP.UTF-8 mvim -v "$@"'
alias vim='env LANG=ja_JP.UTF-8 mvim -v "$@"'
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
        #Mac用の設定
        export CLICOLOR=1
        alias ls='ls -G -F'
        ;;
    linux*)
        #Linux用の設定
        alias ls='ls -F --color=auto'
        ;;
esac

attachToWearable() {
  adb -d forward tcp:5601 tcp:5601
}

# Google Cloud SDK
source '/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'

eval "$(starship init zsh)"

. /opt/homebrew/opt/asdf/libexec/asdf.sh

. /opt/homebrew/opt/asdf/libexec/asdf.sh
