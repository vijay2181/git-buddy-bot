
# 🛠️ Git Power Tool – Local DevOps Engineer’s Swiss Army Knife

A **robust Bash script** that supercharges your local Git workflows. Designed as a **DevOps engineer’s power tool**, it combines Git best practices, safe checks, and time-saving commands into one utility.

---

## 🚀 Features

* **Safe Commits & Pushes**

  * Warns if you’re pushing directly to `main`/`master`.
  * Prompts for confirmation before overwriting history.

* **Quick Branch Management**

  * Create, switch, delete, and list branches safely.
  * Protects main/master from accidental deletion.

* **Commit with Messages in One Command**

  * `git-tool commit "message"` → adds & commits tracked changes.

* **Undo/Reset Made Easy**

  * Undo last commit without losing changes.
  * Hard reset with confirmation prompt.

* **Stash Like a Pro**

  * Save, list, and pop stashes easily.

* **Enhanced Status & Logs**

  * Clean, colorized status.
  * Pretty Git log with graph view.

* **Built-in Safety Checks**

  * Checks if Git is installed.
  * Ensures script is run inside a Git repo.
  * Protects important branches.

---

## 📦 Installation

```bash
#Clone your dotfiles/tools repo or copy the script locally
git clone https://github.com/yourusername/git-buddy-bot.git

#Make script executable
chmod +x git-buddy-bot.sh

#Add to PATH (optional)
sudo mv git-buddy-bot.sh /usr/local/bin/git-buddy-bot
```

Now you can run `git-buddy-bot` from anywhere.

---

## 🖥️ Usage

### 🔍 Check status

```bash
git-tool status
```

➡️ Shows clean status with branch & staged/unstaged changes.

---

### 📖 Log with Graph

```bash
git-tool log
```

➡️ Colorized, graph view:

```
* commit c1a2b3d (HEAD -> feature-x)
| Author: DevOps Engineer
| Date:   Tue Sep 9 14:00 2025
|   Added deployment script
```

---

### 🌱 Branch Management

```bash
git-tool branch new-feature
```

➡️ Creates and switches to `new-feature` branch.

```bash
git-tool branch
```

➡️ Lists all branches with current one highlighted.

```bash
git-tool delete old-feature
```

➡️ Deletes branch safely (but won’t delete `main`/`master`).

---

### 💾 Commit Changes

```bash
git-tool commit "Update CI pipeline"
```

➡️ Stages and commits changes in one go.

---

### 📤 Safe Push

```bash
git-tool push
```

➡️ Pushes current branch safely.
⚠️ If branch is `main` or `master`, asks for confirmation.

---

### 🕰️ Undo Last Commit

```bash
git-tool undo
```

➡️ Resets last commit but keeps changes staged.

---

### 🎒 Stash Management

```bash
git-tool stash "WIP: debugging build issue"
git-tool stash-list
git-tool stash-pop
```

---

## ⚠️ Limitations

* Requires **Git installed** and available in `$PATH`.
* Designed for **local use**, not GitHub/GitLab API automation.
* Basic error handling (not a full CLI framework).
* Does not include **cloud provider integrations (AWS/GCP/Azure)**.

---

## 🛡️ Safety Features

* Blocks accidental push/deletion of protected branches (`main`, `master`).
* Confirms before running destructive commands (`reset`, `delete`).
* Validates you are inside a Git repo before execution.

---

## 📚 Example Workflow

```bash
# Create new branch
git-tool branch feature-ci-fix

# Make changes, commit in one go
git-tool commit "Fix: updated Tekton pipeline"

# Push branch safely
git-tool push

# Merge done → delete branch
git-tool delete feature-ci-fix
```

---

## 🎯 Why Use This Tool?

Instead of remembering 10+ Git commands and flags,
👉 you get a **single, safe, DevOps-focused Git helper**.

Perfect for:

* Local feature development
* Quick hotfixes
* Safer Git operations without fear of mistakes

---

🔥 Pro tip: Alias it as `g` → `alias g="git-tool"` → so you can type `g status`, `g commit "msg"`, etc.
