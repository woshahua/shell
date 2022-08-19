export GOPATH=$(go env GOPATH)
export PATH=$PATH:$GOPATH/bin

function peco-src() {
  local src=$(ghq list --full-path | peco --query "$LBUFFER")
  if [ -n "$src" ]; then
    BUFFER="cd $src"
    zle accept-line
  fi
  zle -R -c
}
zle -N peco-src
bindkey '^]' peco-src


function git_branch_name()
{
  branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
  if [[ $branch == "" ]];
  then
    :
  else
    echo '- ('$branch')'
  fi
}

# Enable substitution in the prompt.
setopt prompt_subst

# Config for prompt. PS1 synonym.
prompt='%2/ $(git_branch_name) > '

if [[ -s $HOME/.rvm/scripts/rvm ]] ; then source $HOME/.rvm/scripts/rvm ; fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

alias derived='cd ~/Library/Developer/Xcode/DerivedData/'
alias zsync='source ~/.zshrc'

# start tmux on default
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi

# vim
alias vi=nvim

export PATH=$PATH:/Applications/"Android Studio.app"/Contents/jre/Contents/Home/bin
export JAVA_HOME=/Applications/"Android Studio.app"/Contents/jre/Contents/Home
