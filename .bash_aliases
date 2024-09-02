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
alias fd='fd --color=never'
alias ls='ls --color=never'
alias grep='grep --color=never'
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
alias gremote="git remote -v"
rmlf(){
	echo "Changing $1"
	sed -i -e "s/\r//g" "$1"
}
alias rmlf=rmlf
alias attach="tmux attach -t"
alias detach="if [ -n "$TMUX" ]; then tmux detach; else exit; fi"

declare -A gotoPaths
gotoPaths["config"]="$HOME/.config"
gotoPaths["nvim"]="$HOME/.config/nvim"

goto(){
	local target_dir="$1"
	# Base directory containing user folders
	local users_base_dir="/mnt/c/Users"
	local ignore_file="$HOME/.config/.bash_find_ignore"

	# Check if the target directory is a key in the associative array
	if [[ -n "${gotoPaths[$target_dir]}" ]]; then
		cd "${gotoPaths[$target_dir]}" || return
		return
	fi

	if ! command -v fd &> /dev/null; then
			echo "fd is not installed. Please install fd first."
			return 1
	fi


	# Initialize an array to store the paths of all 'Documents' directories
	local documents_dirs=()

	# Iterate over each directory in /mnt/c/Users to find 'Documents' folders
	for user_dir in "$users_base_dir"/*/; do
			if [ -d "${user_dir}Documents" ]; then
					documents_dirs+=("${user_dir}Documents")
			fi
	done

	# Check if no 'Documents' directories were found
	if [ ${#documents_dirs[@]} -eq 0 ]; then
			echo "No 'Documents' directories found under /mnt/c/Users."
			return 1
	fi

	# Initialize an array to hold the search results
	local search_results=()

	# Search for the target directory within each 'Documents' directory
	for doc_dir in "${documents_dirs[@]}"; do
			while IFS= read -r line; do
					search_results+=("$line")
			done < <(fd --type d --ignore-file "$ignore_file" --fixed-strings "$target_dir" "$doc_dir" 2>/dev/null)
	done

	# Use fzf to select from the search results
	local dir=$(printf "%s\n" "${search_results[@]}" | fzf --query="$target_dir" --select-1 --exit-0)

	if [ -z "$dir" ]; then
			echo "No directory found or selected."
			return 1
	fi

	# Change to the selected directory
	cd "$dir" || return
}

echo "Sourced Bash Aliases"

refresh_gitignore(){

	local CMDID="$1"
	# Ensure we're in a git repository
	if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
			echo "Not a git repository. Please run this function from within a git repo."
			return 1
	fi

	# Update the git index by removing all cached files
	git rm -r --cached .

	# Re-add all files, respecting the updated .gitignore
	git add .

	if [ $CMDID = 'commit' ]; then
		# Commit the changes
		git commit -m "Refresh .gitignore changes"
		echo ".gitignore changes have been refreshed and committed."
	fi

}

import_brew(){
	source $HOME/.config/bash_sh/sync_brew.sh
	import_brew
}

export_brew(){
	source $HOME/.config/bash_sh/sync_brew.sh
	export_brew
}
