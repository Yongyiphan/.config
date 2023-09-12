alias git=git.exe
msedge(){
/mnt/c/Program\ Files\ \(x86\)/Microsoft/Edge/Application/msedge.exe "$@"
}
alias python=python3

alias git-ssh='git remote set-url origin "$(git remote get-url origin | sed -E '\''s,^https://([^/]*)/(.*)$,git@\1:\2,'\'')"'

alias git-https='git remote set-url origin "$(git remote get-url origin | sed -E '\''s,^git@([^:]*):/*(.*)$,https://\1/\2,'\'')"'

alias vm=nvim

alias au="sudo ~/.config/apt_update.sh"
alias sb="source ~/.bashrc"
alias enva="source ./env/bin/activate"
alias envd="deactivate"
alias py3="python3"
alias pip="pip3"
alias lg="lazygit"
rmlock(){
	if [ -d ".git" ]; then
		if [ -f ".git/index.lock" ]; then
			echo "Index.lock Found"
			sudo rm -rf .git/index.lock
			echo "Index.lock removed"
		else
			echo "Cannot find Index.lock"
		fi
	fi

}
alias rmlock=rmlock

echo "Sourced Bash Aliases"
