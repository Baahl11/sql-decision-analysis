# Publish Checklist - sql-decision-analysis

## 1) Validate locally (why: prove reproducibility)
- Run `.\run.ps1`
- Confirm `analysis/query-output.txt` is updated
- Review `analysis/decision-memo.md`

What this step proves:
- The project runs end-to-end in a clean environment.
- Your analysis output is consistent before publishing.

## 2) Initialize repository (why: start independent git history)
```powershell
git init
git add .
git commit -m "feat: initial SQL decision analysis tutorial project"
```

What this step does:
- `git init`: creates a local repository in this folder.
- `git add .`: stages all files for the first snapshot.
- `git commit`: creates your first versioned checkpoint.

## 3) Create remote repository (why: destination on GitHub)
- Create a new GitHub repository named `sql-decision-analysis`.
- Do not add README/license from GitHub UI (already included locally).

GH CLI alternative (recommended):
```powershell
gh repo create <YOUR_USER>/sql-decision-analysis --public --source . --remote origin --push
```

Note:
- This requires GitHub authentication in browser.
- In this session, remote auto-creation was blocked because no active GitHub login/token is available.

## 4) Connect and push (why: upload local history)
```powershell
git branch -M main
git remote add origin <YOUR_GITHUB_REPO_URL>
git push -u origin main
```

One-command alternative:
```powershell
.\publish.ps1 -RemoteUrl <YOUR_GITHUB_REPO_URL>
```

If `gh repo create ... --push` creates the repo but does not push because `origin` already exists:
```powershell
git push -u origin main
```

What this step does:
- `git branch -M main`: guarantees default branch name.
- `git remote add origin ...`: links local repo to GitHub repo.
- `git push -u origin main`: uploads commits and sets tracking.

## 5) Final recruiter polish (why: improve interview conversion)
- Add 1-2 screenshots to README (terminal output or charts)
- Pin repository on your GitHub profile
- Add project link to CV and LinkedIn featured section
