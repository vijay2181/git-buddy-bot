#!/bin/bash
# ============================================
# 🤖 GitBuddy Bot Script
# Maintainer: Vijay
# Description: Interactive or quick Git workflow helper
# ============================================

#Quick or Help Mode
if [[ "$1" == "--help" ]]; then
    echo "📘 GitFlow Bot Help"
    echo "----------------------------"
    echo "--help     Show this help message"
    echo "--quick    Quickly add + commit + push with one prompt"
    echo "           e.g., ./gitflow-bot.sh --quick 'your commit message'"
    exit 0
fi

if [[ "$1" == "--quick" ]]; then
    commit_msg="$2"
    if [[ -z "$commit_msg" ]]; then
        read -p "✏️ Enter commit message: " commit_msg
    fi

    git add -A
    git commit -m "$commit_msg"
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    echo "🚀 Pushing to $current_branch..."
    git push origin "$current_branch"
    exit 0
fi

#Interactive Loop
while true; do
    echo "🔍 Checking current Git branch:"
    git branch

    echo -e "\n📦 Git status:"
    git status

    echo -e "\n❓ What do you want to do?"
    echo "1. Proceed to git add + commit + push"
    echo "2. Run custom git commands (e.g., diff, log, checkout)"
    echo "3. Exit"
    read -p "Enter choice [1/2/3]: " choice

    case "$choice" in
        1)
            echo -e "\n📁 Git Add Options:"
            echo "1. git add -A (stage all changes)"
            echo "2. git add specific files"
            read -p "Enter choice [1/2]: " add_choice

            if [[ "$add_choice" == "1" ]]; then
                git add -A
            elif [[ "$add_choice" == "2" ]]; then
                read -p "Enter filenames (space-separated): " files
                git add $files
            else
                echo "❌ Invalid choice. Going back..."
                continue
            fi

            read -p "✏️ Enter commit message: " commit_msg
            git commit -m "$commit_msg"

            current_branch=$(git rev-parse --abbrev-ref HEAD)
            echo "🚀 Pushing to $current_branch..."
            git push origin "$current_branch"
            push_status=$?

            if [[ $push_status -ne 0 ]]; then
                echo -e "\n❌ Push failed due to remote updates. You need to pull first."
                echo "💡 Choose how you'd like to pull changes:"
                echo "1. Merge (safe, default)"
                echo "2. Rebase (cleaner history)"
                echo "3. Fast-forward only (abort if history diverged)"
                read -p "Enter choice [1/2/3]: " pull_choice

                case "$pull_choice" in
                    1) git config --global pull.rebase false ;;
                    2) git config --global pull.rebase true ;;
                    3) git config --global pull.ff only ;;
                    *) echo "Invalid choice. Defaulting to merge."; git config --global pull.rebase false ;;
                esac

                echo "📥 Pulling latest changes..."
                git pull

                echo "🚀 Re-attempting push..."
                git push origin "$current_branch"
            fi

            echo "✅ Done. Returning to main menu..."
            ;;
        2)
            echo -e "\n💡 Custom git terminal (type 'done' to return to main menu)"
            while true; do
                read -p "cmd> " user_cmd
                if [[ "$user_cmd" == "done" ]]; then
                    break
                elif [[ "$user_cmd" == "exit" ]]; then
                    echo "⚠️  Use 'done' to return. 'exit' will terminate the script."
                else
                    eval "$user_cmd"
                fi
            done
            ;;
        3)
            echo "👋 Exiting..."
            break
            ;;
        *)
            echo "❌ Invalid choice. Try again."
            ;;
    esac
done
