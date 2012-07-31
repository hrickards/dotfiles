#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Always show coloured output out of ls
alias ls='ls --color'

# Show the current git branch in the PS!
PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '

# Add RVM and the bin directoryto path
PATH=$PATH:$HOME/.rvm/bin:$HOME/bin

# Set default editor
EDITOR=vim

# Variables for current working (as in project, not pwd) directory
CWNAME=Pheme
CWDIR=$HOME/code/$CWNAME

# ack | less, but coloured
alias ackl='ACK_PAGER_COLOR="less -x4SRFX" ack'

# git aliases
alias gst='git status'
alias gc='git commit'
alias ga='git add'

# Go to current working directory (see $CWNAME and $CWDIR above)
alias cw='cd $CWDIR'

# bundle aliases
alias bi='bundle install'
alias bu='bundle update'
alias be='bundle exec'

# run rackup with the first non-127.0.0.1 IP
alias s="rerun -- rackup config.ru -o `ifconfig | grep "inet " | awk ' { if ($2 != \"127.0.0.1\") print $2 } ' | head -n 1`"

# fixes problems with muscle memory and singular commands
alias beets=beet
