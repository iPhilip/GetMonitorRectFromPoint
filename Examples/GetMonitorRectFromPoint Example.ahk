#Requires AutoHotkey v2.0
#Include ..\Lib\GetMonitorRectFromPoint
CoordMode 'Mouse', 'Screen'

try DllCall('User32.dll\SetThreadDpiAwarenessContext', 'Ptr', DPI_AWARENESS_CONTEXT_PER_MONITOR_AWARE := -3, 'Ptr')  ; Requires Windows 10, version 1607 or later.

F3::
{
   MouseGetPos &X, &Y
   MonitorRect := GetMonitorRectFromPoint(X, Y)
   MsgBox 'Coordinates of the monitor at (' X ',' Y '):`n'
        . 'Left:`t'   MonitorRect.Left '`n'
        . 'Top:`t'    MonitorRect.Top '`n'
        . 'Right:`t'  MonitorRect.Right '`n'
        . 'Bottom:`t' MonitorRect.Bottom
}

Esc::ExitApp
