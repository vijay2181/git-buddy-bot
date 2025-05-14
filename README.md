

### 🚀 **GitBuddy Bot – Features**

<img width="944" alt="Screenshot 2025-05-14 at 2 22 24 PM" src="https://github.com/user-attachments/assets/76adf57d-74cf-46b0-8f08-47a9ce674525" />


#### 🧑‍💻 1. **Maintainer Info**

* Clearly marked maintainer and script purpose at the top (`# Maintainer: Vijay`).
* Makes collaboration and reuse easy.

---

#### ⚡ 2. **Quick Mode**

* Run `./gitflow-bot.sh --quick "your commit message"` to:

  * Automatically stage all changes
  * Commit with a message
  * Push to the current branch
    ✅ Perfect for fast commits without interaction.

---

#### 📘 3. **Help Mode**

* Run `./gitflow-bot.sh --help` to view:

  * Available flags (`--quick`, `--help`)
  * How to use the script in different modes
    ✅ Great for onboarding new devs.

---

#### 🤖 4. **Interactive Menu-Driven Git Workflow**

* Step-by-step options with a friendly UI:

  * `1. Git add + commit + push`
  * `2. Run custom git commands`
  * `3. Exit`

---

#### 📁 5. **Flexible Git Add Options**

* Choose to:

  * Add all files with `git add -A`
  * Select specific files interactively

---

#### 🧠 6. **Smart Commit + Push Flow**

* Prompts for commit message
* Detects push failures
* On failure:

  * Offers pull strategy:

    * Merge
    * Rebase
    * Fast-forward only
* Re-attempts push after pulling
  ✅ Helps avoid common Git sync errors

---

#### 🛠️ 7. **Safe Custom Git Terminal**

* Option to run `diff`, `checkout`, `log`, etc.
* Type `done` to return safely
* Warns if `exit` is used accidentally

---

#### 🧼 8. **User-Friendly Output**

* Emojis for visual clarity 🧠
* Clear section separators
* Guided prompts for each operation

---

### 💡 Use Cases:

* Team members unfamiliar with Git commands
* Rapid commit-and-push during dev sprints
* Reducing push conflicts with safe pull strategies

