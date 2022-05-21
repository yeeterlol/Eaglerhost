@echo off
set option = disabled

:setup
echo Creating Eaglercraft Multiport Server
echo Before we setup, please answer some questions
set /p java="Java installed? (Y/N): "
if "%java%" == "Y" (
 goto paper
 set option = enabled
)
if "%java%" == "y" (
 goto paper
 set option = enabled
)
if "%java%" == "N" (
 goto installjava
 set option = enabled
)
if "%java%" == "n" (
 goto installjava
 set option = enabled
)
if "%option%" == "disabled" (
 set javaerr = enabled
 goto error
)

:error
echo We detected an error! Try again!
pause
goto setup

:installjava
echo Installing Java
powershell Invoke-WebRequest "https://javadl.oracle.com/webapps/download/AutoDL?BundleId=246474_2dee051a5d0647d5be72a7c0abff270e" -OutFile "%temp%\java.exe"
%temp%\java.exe
goto eagler

:eagler
echo Installing Eaglercraft
powershell Invoke-WebRequest "https://raw.githubusercontent.com/LAX1DUDE/eaglercraft/main/stable-download/stable-download-new.zip" -OutFile "temp.zip"
powershell Expand-Archive -Path temp.zip 
powershell Move-Item -Path %cd%/temp/* -Destination %cd%
rmdir temp
del temp.zip
goto startup

:startup
echo Starting up Bukkit Server
cd java
cd bukkit_command
start cmd.exe @cmd /k "run.bat"
echo Starting up Bungeecord Server
cd ..
cd bungee_command
start cmd.exe @cmd /k "run.bat"

