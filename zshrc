# /usr/local/bin/zsh
plugins=(git docker docker-compose nvm)

eval "$(/opt/homebrew/bin/brew shellenv)"

# Load alias definitions
[[ -s "$HOME/_src/z_dotfiles/dotfiles/aliases/.aliases" ]] && source "$HOME/_src/z_dotfiles/dotfiles/aliases/.aliases"
[[ -s "$HOME/_src/z_dotfiles/dotfiles/aliases/.client_specific_aliases" ]] && source "$HOME/_src/z_dotfiles/dotfiles/aliases/.client_specific_aliases"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Edit Everything in WebStorm
export WEBSTORM="webstorm --wait"
export EDITOR="$WEBSTORM"

export AWS_PROFILE=59A-Dev

# Allow aws-sdk to use aws CLI config
export AWS_SDK_LOAD_CONFIG=true

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

# pnpm
export PNPM_HOME="/Users/barns/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
