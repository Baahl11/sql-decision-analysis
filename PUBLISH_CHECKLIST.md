# Publish Checklist - sql-decision-analysis

## 1) Validate locally
- Run `./run.ps1`
- Confirm `analysis/query-output.txt` is updated
- Review `analysis/decision-memo.md`

## 2) Initialize repository
```powershell
git init
git add .
git commit -m "feat: initial SQL decision analysis tutorial project"
```

## 3) Create remote repository
- Create a new GitHub repository named `sql-decision-analysis`.
- Do not add README/license from GitHub UI (already included locally).

## 4) Push
```powershell
git branch -M main
git remote add origin <YOUR_GITHUB_REPO_URL>
git push -u origin main
```

## 5) Final recruiter polish
- Add 1-2 screenshots to README (terminal output or charts)
- Pin repository on your GitHub profile
- Add project link to CV and LinkedIn featured section
