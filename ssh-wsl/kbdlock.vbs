Set WinScriptHost = CreateObject("WScript.Shell")
value = WinScriptHost.Run("powershell.exe -NonInteractive -NoProfile -Command ""& {exit ([Int32][console]::CapsLock + 2*[Int32][console]::NumberLock)}""", 0, true)
Set WinScriptHost = Nothing
WScript.Quit(value)
