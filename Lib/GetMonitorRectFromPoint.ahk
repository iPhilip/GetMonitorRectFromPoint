#Requires AutoHotkey v2

; -----------------------------------------------------------------------------
; GetMonitorRectFromPoint(X, Y)
;
; Gets the coordinates of the monitor containing or closest to the specified point.
;
; Author: iPhilip
;
; Parameters
;   1. X - The horizontal coordinate of the point.
;   2. Y - The vertical   coordinate of the point.
;
; Return Value:
;   An object literal with the following property names and values:
;     1. Left   - The horizontal coordinate of the monitor's left-most point.
;     2. Top    - The vertical   coordinate of the monitor's top-most point.
;     3. Right  - The horizontal coordinate of the monitor's right-most point.
;     4. Bottom - The vertical   coordinate of the monitor's bottom-most point.
; -----------------------------------------------------------------------------

GetMonitorRectFromPoint(X, Y) {
   static MonitorRects := GetMonitorRects()
   
   return MonitorRects[MonitorFromPoint(X, Y)]
   
   static MonitorFromPoint(X, Y) {
      static MONITOR_DEFAULTTONEAREST := 0x00000002
      return DllCall('User32.dll\MonitorFromPoint', 'Int64', (X & 0xFFFFFFFF) | (Y << 32), 'UInt', MONITOR_DEFAULTTONEAREST, 'Ptr')
   }
   
   static GetMonitorRects() {
      MonitorRects := Map()
      EnumProc := CallbackCreate(MonitorEnumProc)
      if !DllCall('User32.dll\EnumDisplayMonitors', 'Ptr', 0, 'Ptr', 0, 'Ptr', EnumProc, 'Ptr', ObjPtr(MonitorRects), 'Int')
         throw OSError('EnumDisplayMonitors failed.', -1)
      CallbackFree(EnumProc)
      return MonitorRects
   }
   
   static MonitorEnumProc(hMonitor, hDC, pRECT, ObjectAddr) {
      MonitorRects := ObjFromPtrAddRef(ObjectAddr)
      MonitorRects[hMonitor] := {Left: NumGet(pRECT, 0, 'Int'), Top: NumGet(pRECT, 4, 'Int'), Right: NumGet(pRECT, 8, 'Int'), Bottom: NumGet(pRECT, 12, 'Int')}
      return true
   }
}
