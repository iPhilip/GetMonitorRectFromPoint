#Requires AutoHotkey v2
#Include ..\Lib\GetMonitorRectFromPoint>

MonitorRect := GetMonitorRectFromPoint(0,0)
MsgBox 'Monitor coordinates`nLeft:`t' MonitorRect.Left '`nTop:`t' MonitorRect.Top '`nRight:`t' MonitorRect.Right '`nBottom:`t' MonitorRect.Bottom
