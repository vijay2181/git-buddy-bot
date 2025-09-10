#!/bin/bash
# ============================================
# 🤖 GitBuddy Bot v2
# Maintainer: Vijay
# Description: Robust Git workflow helper (Quick + Interactive)
# ============================================

set -euo pipefail

# --- Safety Checks ---
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || {
    echo "❌ Not inside a Git repository!"
    exit 1
}

# --- Functions ---
check_lint() {
    staged=$(git diff --cached --name-only)
    for f in $staged; do
        if [[ $f == *.yml || $f == *.yaml ]]; then
            if command -v yamllint >/dev/null 2>&1; then
                yamllint "$f" || { echo "❌ YAML lint failed on $f"; exit 1; }
            else
                echo "⚠️  yamllint not installed, skipping check for $f"
            fi
        elif [[ $f == *.json ]]; then
            jq . "$f" >/dev/null 2>&1 || { echo "❌ Invalid JSON in $f"; exit 1; }
        fi
    done
}

safe_commit() {
    local msg="$1"
    if [[ -z "$msg" ]]; then
        echo "❌ Commit message cannot be empty."
        exit 1
    fi
    if [[ "$msg" == *"WIP"* && "${2:-}" != "--force" ]]; then
        echo "⚠️ WIP commit blocked. Use '--force' to override."
        exit 1
    fi
    check_lint
    git commit -m "$msg"
}

safe_push() {
    local branch
    branch=$(git rev-parse --abbrev-ref HEAD)
    echo "🚀 Pushing to $branch..."
    if ! git push origin "$branch"; then
        echo -e "\n❌ Push failed due to remote updates."
        echo "💡 Choose how you'd like to pull changes:"
        echo "1. Merge (safe, default)"
        echo "2. Rebase (cleaner history)"
        echo "3. Fast-forward only (abort if diverged)"
        read -p "Enter choice [1/2/3]: " pull_choice

        case "$pull_choice" in
            1) git -c pull.rebase=false pull ;;
            2) git -c pull.rebase=true pull ;;
            3) git -c pull.ff=only pull ;;
            *) echo "Invalid choice. Defaulting to merge."; git -c pull.rebase=false pull ;;
        esac

        echo "🚀 Re-attempting push..."
        git push origin "$branch"
    fi
}

undo_last_commit() {
    echo "⚠️ Undoing last commit but keeping changes staged..."
    git reset --soft HEAD~1
}

show_stats() {
    echo "📊 Commit stats (last 30 days):"
    git log --since="30 days ago" --pretty=format:"%an" | sort | uniq -c | sort -nr
    echo -e "\n🔥 Top files by changes:"
    git log --name-only --pretty=format: | sort | uniq -c | sort -nr | head -10
}

# --- CLI Mode ---
if [[ "${1:-}" == "--help" ]]; then
    cat <<EOF
📘 GitBuddy Bot Help
----------------------------
--help       Show this help message
--quick MSG  Quickly add + commit + push
--force      Allow WIP commit in quick mode
undo         Undo last commit (keep changes staged)
stats        Show repo stats (contributors, hot files)
EOF
    exit 0
fi

if [[ "${1:-}" == "--quick" ]]; then
    commit_msg="${2:-}"
    if [[ -z "$commit_msg" ]]; then
        read -p "✏️ Enter commit message: " commit_msg
    fi
    git add -A
    safe_commit "$commit_msg" "${3:-}"
    safe_push
    exit 0
fi

if [[ "${1:-}" == "undo" ]]; then
    undo_last_commit
    exit 0
fi

if [[ "${1:-}" == "stats" ]]; then
    show_stats
    exit 0
fi

# --- Interactive Mode ---
while true; do
    echo "🔍 Current branch: $(git rev-parse --abbrev-ref HEAD)"
    echo -e "\n📦 Git status:"
    git status -s

    echo -e "\n❓ What do you want to do?"
    echo "1. Add + Commit + Push"
    echo "2. Run custom git commands"
    echo "3. Undo last commit"
    echo "4. Show repo stats"
    echo "5. Exit"
    read -p "Enter choice [1-5]: " choice

    case "$choice" in
        1)
            echo -e "\n📁 Add Options:"
            echo "1. Add all changes"
            echo "2. Add specific files"
            read -p "Enter choice [1/2]: " add_choice

            if [[ "$add_choice" == "1" ]]; then
                git add -A
            elif [[ "$add_choice" == "2" ]]; then
                read -p "Enter filenames: " files
                git add $files
            else
                echo "❌ Invalid choice."
                continue
            fi

            read -p "✏️ Commit message: " commit_msg
            safe_commit "$commit_msg"
            safe_push
            echo "✅ Done."
            ;;
        2)
            echo "💡 Custom git terminal (type 'done' to return)"
            while true; do
                read -p "git> " user_cmd
                if [[ "$user_cmd" == "done" ]]; then break; fi
                eval "git $user_cmd"
            done
            ;;
        3) undo_last_commit ;;
        4) show_stats ;;
        5) echo "👋 Exiting..."; break ;;
        *) echo "❌ Invalid choice." ;;
    esac
done
