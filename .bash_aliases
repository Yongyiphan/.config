alias git=git.exe
msedge(){
/mnt/c/Program\ Files\ \(x86\)/Microsoft/Edge/Application/msedge.exe "$@"
}
alias python=python3

alias git-ssh='git remote set-url origin "$(git remote get-url origin | sed -E '\''s,^https://([^/]*)/(.*)$,git@\1:\2,'\'')"'

alias git-https='git remote set-url origin "$(git remote get-url origin | sed -E '\''s,^git@([^:]*):/*(.*)$,https://\1/\2,'\'')"'

alias vm=nvim
alias clang=clang-12
alias gcc="/usr/bin/gcc-10"
alias g++="/usr/bin/g++-10"


alias au="sudo ~/.config/apt_update.sh"
alias sb="source ~/.bashrc"
alias env_start="source ./env/bin/activate"

echo "Sourced Bash Aliases"
