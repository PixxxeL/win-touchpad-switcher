set KEY=HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\PrecisionTouchPad\Status

reg query %key%
reg add %key% /v Enabled /d 0 /f /t REG_DWORD
