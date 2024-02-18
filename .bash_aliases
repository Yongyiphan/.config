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
alias gremote="git remote -v"
rmlf(){
	echo "Changing $1"
	sed -i -e "s/\r//g" "$1"
}
alias rmlf=rmlf
alias attach="tmux attach -t"
alias detach="if [ -n "$TMUX" ]; then tmux detach; else exit; fi"

goto(){
	local target_dir="$1"
    # Base directory containing user folders
    local users_base_dir="/mnt/c/Users"
    local ignore_file="$HOME/.config/.bash_find_ignore"

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
