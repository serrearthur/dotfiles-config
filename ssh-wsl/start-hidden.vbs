Dim WinScriptHost
Set WinScriptHost = CreateObject("WScript.Shell")
WinScriptHost.Run WScript.Arguments(0), 0, TRUE
Set WinScriptHost = Nothing
