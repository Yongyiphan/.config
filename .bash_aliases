alias git=git.exe
alias edge="/mnt/c/Program\ Files\ \(x86\)/Microsoft/Edge/Application/msedge.exe"
msedge(){
/mnt/c/Program\ Files\ \(x86\)/Microsoft/Edge/Application/msedge.exe "$@"
}
alias python=python3

alias git-ssh='git remote set-url origin "$(git remote get-url origin | sed -E '\''s,^https://([^/]*)/(.*)$,git@\1:\2,'\'')"'

alias git-https='git remote set-url origin "$(git remote get-url origin | sed -E '\''s,^git@([^:]*):/*(.*)$,https://\1/\2,'\'')"'
