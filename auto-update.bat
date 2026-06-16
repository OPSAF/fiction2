@echo off
chcp 65001 > nul

git add -A
git diff --cached --quiet
if errorlevel 1 (
    git commit -m "update"
    git push || git push --set-upstream origin master
    echo Done: committed and pushed.
) else (
    echo No changes to commit.
)
pause