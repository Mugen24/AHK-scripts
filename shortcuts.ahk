#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
EnvGet, HOME, HomePath

vivaldi := HOME . "\AppData\Local\Vivaldi\Application\vivaldi"
vscode := "C:\Program Files\Microsoft VS Code\code"

#v:: Run, vivaldi
#c:: Run, vscode