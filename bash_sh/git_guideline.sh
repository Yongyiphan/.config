#!/bin/bash

echo "Select a category to display useful Git commands:"
echo "1) Repository Setup"
echo "2) Branching"
echo "3) Staging and Committing"
echo "4) Remote Repositories"
echo "5) Inspection and Logs"
echo "6) Stashing"
echo "7) Rebasing and Merging"
echo "8) Undoing Changes"
echo "9) Submodules"

read -p "Enter the number corresponding to the category: " category

case $category in
  1)
    echo -e "\n== Repository Setup Commands =="
    echo "git init                            # Initialize a new Git repository"
    echo "git clone <url>                     # Clone a repository from a remote URL"
    echo "git remote add origin <url>         # Add a new remote repository"
    ;;
  2)
    echo -e "\n== Branching Commands =="
    echo "git branch                          # List all branches"
    echo "git branch <branch_name>            # Create a new branch"
    echo "git checkout <branch_name>          # Switch to a specific branch"
    echo "git checkout -b <branch_name>       # Create and switch to a new branch"
    echo "git branch -d <branch_name>         # Delete a local branch"
    ;;
  3)
    echo -e "\n== Staging and Committing Commands =="
    echo "git add <file>                      # Stage a specific file"
    echo "git add .                           # Stage all changes"
    echo "git commit -m \"<message>\"          # Commit staged changes with a message"
    echo "git commit --amend                  # Amend the previous commit"
    ;;
  4)
    echo -e "\n== Remote Repository Commands =="
    echo "git fetch                           # Fetch changes from the remote"
    echo "git pull                            # Pull changes from the remote"
    echo "git push                            # Push local changes to the remote"
    echo "git remote -v                       # Show the list of remote repositories"
    ;;
  5)
    echo -e "\n== Inspection and Log Commands =="
    echo "git status                          # Show the current status of the working directory"
    echo "git log                             # Show the commit history"
    echo "git diff                            # Show changes between working directory and index"
    echo "git show <commit>                   # Show details of a specific commit"
    ;;
  6)
    echo -e "\n== Stashing Commands =="
    echo "git stash                           # Save changes temporarily (stash)"
    echo "git stash pop                       # Apply stashed changes and remove the stash"
    echo "git stash list                      # List all stashed changes"
    echo "git stash drop                      # Drop a specific stash"
    ;;
  7)
    echo -e "\n== Rebasing and Merging Commands =="
    echo "git merge <branch_name>             # Merge a branch into the current branch"
    echo "git rebase <branch_name>            # Rebase the current branch onto another branch"
    echo "git rebase --continue               # Continue rebasing after resolving conflicts"
    echo "git merge --abort                   # Abort a merge in case of conflicts"
    ;;
  8)
    echo -e "\n== Undoing Changes Commands =="
    echo "git reset <file>                    # Unstage a file"
    echo "git checkout <file>                 # Discard changes in the working directory"
    echo "git reset --hard                    # Reset the index and working directory to the last commit"
    echo "git revert <commit>                 # Create a new commit that undoes the changes of a previous commit"
    ;;
	9)
		echo -e "\n== Git Submodule Commands =="
    echo "git submodule add <url>             # Add a new submodule"
    echo "git submodule update --init --recursive   # Initialize and update submodules"
    echo "git submodule foreach git pull origin main # Pull the latest changes for all submodules"
    echo "git submodule status                # Check the status of submodules"
    echo "git submodule deinit <path>         # Deinitialize a submodule"
    echo "git submodule sync                  # Synchronize submodules with the remote repository"
		;;
  *)
    echo "Invalid option. Please select a valid category."
    ;;
esac

