@echo off
chcp 65001 >nul
color 01


echo.
 
echo 			███▄    █  ▒█████   ▒█████   ▄▄▄▄    ▄▄▄▄    ▒█████  ▒██   ██▒▒███████▒
echo 			██ ▀█   █ ▒██▒  ██▒▒██▒  ██▒▓█████▄ ▓█████▄ ▒██▒  ██▒▒▒ █ █ ▒░▒ ▒ ▒ ▄▀░
echo 			▓██  ▀█ ██▒▒██░  ██▒▒██░  ██▒▒██▒ ▄██▒██▒ ▄██▒██░  ██▒░░  █   ░░ ▒ ▄▀▒░ 
echo 			▓██▒  ▐▌██▒▒██   ██░▒██   ██░▒██░█▀  ▒██░█▀  ▒██   ██░ ░ █ █ ▒   ▄▀▒   ░
echo 			▒██░   ▓██░░ ████▓▒░░ ████▓▒░░▓█  ▀█▓░▓█  ▀█▓░ ████▓▒░▒██▒ ▒██▒▒███████▒
echo 			░ ▒░   ▒ ▒ ░ ▒░▒░▒░ ░ ▒░▒░▒░ ░▒▓███▀▒░▒▓███▀▒░ ▒░▒░▒░ ▒▒ ░ ░▓ ░░▒▒ ▓░▒░▒
echo 			░ ░░   ░ ▒░  ░ ▒ ▒░   ░ ▒ ▒░ ▒░▒   ░ ▒░▒   ░   ░ ▒ ▒░ ░░   ░▒ ░░░▒ ▒ ░ ▒
echo 	 		  ░   ░ ░ ░ ░ ░ ▒  ░ ░ ░ ▒   ░    ░  ░    ░ ░ ░ ░ ▒   ░    ░  ░ ░ ░ ░ ░
echo 	    		     ░     ░ ░      ░ ░   ░       ░          ░ ░   ░    ░    ░ ░    
echo  	     		                            ░       ░                   ░       
echo			     	   ██████   ██████    ▄▄▄█████▓ ▒█████   ▒█████   ██▓    
echo			    	  ▒██    ▒ ▒██    ▒    ▓  ██▒ ▓▒▒██▒  ██▒▒██▒  ██▒▓██▒    
echo			     	 ░ ▓██▄   ░ ▓██▄      ▒ ▓██░ ▒░▒██░  ██▒▒██░  ██▒▒██░    
echo			     	   ▒   ██▒  ▒   ██▒   ░ ▓██▓ ░ ▒██   ██░▒██   ██░▒██░    
echo			     	 ▒██████▒▒▒██████▒▒     ▒██▒ ░ ░ ████▓▒░░ ████▓▒░░██████▒
echo			    	  ▒ ▒▓▒ ▒ ░▒ ▒▓▒ ▒ ░     ▒ ░░   ░ ▒░▒░▒░ ░ ▒░▒░▒░ ░ ▒░▓  ░
echo			    	  ░ ░▒  ░ ░░ ░▒  ░ ░       ░      ░ ▒ ▒░   ░ ▒ ▒░ ░ ░ ▒  ░
echo			    	  ░  ░  ░  ░  ░  ░       ░      ░ ░ ░ ▒  ░ ░ ░ ▒    ░ ░   
echo			    	        ░        ░                  ░ ░      ░ ░      ░  ░
echo.                                                                     

echo Made by Breakermaker



timeout /t 3 /nobreak >nul







:home
cls
color 01
title Simple SS by Breakermaker
color 1
echo.
echo ╔════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
echo ║  Hello %username%                                                                                               ║
echo.║                                                                                                            ║
echo ║  Commands:                                                                                                 ║
echo.║                                                                                                            ║
echo ║  1 - Services (please run this script twice if you didn't run Simple SS as administrator)                  ║
echo ║  2 - Manual Journal checker (not recommended, use tools like JournalTrace for that)                        ║
echo ║  3 - Bam checker (please run Simple SS as administrator to use this feature)                               ║
echo ║  4 - Prefetch bypasses                                                                                     ║
echo ║  5 - Usn Journal cleared                                                                                   ║
echo ║  6 - Event Logs (please run twice if you didn't run Simple SS as administrator)                            ║
echo ║  7 - Auto Zimmerman Tools (requires Administrator)                                                         ║                                        
echo ║  8 - Cheat Website checker (doomsday, drip, and cigar lite only yet)                                       ║
echo ║  9 - Unicode Detector                                                                                      ║
echo ║  11 - Service-Execution                                                                                    ║
echo ║  12 - Signature Checker (.txt file with the name paths.txt has to be present in the appdata directory)     ║
echo ║  13 - RL-Collector (better then auto zimmerman tools, requires admin)                                      ║
echo ║  14 - SS Helper Requirem (use at begining of ss)                                                           ║
echo ║  15 - Cancel                                                                                               ║
echo ╔═════════════════════════════════════════════Mods Analystics════════════════════════════════════════════════╗
echo ║  10 - Mod Checker (automatic)                                                                              ║
echo ║  100 - Mod Analystics (half manual)                                                                        ║
echo ╚═════════════════════════════════════════════════TOOLS══════════════════════════════════════════════════════╝
echo ║  01 - Tools                                                                                                ║
echo ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════╝

set /p Home= Command: 
if %Home%==1 goto Services
if %Home%==2 goto Manual Journal checker
if %Home%==3 goto Bam checker
if %Home%==4 goto Prefetch bypasses
if %Home%==5 goto Usn Journal Cleared
if %Home%==6 goto Event Logs
if %Home%==15 goto cancel
if %Home%==8 goto Visited Websites
if %Home%==10 goto Mod Checker
if %Home%==100 goto Mods Analystics
if %Home%==7 goto Zimmerman
if %Home%==9 goto Unicode
if %Home%==11 goto Service-Execution
if %Home%==12 goto Signature
if %Home%==13 goto RL
if %Home%==01 goto Tools
if %Home%==14 goto SSHelper


goto Test
echo That is an invalid command.
pause
goto home

:Services
cls
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
title Services
setlocal enabledelayedexpansion

for /f "tokens=2" %%a in ('tasklist /svc /fi "services eq dps" /fi "services eq dps" ^| findstr /i "svchost.exe"') do set pid=%%a

if not defined pid (
    powershell -Command "$result = 'Process Not Running: DPS'; Write-Host $result
) else (
powershell -Command "$process = Get-Process | Where-Object {$_.Id -eq %pid%}; if ($process) { $result = 'Process Name: DPS ' + ' Start Time: ' + $process.StartTime; Write-Host $result}"
)

for /f "tokens=2" %%a in ('tasklist /svc /fi "services eq Sysmain" /fi "services eq Sysmain" ^| findstr /i "svchost.exe"') do set pid=%%a

if not defined pid (
    powershell -Command "$result = 'Process Not Running: Sysmain'; Write-Host $result
) else (
powershell -Command "$process = Get-Process | Where-Object {$_.Id -eq %pid%}; if ($process) { $result = 'Process Name: Sysmain ' + ' Start Time: ' + $process.StartTime; Write-Host $result}"
)

for /f "tokens=2" %%a in ('tasklist /svc /fi "services eq PcaSvc" /fi "services eq PcaSvc" ^| findstr /i "svchost.exe"') do set pid=%%a

if not defined pid (
    powershell -Command "$result = 'Process Not Running: PcaSvc'; Write-Host $result
) else (
powershell -Command "$process = Get-Process | Where-Object {$_.Id -eq %pid%}; if ($process) { $result = 'Process Name: PcaSvc ' + ' Start Time: ' + $process.StartTime; Write-Host $result}"
)

for /f "tokens=2" %%a in ('tasklist /svc /fi "services eq Dusmsvc" /fi "services eq Dusmsvc" ^| findstr /i "svchost.exe"') do set pid=%%a

if not defined pid (
    powershell -Command "$result = 'Process Not Running: Dusmsvc'; Write-Host $result
) else (
powershell -Command "$process = Get-Process | Where-Object {$_.Id -eq %pid%}; if ($process) { $result = 'Process Name: Dusmsvc ' + ' Start Time: ' + $process.StartTime; Write-Host $result}"
)

for /f "tokens=2" %%a in ('tasklist /svc /fi "services eq Eventlog" /fi "services eq Eventlog" ^| findstr /i "svchost.exe"') do set pid=%%a

if not defined pid (
    powershell -Command "$result = 'Process Not Running: Eventlog'; Write-Host $result
) else (
powershell -Command "$process = Get-Process | Where-Object {$_.Id -eq %pid%}; if ($process) { $result = 'Process Name: Eventlog ' + ' Start Time: ' + $process.StartTime; Write-Host $result}"
)

for /f "tokens=2" %%a in ('tasklist /svc /fi "services eq Appinfo" /fi "services eq Appinfo" ^| findstr /i "svchost.exe"') do set pid=%%a

if not defined pid (
    powershell -Command "$result = 'Process Not Running: Appinfo'; Write-Host $result
) else (
powershell -Command "$process = Get-Process | Where-Object {$_.Id -eq %pid%}; if ($process) { $result = 'Process Name: Appinfo ' + ' Start Time: ' + $process.StartTime; Write-Host $result}"
)

for /f "tokens=2" %%a in ('tasklist /svc /fi "services eq DcomLaunch" /fi "services eq DcomLaunch" ^| findstr /i "svchost.exe"') do set pid=%%a

if not defined pid (
    powershell -Command "$result = 'Process Not Running: BAM'; Write-Host $result
) else (
powershell -Command "$process = Get-Process | Where-Object {$_.Id -eq %pid%}; if ($process) { $result = 'Process Name: BAM ' + ' Start Time: ' + $process.StartTime; Write-Host $result}"
)

for /f "tokens=2" %%a in ('tasklist /svc /fi "services eq dnscache" /fi "services eq dnscache" ^| findstr /i "svchost.exe"') do set pid=%%a

if not defined pid (
    powershell -Command "$result = 'Process Not Running: dnscache'; Write-Host $result
) else (
powershell -Command "$process = Get-Process | Where-Object {$_.Id -eq %pid%}; if ($process) { $result = 'Process Name: dnscache ' + ' Start Time: ' + $process.StartTime; Write-Host $result}"
)

for /f "tokens=2" %%a in ('tasklist /svc /fi "services eq DcomLaunch" /fi "services eq DcomLaunch" ^| findstr /i "svchost.exe"') do set pid=%%a

if not defined pid (
    powershell -Command "$result = 'Process Not Running: DcomLaunch'; Write-Host $result
) else (
powershell -Command "$process = Get-Process | Where-Object {$_.Id -eq %pid%}; if ($process) { $result = 'Process Name: DcomLaunch ' + ' Start Time: ' + $process.StartTime; Write-Host $result}"
)

for /f "tokens=2" %%a in ('tasklist /svc /fi "services eq PlugPlay" /fi "services eq PlugPlay" ^| findstr /i "svchost.exe"') do set pid=%%a

if not defined pid (
    powershell -Command "$result = 'Process Not Running: PlugPlay'; Write-Host $result
) else (
powershell -Command "$process = Get-Process | Where-Object {$_.Id -eq %pid%}; if ($process) { $result = 'Process Name: PlugPlay ' + ' Start Time: ' + $process.StartTime; Write-Host $result}"
)

for /f "tokens=2" %%a in ('tasklist /svc /fi "services eq DiagTrack" /fi "services eq DiagTrack" ^| findstr /i "svchost.exe"') do set pid=%%a

if not defined pid (
    powershell -Command "$result = 'Process Not Running: DiagTrack'; Write-Host $result
) else (
powershell -Command "$process = Get-Process | Where-Object {$_.Id -eq %pid%}; if ($process) { $result = 'Process Name: DiagTrack ' + ' Start Time: ' + $process.StartTime; Write-Host $result}"
)

for /f "tokens=2" %%a in ('tasklist /svc /fi "services eq diagnosticshub.standardcollector.service" /fi "services eq diagnosticshub.standardcollector.service" ^| findstr /i "svchost.exe"') do set pid=%%a

if not defined pid (
    powershell -Command "$result = 'Process Not Running: Explorer'; Write-Host $result
) else (
powershell -Command "$process = Get-Process | Where-Object {$_.Id -eq %pid%}; if ($process) { $result = 'Process Name: diagnosticshub.standardcollector.service ' + ' Start Time: ' + $process.StartTime; Write-Host $result}"
)







echo.
echo The user's Currently time and date:%date%/%time%
pause
goto home





:Manual Journal checker
cls
setlocal enabledelayedexpansion
set folderPath=%appdata%\SimpleSS\Fsutils
if exist "%folderPath%" (
    rd /s /q "%folderPath%"
)
mkdir %appdata%\SimpleSS\Fsutils\Macros 2>nul
mkdir %appdata%\SimpleSS\Fsutils\Extra 2>nul
mkdir %appdata%\SimpleSS\Fsutils\EXE 2>nul
mkdir %appdata%\SimpleSS\Fsutils\DLL 2>nul
mkdir %appdata%\SimpleSS\Fsutils\PFs 2>nul
mkdir %appdata%\SimpleSS\Fsutils\JAR 2>nul
mkdir %appdata%\SimpleSS\Fsutils\BAT 2>nul
mkdir %appdata%\SimpleSS\Fsutils\CrashDump 2>nul
mkdir %appdata%\SimpleSS\Fsutils\Archives 2>nul
mkdir %appdata%\SimpleSS\Fsutils 2>nul
echo %d%Running Fsutil Commands. . .
timeout /t 2 /nobreak >nul
set "driveCount=0"
for /f "tokens=1" %%d in ('wmic logicaldisk get caption ^| find ":"') do (
    set /a "driveCount+=1"
    set "drive!driveCount!=%%d"
)

for /l %%i in (1, 1, %driveCount%) do (
    echo Drive%%i: !drive%%i! >nul
)
set Fsutil="%appdata%\SimpleSS\Fsutils\FsutilJournal.txt"
fsutil usn readjournal c: csv >> %Fsutil%
if defined drive2 (
    fsutil usn readjournal !drive2! csv >> %Fsutil%
)
if defined drive3 (
    fsutil usn readjournal !drive3! csv >> %Fsutil%
)
if defined drive4 (
    fsutil usn readjournal !drive4! csv >> %Fsutil%
)
if defined drive5 (
    fsutil usn readjournal !drive5! csv >> %Fsutil%
)
if defined drive6 (
    fsutil usn readjournal !drive6! csv >> %Fsutil%
)
if defined drive7 (
    fsutil usn readjournal !drive7! csv >> %Fsutil%
)
if defined drive8 (
    fsutil usn readjournal !drive8! csv >> %Fsutil%
)
if defined drive9 (
    fsutil usn readjournal !drive9! csv >> %Fsutil%
)
if defined drive10 (
    fsutil usn readjournal !drive10! csv >> %Fsutil%
)

findstr /i /c:".exe" "%Fsutil%" | findstr /i /c:"0x80000200" >> %appdata%\SimpleSS\Fsutils\EXE\DeletedExes.txt
findstr /i /c:".exe" "%Fsutil%" | findstr /i /c:"0x00080000" >> %appdata%\SimpleSS\Fsutils\EXE\ObjectIDChange.txt
findstr /i /c:".exe" "%Fsutil%" | findstr /i /c:"0x00001000" >> %appdata%\SimpleSS\Fsutils\EXE\OldNameEXE.txt
findstr /i /c:".exe" "%Fsutil%" | findstr /i /c:"0x00002000" >> %appdata%\SimpleSS\Fsutils\EXE\NewNameEXE.txt
findstr /i /c:".dll" "%Fsutil%" | findstr /i /c:"0x80000200" >> %appdata%\SimpleSS\Fsutils\DLL\DeletedDLLs.txt
findstr /i /c:".dll" "%FsutiL%" | findstr /i /c:".lnk" >> %appdata%\SimpleSS\Fsutils\DLL\LNKDLL.txt
findstr /i /c:".dll" "%Fsutil%" >> %appdata%\SimpleSS\Fsutils\DLL\AllDLL.txt
findstr /i /c:".dll" "%Fsutil%" | findstr /i /c:"0x00001000" >> %appdata%\SimpleSS\Fsutils\DLL\OldNameDLL.txt
findstr /i /c:".dll" "%Fsutil%" | findstr /i /c:"0x00002000" >> %appdata%\SimpleSS\Fsutils\DLL\NewNameDLL.txt
findstr /i /c:".mcf" "%Fsutil%" | findstr /i /c:"0x80000200" >> %appdata%\SimpleSS\Fsutils\Macros\glorious.txt
findstr /i /c:".cuecfg" "%Fsutil%" | findstr /i /c:"0x80000200" >> %appdata%\SimpleSS\Fsutils\Macros\corsair.txt
findstr /i /c:".db" "%Fsutil%" | findstr /i /c:"0x80000200" >> %appdata%\SimpleSS\Fsutils\Macros\logitech.txt
findstr /i /c:".com" "%Fsutil%" | findstr /i /c:"0x80000200" >> %appdata%\SimpleSS\Fsutils\Macros\Macroswitcher.txt
findstr /i /c:".crdownload" "%Fsutil%" >> %appdata%\SimpleSS\Fsutils\Extra\DownloadCache.txt
findstr /i /c:".evtx" "%Fsutil%" | findstr /i /c:"0x80000200" >> %appdata%\SimpleSS\Fsutils\Extra\DeletedEventLog.txt
findstr /i /c:"?" "%Fsutil%" >> %appdata%\SimpleSS\Fsutils\Extra\EmptyCharacter.txt
findstr /i /c:"jnativehook" "%Fsutil%" >> %appdata%\SimpleSS\Fsutils\Extra\Jnat.txt
findstr /i /c:"0x00080000" "%Fsutil%" | findstr /i /c:"0x00000005" >> %appdata%\SimpleSS\Fsutils\Extra\DataTruncation.txt
findstr /i /c:".jar" "%Fsutil%" | findstr /i /c:"0x00001000" >> %appdata%\SimpleSS\Fsutils\JAR\RenamedJars.txt
findstr /i /c:".jar" "%Fsutil%" | findstr /i /c:"0x00002000" >> %appdata%\SimpleSS\Fsutils\JAR\NewNameJAR.txt
findstr /i /c:".jar" "%Fsutil%" | findstr /i /c:"0x80000200" >> %appdata%\SimpleSS\Fsutils\JAR\DeletedJars.txt
findstr /i /c:".jar" "%Fsutil%" | findstr /i /c:"0x00000020" >> %appdata%\SimpleSS\Fsutils\JAR\AllJars.txt
findstr /i /C:"0x00000004" "%Fsutil%" | findstr /i /C:"0x00000102" | findstr /i /C:"jar_cache" | findstr /i /C:".timestamp" >> %appdata%\SimpleSS\Fsutils\JAR\JarCache.txt
findstr /i /c:"Data Truncation" "%Fsutil%" | findstr /i /c:".jar" >> %appdata%\SimpleSS\Fsutils\JAR\JarDataTruncation.txt
findstr /i /c:".pf" "%Fsutil%" | findstr /i /c:"0x00001000" >> %appdata%\SimpleSS\Fsutils\PFs\RenamedPF.txt
findstr /i /c:".pf" "%Fsutil%" | findstr /i /c:"0x80000200" >> %appdata%\SimpleSS\Fsutils\PFs\DeletedPF.txt
findstr /i /c:".pf" "%Fsutil%" | findstr /i /c:"0x00008000" >> %appdata%\SS\Fsutils\PFs\Prefetch.txt
findstr /i /c:".bat" "%Fsutil%" | findstr /i /c:"0x00001000" >> %appdata%\SS\Fsutils\BAT\RenamedBats.txt
findstr /i /c:".bat" "%Fsutil%" | findstr /i /c:"0x80000200" >> %appdata%\SS\Fsutils\BAT\DeletedBats.txt
findstr /i /c:".dmp" "%Fsutil%" >> %appdata%\SimpleSS\Fsutils\CrashDump\CrashDmp.txt
findstr /i /c:"appcrash" "%Fsutil%" >> %appdata%\SimpleSS\Fsutils\CrashDump\AppCrash.txt
findstr /i /c:".rar" "%Fsutil%" | findstr /i /c:"0x80000200" >> %appdata%\SimpleSS\Fsutils\Archives\DeletedRar.txt
findstr /i /c:".zip" "%Fsutil%" | findstr /i /c:"0x80000200" >> %appdata%\SimpleSS\Fsutils\Archives\DeletedZip.txt
findstr /i /c:".7z" "%Fsutil%" | findstr /i /c:"0x80000200" >>  %appdata%\SimpleSS\Fsutils\Archives\Deleted7z.txt
findstr /i /c:".tar" "%Fsutil%" | findstr /i /c:"0x80000200" >> %appdata%\SimpleSS\Fsutils\Archives\DeletedTar.txt
findstr /i /c:".gz" "%Fsutil%" | findstr /i /c:"0x80000200" >>  %appdata%\SimpleSS\Fsutils\Archives\DeletedGz.txt
cls
echo Checking for Modified Tasks. . .
setlocal enabledelayedexpansion

for /r "C:\windows\system32\tasks" %%F in (*) do (
    for /f "tokens=*" %%a in ('fsutil file queryfileid "%%F"') do (
        set "line=%%a"
        set "line=!line:*File ID is =!"
        set "line=!line: =!"
        set "FRN=!line!"
    )
    set "FRN=!FRN:~2!"
    findstr /i /c:"!FRN!" "%Fsutil%" >> "%appdata%\SimpleSS\Fsutils\Tasks.txt"
)

endlocal
echo Deleting Empty Files. . .
setlocal enabledelayedexpansion

for /r "%appdata%\SimpleSS\Fsutils" %%F in (*.txt) do (
    set "file=%%F"
    for %%A in ("!file!") do (
        set "size=%%~zA"
        if !size! EQU 0 (
            del "!file!"
        )
    )
)

endlocal


start "" %appdata%\SimpleSS\Fsutils

pause
goto home



:Bam checker
cls
powershell Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass && powershell Invoke-Expression (Invoke-RestMethod https://raw.githubusercontent.com/PureIntent/ScreenShare/main/RedLotusBam.ps1)

pause
goto home





:Prefetch bypasses
cls
title PrefetchBypass

set "HiddenFilePrefetchFile=%appdata%\SimpleSS\Prefetch\HiddenFilePrefetch.txt"
set "ReadOnlyPrefetchFile=%appdata%\SimpleSS\Prefetch\ReadOnlyPrefetch.txt"

rem Ensure that the directory exists
mkdir "%appdata%\SimpleSS\Prefetch" 2>nul

echo Scanning for hidden and read-only prefetch files...
if exist C:\Windows\Prefetch (
    echo Found prefetch directory.
    (for /f "delims=" %%A in ('dir /b /a:h /s "C:\Windows\Prefetch\*.pf" 2^>nul') do (
        echo Checking file: %%A
        echo File is hidden: %%A
        set "HiddenFound=1"
    )) > "%HiddenFilePrefetchFile%"
    (for /f "delims=" %%B in ('dir /b /a:r /s "C:\Windows\Prefetch\*.pf" 2^>nul') do (
        echo Checking file: %%B
        echo File is read-only: %%B
        set "ReadOnlyFound=1"
    )) > "%ReadOnlyPrefetchFile%"
) else (
    echo Prefetch directory not found.
)

if defined HiddenFound (
    echo Hidden prefetch files found:
    type "%HiddenFilePrefetchFile%"
) else (
    echo No hidden prefetch files found.
)

if defined ReadOnlyFound (
    echo Read-only prefetch files found:
    type "%ReadOnlyPrefetchFile%"
) else (
    echo No read-only prefetch files found.
)

pause









goto home




:Usn Journal cleared
cls
setlocal

REM Query the event log for Event ID 3079 in the current boot instance
wevtutil qe Application /q:"*[System/EventID=3079 and System/TimeCreated[timediff(@SystemTime) <= 86400000]]" /f:text /c:1 /rd:true /e:root > JournalCheck.txt

REM Output the contents of JournalCheck.txt
type JournalCheck.txt

REM Display additional message in big red letters
echo.
echo.
echo.
echo  [91mPlease don't ban people for having Journal cleared some days ago. Please check the time if it was in the current boot instance.
echo.
echo.

del JournalCheck.txt

pause
endlocal
goto home




:Event Logs
cls

if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
set output="%appdata%\SimpleSS\Results\Eventlog"
mkdir %output% 2>nul
cls
echo Scanning EventLog. . .
wevtutil qe Application /q:"*[System/EventID=3079]" /f:text /c:1 /rd:true /e:root >> JournalDeletion.txt > %output%\JournalDeletion.txt
wevtutil qe Security /q:"*[System/EventID=1102]" /f:text /c:1 /rd:true /e:root >> EvLogCleared.txt > %output%\EvLogCleared.txt
wevtutil qe Security /q:"*[System/EventID=1100]" /f:text /c:1 /rd:true /e:root >> EvLogStopped.txt > %output%\EvLogStopped.txt
wevtutil qe Security /q:"*[System/EventID=1104]" /f:text /c:1 /rd:true /e:root >> EvLogMax.txt > %output%\EvLogMax.txt
wevtutil qe Security /q:"*[System/EventID=4616]" /f:text /c:1 /rd:true /e:root >> TimeChanger.txt > %output%\TimeChanger.txt
wevtutil qe Security /q:"*[System/EventID=4672]" /f:text /c:1 /rd:true /e:root >> AdminNewUser.txt > %output%\AdminNewUser.txt
wevtutil qe Security /q:"*[System/EventID=4624]" /f:text /c:1 /rd:true /e:root >> UserLogin.txt > %output%\UserLogin.txt
wevtutil qe Security /q:"*[System/EventID=4647]" /f:text /c:1 /rd:true /e:root >> UserLogout.txt > %output%\UserLogout.txt
wevtutil qe Security /q:"*[System/EventID=4688]" /f:text /c:1 /rd:true /e:root >> NewProcessCreated.txt > %output%\NewProcessCreated.txt
wevtutil qe Security /q:"*[System/EventID=4689]" /f:text /c:1 /rd:true /e:root >> ProcessTerminated.txt > %output%\ProcessTerminated.txt
wevtutil qe Security /q:"*[System/EventID=4697]" /f:text /c:1 /rd:true /e:root >> ServiceInstalled.txt > %output%\ServiceInstalled.txt
wevtutil qe Security /q:"*[System/EventID=6416]" /f:text /c:1 /rd:true /e:root >> ExternalDevice.txt > %output%\ExternalDevice.txt
wevtutil qe Security /q:"*[System/EventID=6420]" /f:text /c:1 /rd:true /e:root >> DriverDisabled.txt > %output%\DriverDisabled.txt
wevtutil qe Security /q:"*[System/EventID=4799]" /f:text /c:1 /rd:true /e:root >> ShadowCopiesDeleted.txt > %output%\ShadowCopiesDeleted.txt
wevtutil qe Security /q:"*[System/EventID=4798]" /f:text /c:1 /rd:true /e:root >> RegPermsChanged.txt > %output%\RegPermsChanged.txt
wevtutil qe Security /q:"*[System/EventID=4698]" /f:text /c:1 /rd:true /e:root >> "Task Scheduler" > "%output%\Task scheduler.txt"
start "" %output%
pause
goto home





:cancel
cls
title Simple SS exiting...
echo Simple SS exiting..
timeout 3 /NOBREAK >nul
exit



:Visited Websites
cls
title Cheat Website checker


ipconfig /displaydns | findstr "doomsdayclient.com" && echo Doomsdayclient found || echo doomsdayclient.com not found
ipconfig /displaydns | findstr "drip.gg" && echo drip found || echo Drip.gg not found
ipconfig /displaydns | findstr "cigar.wtf" && echo cigar found || echo cigar.wtf not found

pause
goto home



:Mod Checker1
cls
Title Mod Checker (automatic)

echo Scanning for Mod Bypasses

timeout /t 1 /nobreak >nul


set "HiddenFileModFile=%appdata%\SimpleSS\ModAnalystics\HiddenFileMod.txt"
set "SystemModFile=%appdata%\SimpleSS\ModAnalystics\SystemFileMod.txt"

rem Ensure that the directory exists
mkdir "%appdata%\SimpleSS\ModAnalystics" 2>nul

echo Scanning for hidden and System Mods...
timeout /t 1 /nobreak >nul

if exist %appdata%\.Minecraft\Mods\ (
    echo Found Mods directory.
    (for /f "delims=" %%A in ('dir /b /a:h /s "%appdata%\.Minecraft\Mods\*.jar" 2^>nul') do (
        echo Checking file: %%A
        echo File is hidden: %%A
        set "HiddenFound=1"
    )) > "%HiddenFileModFile%"
    (for /f "delims=" %%B in ('dir /b /a:s /s "%appdata%\.Minecraft\Mods\*.jar" 2^>nul') do (
        echo Checking file: %%B
        echo File is System: %%B
        set "SystemFound=1"
    )) > "%SystemModFile%"
) else (
timeout /t 1 /nobreak >nul
    echo Mods directory not found.
)

if defined HiddenFound (
    echo Hidden Mods found:
    type "%HiddenFileModFile%"
) else (
   timeout /t 1 /nobreak >nul
 echo No hidden Mods found.
)

if defined SystemFound (
    echo System Mods found:
    type "%SystemModFile%"
) else (
  timeout /t 1 /nobreak >nul
  echo No System Mods found.

)

pause

echo Scanning Mods Download link...

timeout /t 2 /nobreak >nul

powershell Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass && powershell Invoke-Expression (Invoke-RestMethod https://shorturl.at/SJ9DE)
start LinksAndClasses.txt

timeout /t 3 /nobreak >nul

del LinksAndClasses.txt

pause
cls
Title Journal-Trace

echo Please Filter For any deleted .jar files in the Mods Directory

timeout /t 2 /nobreak >nul


powershell Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass && powershell Invoke-Expression (Invoke-RestMethod https://shorturl.at/drGVd)


pause

cls
Title Lyten

echo Now For the mods you are not sure abt use Lyten to manually decompile them 

timeout /t 2 /nobreak >nul

Start %appdata%\.Minecraft\Mods


powershell Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass && powershell Invoke-Expression (Invoke-RestMethod https://shorturl.at/9AGLe)


pause

goto home








:Zimmerman
cls
Title Auto Zimmerman Tools
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
set "amcacheDL=https://f001.backblazeb2.com/file/EricZimmermanTools/net6/AmcacheParser.zip"
set "AppcompatcacheDL=https://f001.backblazeb2.com/file/EricZimmermanTools/net6/AppCompatCacheParser.zip"
set "JLECmdDL=https://f001.backblazeb2.com/file/EricZimmermanTools/net6/JLECmd.zip"
set "PECmdDL=https://f001.backblazeb2.com/file/EricZimmermanTools/net6/PECmd.zip"
set "WxTCmdDL=https://f001.backblazeb2.com/file/EricZimmermanTools/net6/WxTCmd.zip"
set "SrumECMDDL=https://f001.backblazeb2.com/file/EricZimmermanTools/net6/SrumECmd.zip"
set "TimelineExplorerDL=https://f001.backblazeb2.com/file/EricZimmermanTools/net6/TimelineExplorer.zip"

set "Path=%appdata%\SimpleSS\EricZimmerman\Tools"

set "AmCache=%appdata%\SimpleSS\EricZimmerman\Tools\Amcacheparser.zip"
set "AppCompatCache=%appdata%\SimpleSS\EricZimmerman\Tools\AppCompatCacheParser.zip"
set "JLECmd=%appdata%\SimpleSS\EricZimmerman\Tools\JLECmd.zip"
set "PECmd=%appdata%\SimpleSS\EricZimmerman\Tools\PECmd.zip"
set "SrumECmd=%appdata%\SimpleSS\EricZimmerman\Tools\SrumECmd.zip"
set "TimelineExplorer=%appdata%\SimpleSS\EricZimmerman\Tools\TimelineExplorer.zip"
set "WxTCmd=%appdata%\SimpleSS\EricZimmerman\Tools\WxTCmd.zip"
set "Results=%appdata%\SimpleSS\EricZimmerman\Results"
if exist %appdata%\SimpleSS\EricZimmerman (
    rd /s /q %appdata%\SimpleSS\EricZimmerman
)
mkdir %Path% 2>nul

:var
set g=[92m
set r=[91m
set red=[04m
set l=[1m
set w=[0m
set b=[94m
set m=[95m
set p=[35m
set c=[35m
set d=[96m
set u=[0m
set z=[91m
set n=[96m
set y=[40;33m
set g2=[102m
set r2=[101m
set t=[40m
set bo=[01m


setlocal enabledelayedexpansion
chcp 65001 >nul
cls
echo.
echo.
echo.                      
echo        %c%           
echo.   
echo %r%                                          Downloading Tools
echo                                                 5 
echo                                        %g%%g2%.%r%%r2%...................%t%%w%
curl -s -o "%Path%\AmcacheParser.zip" "%amcacheDL%" >nul
curl -s -o "%Path%\windowsdesktop-runtime-6.0.24-win-x64.exe" "https://dotnet.microsoft.com/en-us/download/dotnet/thank-you/runtime-desktop-6.0.24-windows-x64-installer?cid=getdotnetcore" >nul
"windowsdesktop-runtime-6.0.23-win-x64.exe" /install /quiet
cls
echo.
echo.
echo.                      
echo            
echo.   
echo %r%                                          Downloading Tools
echo                                                 15 
echo                                        %g%%g2%...%r%%r2%.................%t%%w%
curl -s -o "%Path%\AppCompatCacheParser.zip" "%AppcompatcacheDL%" >nul

cls
echo.
echo.
echo.                      
echo        %c%           
echo.   
echo %r%                                          Downloading Tools
echo                                                 25 
echo                                        %g%%g2%.....%r%%r2%...............%t%%w%
curl -s -o "%Path%\JLECmd.zip" "%JLECmdDL%" >nul

cls
echo.
echo.
echo.                      
echo        %c%       
echo.   
echo %r%                                          Downloading Tools
echo                                                 35 
echo                                        %g%%g2%.......%r%%r2%.............%t%%w%
curl -s -o "%Path%\PECmd.zip" "%PECmdDL%" >nul
cls
echo.
echo.
echo.                      
echo        %c%       ═╝    
echo.   
echo %r%                                          Downloading Tools
echo                                                 50 
echo                                        %g%%g2%..........%r%%r2%..........%t%%w%
curl -s -o "%Path%\WxTCmd.zip" "%WxTCmdDL%" >nul
cls
echo.
echo.
echo.                 
echo                     ╚ 
echo.   
echo %r%                                          Downloading Tools
echo                                                 65 
echo                                        %g%%g2%..............%r%%r2%......%t%%w%
curl -s -o "%Path%\SrumECmd.zip" "%SrumECMDDL%" >nul

cls
echo.
echo.
echo.                      
echo        %c%              
echo.   
echo %r%                                          Downloading Tools
echo                                                 80 
echo                                        %g%%g2%................%r%%r2%....%t%%w%
curl -s -o "%Path%\TimelineExplorer.zip" "%TimelineExplorerDL%" 2>nul

cls
echo.
echo.
echo.                      
echo        %c%           
echo.   
echo %r%                                          Extracting Tools
echo                                                 90 
echo                                        %g%%g2%..................%r%%r2%..%t%%w%
chcp 850 >nul
"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -Command "Expand-Archive -Path '%AmCache%' -DestinationPath '%Path%' -Force" >nul 2>&1
"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -Command "Expand-Archive -Path '%TimelineExplorer%' -DestinationPath '%Path%' -Force" >nul 2>&1
"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -Command "Expand-Archive -Path '%WxTCmd%' -DestinationPath '%Path%' -Force" >nul 2>&1
"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -Command "Expand-Archive -Path '%SrumECmd%' -DestinationPath '%Path%' -Force" >nul 2>&1
"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -Command "Expand-Archive -Path '%PECmd%' -DestinationPath '%Path%' -Force" >nul 2>&1
"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -Command "Expand-Archive -Path '%WxTCmd%' -DestinationPath '%Path%' -Force" >nul 2>&1
"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -Command "Expand-Archive -Path '%AppCompatCache%' -DestinationPath '%Path%' -Force" >nul 2>&1
"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -Command "Expand-Archive -Path '%JLECmd%' -DestinationPath '%Path%' -Force" >nul 2>&1
chcp 65001 >nul
del "%Path%\TimelineExplorer.zip"
del "%Path%\SrumECmd.zip"
del "%Path%\WxTCmd.zip"
del "%Path%\JLECmd.zip"
del "%Path%\AppCompatCacheParser.zip"
del "%Path%\AmCacheParser.zip"
del "%Path%\PECmd.zip"
cls
echo.
echo.
echo.                      
echo        %c%             
echo.   
echo %r%                                          Downloading Tools
echo                                                 100
echo                                        %g%%g2%....................%r%%r2%%t%%w%
chcp 850 >nul
endlocal
ping localhost -n 1 >nul
if exist "%Path%\AmCacheParser.exe" (
    "%Path%\AmcacheParser.exe" -f "C:\Windows\appcompat\Programs\Amcache.hve" --csv "%Results%"
)
if exist "%Path%\AppCompatCacheParser.exe" (
    "%Path%\AppCompatCacheParser.exe" --csv "%Results%"
)
if exist "%Path%\SrumECmd.exe" (
    "%Path%\SrumECmd.exe" -f "C:\Windows\System32\sru\SRUDB.dat" --csv "%Results%"
)
if exist "%Path%\JLECmd.exe" (
    "%Path%\JLECmd.exe" -d "%appdata%\Microsoft\Windows\Recent" --all --ld --fd --csv "%Results%"
)
if exist "%Path%\PECmd.exe" (
    "%Path%\PECmd.exe" -d "C:\Windows\Prefetch" --csv "%Results%"
)

for /f %%i in ('dir /s /b "C:\Users\%username%\AppData\Local\ConnectedDevicesPlatform\activitiescache.db"') do set "Activity=%%i"

if defined Activity (
    "%Path%\WxtCmd.exe" -f "%Activity%" --csv "%Results%"
)
del "%Results%\*ShortCuts.csv"
del "%Results%\*DriverPackages.csv"
del "%Results%\*DriveBinaries.csv"
del "%Results%\*DevicePnps.csv"
del "%Results%\*DeviceContainers.csv"
del "%Results%\*PECmd_Output_Timeline.csv"
del "%Results%\*Activity_PackageIDs.csv"
del "%Results%\*SrumECmd_AppTimelineProvider_Output.csv"
del "%Results%\*SrumECmd_EnergyUsage_Output.csv"
del "%Results%\*SrumECmd_NetworkConnections_Output.csv"
del "%Results%\*SrumECmd_PushNotifications_Output.csv"
del "%Results%\*SrumECmd_vfuprov_Output.csv"
"%Path%\TimelineExplorer\TimelineExplorer.exe"
explorer "%Results%"

pause 
goto home


:Journal-Trace
cls
Title Journal-Trace

powershell Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass && powershell Invoke-Expression (Invoke-RestMethod https://shorturl.at/drGVd)
pause
goto home









:Unicode
cls
Title Unicode Detector
powershell Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass && powershell Invoke-Expression (Invoke-RestMethod https://shorturl.at/eobto)
pause
goto home




:Service-Execution
cls
Title Service Execution
powershell Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass && powershell Invoke-Expression (Invoke-RestMethod https://shorturl.at/vMiFK)
pause
goto home



:UsbDriveLog
cls
Title UsbDriveLog
powershell Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass && powershell Invoke-Expression (Invoke-RestMethod https://rb.gy/69lm38)
pause
goto home






:Lyten
cls
Title Lyten
powershell Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass && powershell Invoke-Expression (Invoke-RestMethod https://shorturl.at/9AGLe)
pause
goto home




:WinPrefetchView
cls
Title WinPrefetchView
powershell Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass && powershell Invoke-Expression (Invoke-RestMethod https://shorturl.at/hX0hM)
pause
goto home



:Everything
cls
Title Everything

pause
goto home
powershell Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass && powershell Invoke-Expression (Invoke-RestMethod https://rb.gy/5qhdpq)



:Mods Analystics
cls
color 01
title Mods Analystics
color 1
echo.
echo ╔════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
echo ║  Hello %username%                                                                                               ║
echo.║                                                                                                            ║
echo ║  Commands:                                                                                                 ║
echo.║                                                                                                            ║
echo ║  1 - Hidden/system Mod file Bypass detector                                                                ║
echo ║  2 - download link scanner (very usefull)                                                                  ║
echo ║  3 - Journal Trace (to check for deleted files in the mod directory)                                       ║
echo ║  4 - Lyten (Mod Decompiler)                                                                                ║
echo ║  5 - Hash scanner (very usefull)                                                                           ║
echo ║  6 - back                                                                                                  ║
echo ╚═════════════════════════════════════════════════TOOLS══════════════════════════════════════════════════════╝

set /p Home= Command: 
if %Home%==1 goto Bypasses
if %Home%==2 goto Mod scanner2
if %Home%==3 goto Journal Trace1
if %Home%==4 goto Decompiler
if %Home%==5 goto Index
if %Home%==6 goto home


:Index
cls
Title Hash scanner
powershell Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass && powershell Invoke-Expression (Invoke-RestMethod https://shorturl.at/Z0Zut)

start res(LIGHT)-diagnostic.diagnostic

timeout /t 3 /nobreak >nul

del res(LIGHT)-diagnostic.diagnostic

del res(HEAVY)-diagnostic.diagnostic



pause
goto Mods Analystics



















:Bypasses
cls
Title Hidden/system Mod file Bypass detector

echo Scanning for Mod Bypasses

timeout /t 1 /nobreak >nul


set "HiddenFileModFile=%appdata%\SimpleSS\ModAnalystics\HiddenFileMod.txt"
set "SystemModFile=%appdata%\SimpleSS\ModAnalystics\SystemFileMod.txt"

rem Ensure that the directory exists
mkdir "%appdata%\SimpleSS\ModAnalystics" 2>nul

echo Scanning for hidden and System Mods...
timeout /t 1 /nobreak >nul

if exist %appdata%\.Minecraft\Mods\ (
    echo Found Mods directory.
    (for /f "delims=" %%A in ('dir /b /a:h /s "%appdata%\.Minecraft\Mods\*.jar" 2^>nul') do (
        echo Checking file: %%A
        echo File is hidden: %%A
        set "HiddenFound=1"
    )) > "%HiddenFileModFile%"
    (for /f "delims=" %%B in ('dir /b /a:s /s "%appdata%\.Minecraft\Mods\*.jar" 2^>nul') do (
        echo Checking file: %%B
        echo File is System: %%B
        set "SystemFound=1"
    )) > "%SystemModFile%"
) else (
timeout /t 1 /nobreak >nul
    echo Mods directory not found.
)

if defined HiddenFound (
    echo Hidden Mods found:
    type "%HiddenFileModFile%"
) else (
   timeout /t 1 /nobreak >nul
 echo No hidden Mods found.
)

if defined SystemFound (
    echo System Mods found:
    type "%SystemModFile%"
) else (
  timeout /t 1 /nobreak >nul
  echo No System Mods found.

)

pause

goto Mods Analystics



:Journal Trace1
cls
Title Journal-Trace

powershell Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass && powershell Invoke-Expression (Invoke-RestMethod https://shorturl.at/drGVd)
pause
goto Mods Analystics






:Mod scanner2
cls
echo Scanning Mods Download link...

timeout /t 2 /nobreak >nul

powershell Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass && powershell Invoke-Expression (Invoke-RestMethod https://shorturl.at/SJ9DE)
start LinksAndClasses.txt

timeout /t 3 /nobreak >nul

del LinksAndClasses.txt

pause

goto Mods Analystics

:Decompiler
cls
Title Lyten Java Decompiler
powershell Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass && powershell Invoke-Expression (Invoke-RestMethod https://shorturl.at/9AGLe)
pause
goto Mods Analystics






:System Informer
cls
Title System Informer
powershell Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass && powershell Invoke-Expression (Invoke-RestMethod https://rb.gy/zp4fxl)
pause
goto home




:Tools
cls
Title Tools

echo ╔═════════════════════════════════════════════════TOOLS══════════════════════════════════════════════════════╗
echo ║  01 - System Informer                                                                                      ║
echo ║  02 - Everything                                                                                           ║
echo ║  03 - Journal-Trace                                                                                        ║
echo ║  04 - UsbDriveLog                                                                                          ║
echo ║  05 - Lyten(Java Decompiler)                                                                               ║
echo ║  06 - soon                                                                                                 ║
echo ║  07 - soon                                                                                                 ║
echo ║  08 - soon                                                                                                 ║
echo ║  09 - soon                                                                                                 ║
echo ║  010 - soon                                                                                                ║
echo ║  011 - back                                                                                                ║
echo ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════╝

set /p Home= Command: 
if %Home%==01 goto System Informer
if %Home%==04 goto UsbDriveLog
if %Home%==05 goto Lyten
if %Home%==06 goto WinPrefetchView
if %Home%==02 goto Everything
if %Home%==03 goto JournalTrace
if %Home%==011 goto home





:System Informer
cls
Title System Informer
powershell Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass && powershell Invoke-Expression (Invoke-RestMethod https://rb.gy/zp4fxl)
pause
goto Tools





:Lyten
cls
Title Lyten Java Decompiler
powershell Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass && powershell Invoke-Expression (Invoke-RestMethod https://shorturl.at/9AGLe)
pause
goto Tools




:Journal Trace
cls
Title Journal-Trace

powershell Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass && powershell Invoke-Expression (Invoke-RestMethod https://shorturl.at/drGVd)
pause
goto Tools




:Everything
cls
Title Everything
powershell Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass && powershell Invoke-Expression (Invoke-RestMethod https://rb.gy/5qhdpq)
pause
goto Tools





:UsbDriveLog
cls
Title UsbDriveLog
powershell Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass && powershell Invoke-Expression (Invoke-RestMethod https://rb.gy/69lm38)
pause
goto Tools




:Signature
cls
Title Signature Checker
chdir %appdata%
powershell Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass && powershell Invoke-Expression (Invoke-RestMethod https://raw.githubusercontent.com/bacanoicua/Screenshare/main/RedLotusSignatures.ps1)

timeout /t 2 /nobreak >nul

pause

goto home



:RL
cls
Title RL-Collector

REM Check if SimpleSS directory exists in the %APPDATA% directory and create it if it doesn't

SET DIR_PATH=%APPDATA%\SimpleSS

IF NOT EXIST "%DIR_PATH%" (
    ECHO SimpleSS directory does not exist. Creating directory...
    MKDIR "%DIR_PATH%"
) ELSE (
    ECHO SimpleSS directory already exists.
)

REM Navigate into the SimpleSS directory
CD /D "%DIR_PATH%"
ECHO Now in the SimpleSS directory: %DIR_PATH%


powershell Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass && powershell Invoke-Expression (Invoke-RestMethod https://shorturl.at/3bbub)

pause
goto home







:SSHelper
cls
Title SSHelper

timeout /t 2 /nobreak >nul

set website=

start "" "%website%"

timeout /t 1 /nobreak >nul

set website=

start "" "%website%"

echo please download both of those .exes and put them in a folder next to each other,
echo execute the "Screenshare Tool (Minecraft - 64 bits).exe" and analyze the results.

pause

goto home

exit





exit





