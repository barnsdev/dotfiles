# Fig pre block. Keep at the top of this file.
. "$HOME/.fig/shell/zshrc.pre.zsh"
# /usr/local/bin/zsh
plugins=(git docker docker-compose nvm)

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

# Load aliases definitions
[[ -s "$HOME/_src/z_dotfiles/dotfiles/.aliases" ]] && source "$HOME/_src/z_dotfiles/dotfiles/.aliases"
[[ -s "$HOME/_src/z_dotfiles/dotfiles/.user_specific_aliases" ]] && source "$HOME/_src/z_dotfiles/dotfiles/.user_specific_aliases"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Edit Everything in WebStorm
export WEBSTORM="webstorm --wait"
export EDITOR="$WEBSTORM"

# # Python
# if command -v pyenv 1>/dev/null 2>&1; then
#   eval "$(pyenv init -)"
# fi
# PATH=$(pyenv root)/shims:$PATH

# Android Tools
export ANDROID_SDK_ROOT="$(brew --prefix)/share/android-sdk"
export ANDROID_HOME=$ANDROID_SDK_ROOT
export PATH="$PATH:$ANDROID_HOME/emulator"
export PATH="$PATH:$ANDROID_HOME/platform-tools"
export PATH="$PATH:$ANDROID_HOME/tools"
export PATH="$PATH:$ANDROID_HOME/tools/bin"

# Allow aws-sdk to use aws CLI config
export AWS_SDK_LOAD_CONFIG=true

# AWS Session Token
export awssessiontoken() {
  creds=`aws sts get-session-token \
  --duration-seconds=57600 \
  --serial-number={YOUR_AWS_MFA_ARN} \
  --token-code=$1 | jq -r '.Credentials'`;

  secretAccessKey=$( jq -r  '.SecretAccessKey' <<< "${creds}" );
  sessionToken=$( jq -r  '.SessionToken' <<< "${creds}" );

  echo $accessKeyId;
  echo $secretAccessKey;
  echo $sessionToken;

  export AWS_ACCESS_KEY_ID=$( jq -r  '.AccessKeyId' <<< "${creds}" );
  export AWS_SECRET_ACCESS_KEY=$secretAccessKey;
  export AWS_SESSION_TOKEN=$sessionToken;
}

# DOCKER
export d_container() {
  REGEX=$1
  docker ps --no-trunc | grep ${REGEX} | awk '{print $1}'
}
export d_exec_bash() {
  docker exec -it `d_container $1` bash
}
export d_exec_sh() {
  docker exec -it `d_container $1` sh
}
export d_logs() {
  docker logs -f `d_container $1`
}
export d_kill_containers() {
  CONTAINERS=$(docker ps -q)
  if [ -z "$CONTAINERS" ]; then
    echo "No containers running"
    return 0
  fi
  docker kill $(docker ps -q)
}
export d_rm_containers() {
  CONTAINERS=$(docker ps -a -q)
  if [ -z "$CONTAINERS" ]; then
    echo "No containers present"
    return 0
  fi
  docker rm $(docker ps -a -q)
}
export d_rm_images() {
  IMAGES=$(docker images --format "{{.ID}}")
  if [ -z "$IMAGES" ]; then
    echo "No images present"
    return 0
  fi
  docker rmi $(docker images --format "{{.ID}}")
}

# K8s
export k_ns() {
  kubectl get pods -A | grep -m1 $1 | awk '{print $1}'
}
export k_pod() {
  kubectl -n `k_ns $1` get pods | grep -m1 $2 | awk '{print $1}'
}
export k_exec_bash() {
  kubectl -n `k_ns $1` exec -it `k_pod $1 $2` -- /bin/bash
}
export k_exec_sh() {
  kubectl -n `k_ns $1` exec -it `k_pod $1 $2` -- /bin/sh
}
export k_logs() {
  kubectl -n `k_ns $1` logs -f `k_pod $1 $2`
}

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# COMPLETIONS
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i

nvmrc_check() {
  if [[ $PWD == $PREV_PWD ]]; then
    return
  fi

  PREV_PWD=$PWD
  if [[ -f ".nvmrc" ]]; then
    nvm use
    NVM_DIRTY=true
  elif [[ $NVM_DIRTY = true ]]; then
      nvm use default
      NVM_DIRTY=false
  fi
}

# Load git prompt script from https://github.com/lyze/posh-git-sh
source ~/_src/z_dotfiles/dotfiles/bin/git-prompt.sh

NEWLINE=$'\n'

precmd() {
  nvmrc_check
  __posh_git_ps1 "%F{black}%K{white} /^\_/^\ =======>%F{green}%K{black} %D{%f/%m/%y}-%T - %3d/ =>" "‍${NEWLINE}  🏉  🤓  🚀  =>"
}

# Postgres
# export PGDATA="/usr/local/Cellar/postgresql/13.4/data"

# Ruby
export PATH="/usr/local/opt/ruby/bin:$PATH"

# Stint Functions
export postgresrestore() {
  docker-compose exec postgres restore $1
}

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true

export PATH="$HOME/.poetry/bin:$PATH"

export PYTHONDONTWRITEBYTECODE=please

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Fig post block. Keep at the bottom of this file.
. "$HOME/.fig/shell/zshrc.post.zsh"
