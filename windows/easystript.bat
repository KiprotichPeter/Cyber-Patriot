@echo off

echo.
echo ---------- Hope they work  ----------
echo ---                              ----
echo ---                              ----
echo ----------     Go Luck     ----------
:Options
echo. Enter options:
echo. 
echo 1) Passoword policy
echo 2) Audit Policy
echo 3) Disable guest and admin accounts
echo 4) Flush dns
echo 5) Firewall
echo 6) Windows automatic updates
echo 7) Remote desktop
echo 8) Windows defender
echo 9) Block External USB Storage
echo 10) Windows lockscreen timeout
echo 11) Windows Scan #Does not work find a way to fix it.
echo 12) Update apps
echo 20) exit
echo 30) Endings
echo. 

set /p input="Enter an option: "

if %input%==1 (
	goto Password policy
) else if %input%==2 (
	goto Audit Policy
) else if %input%==3 ( 
	goto Disable guest and admin accounts
) else if %input%==4 ( 
	goto Flush dns
) else if %input%==5 ( 
	goto Firewall
) else if %input%==6 ( 
	goto Windows automatic updates
) else if %input%==7 ( 
	goto Remote desktop
) else if %input%==8 ( 
	goto Windows_defender
) else if %input%==11 (
	goto Scan 
) else if %input%==12 (
	goto Apps_update
) else if %input%==20 ( 
	exit
) else if %input%==30 (
	goto :Endings
) else (
	cls
	echo Error!
	echo.
	echo.
	echo.
	echo Enter the rigth character!
)

:Password policy
echo Password policy starts here
net accounts
net accounts /uniquepw:5 >nul
net accounts /maxpwage:90 >nul
net accounts /minpwage:5 >nul
net accounts /minpwlen:14 >nul
net accounts /lockoutduration:30 >nul
net accounts /lockoutthreshold:5 >nul
#net accounts /lockoutwindows:10 >nul
gpupdate /force >nul
echo. Here are the results
echo.
net accounts
pause
goto Options

:Audit Policy 
echo Enabling success and failure in Audit Policy
auditpol /get /category:*
auditpol /set /category:* /success:enable
auditpol /set /category:* /failure:enable
echo Audit policy successfully executed
auditpol /get /category:*
pause 
goto Options



:Disable guest and admin accounts
echo Disabling and Enabling guest and admin accounts
net user Administrator /active:no
net user guest /active:no
pause
goto Options

:flush dns
echo Flushing the DNS
ipconfig /flushdns >nul
echo Flushing
echo DNS flush has been done.
pause 
goto option

:Firewall
echo Enabling firewall
echo To check your firewall: netsh > firewall > show state
netsh advfirewall set allprofiles state on >nul
netsh advfirewall firewall set rule name="Remote Assistance (DCOM-In)" new enable=no >nul
netsh advfirewall firewall set rule name="Remote Assistance (PNRP-In)" new enable=no >nul
netsh advfirewall firewall set rule name="Remote Assistance (RA Server TCP-In)" new enable=no >nul
netsh advfirewall firewall set rule name="Remote Assistance (SSDP TCP-In)" new enable=no >nul
netsh advfirewall firewall set rule name="Remote Assistance (SSDP UDP-In)" new enable=no >nul
netsh advfirewall firewall set rule name="Remote Assistance (TCP-In)" new enable=no >nul 
netsh advfirewall firewall set rule name="Telnet Server" new enable=no >nul
netsh advfirewall firewall set rule name="netcat" new enable=no >nul
echo Enabled
pause
goto Options

:Windows automatic updates
echo Enabling automatic updates
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v AUOptions /t REG_DWORD /d 0 /f #Enable automatic update
reg add "Hkey_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v AUOptions /t REG_DWORD /d 3 /f #Download updates but don't install automatically
#Do some research about bellow line.
#reg add HKLM_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU /v AutoInstallMinorUpdates /t REG_DWORD /d 1 /f

pause
goto Options

:Remote desktop
pause
goto Options

:Windows_defender
echo Will check update and update Microsoft Defender Antivirus
cd C:\ProgramData\Microsoft\Windows Defender\Platform\4.18.2202.4-0 
MpCmdRun -SignatureUpdate #Will check update and update Microsoft Defender Antivirus
#MpCmdRun -Scan -Scantype 1 "Quick scan"
#MpCmdRun -Scan -Scantype 2 "Full scan"
#MpCmdRun -Scan -Scantype -BootSectorScan "Quick scan
pause
goto Options

:Block USB
echo Enabling Block external USB Stoage Devices
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Servises\USBSTOR" /t Reg_dword /v Start /f /d 4 #Four will disable it while three will enable it
pause 
goto Options

:Scan
echo Doing windows scan
sfc /scannow 
echo windows scanning complited 
pause 
goto Options

:Apps_update
Echo Updating firefox
#winget upgrade  -h --id  Mozilla.Firefox 
winget upgrade -h --all
pause 
goto Options





:Endings
cls
echo           ----------Finished----------
echo           ---                      ---
echo           ---                      --- 
echo           -----------Go Luck---------- 



