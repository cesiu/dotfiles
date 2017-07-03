# cesiu

# Recolor the prompt.
export PS1="\[\033[1;36m\]\u\[\033[0m\]@\[\033[1;32m\]\h:\[\033[1;34m\]\w\[\033[m\]\$ "

# Color ls results; exact method depends on the OS.
TEMPLSCOLORS=ExFxBxHxCxegedabagacad
if [ "$OSTYPE" == "linux-gnu" ]; then 
    export LS_COLORS=$TEMPLSCOLORS
    alias ls='ls -h --color'
else
    export LSCOLORS=$TEMPLSCOLORS
    export CLICOLOR=1
    alias ls='ls -Gh'
fi

# I have fat fingers.
alias ks='ls'
alias l='ls'
alias sl='ls'

# Don't let those 101 classmates hijack your terminal during a lab quiz.
mesg n

# LaTeX should target PDFs.
alias latex='latex -output-format=pdf'

# Don't really need this anymore; thanks Professor Khosmood.
#alias untar='tar -zxvf'

# A long time ago in a galaxy far, far away..."
alias starwars='telnet towel.blinkenlights.nl'

# Load the old directory.
OLDPWD=$(cat ~/.oldpwd)

