@echo off

call :colored MainApp: Green
git pull
echo ---

for /f %%d in ('dir /B /A:D %CD%') do (
    call :colored %%d: Green
    cd "%CD%\%%d"
    rd /s /q .git\refs\original
    rd /s /q .git\logs\
    git reflog expire --expire=now --all
    git gc --prune=now
    git gc --aggressive --prune=now
    echo ---
    cd..
)

@pause

:colored
%Windir%\System32\WindowsPowerShell\v1.0\Powershell.exe write-host -foregroundcolor %2 %1
