alias git=git.exe
msedge(){
/mnt/c/Program\ Files\ \(x86\)/Microsoft/Edge/Application/msedge.exe "$@"
}
alias python=python3

alias git-ssh='git remote set-url origin "$(git remote get-url origin | sed -E '\''s,^https://([^/]*)/(.*)$,git@\1:\2,'\'')"'

alias git-https='git remote set-url origin "$(git remote get-url origin | sed -E '\''s,^git@([^:]*):/*(.*)$,https://\1/\2,'\'')"'

alias vm=nvim
#alias clang=clang-12
alias gcc="/usr/bin/gcc-10"
alias g++="/usr/bin/g++-10"


alias au="sudo ~/.config/bash_sh/apt_update.sh"
alias sb="source ~/.bashrc"
alias enva="source ./env/bin/activate"
alias envd="deactivate"
alias py3="python3"
alias pip="pip3"
alias lg="lazygit"

export LANG=en_US.UTF-8
echo "Sourced Bash Aliases"
