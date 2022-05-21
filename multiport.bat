@echo off
set javaerr = disabled
set option = disabled
set option2 = disabled
:setup
echo Creating Eaglercraft Multiport Server
echo Before we setup, please answer some questions
set /p java="Java installed? (Y/N): "
set /p node="Node.js installed? (Y/N): "
echo Thank you for answering this questions! We'll get to work!
mkdir paper
mkdir multiport
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
echo We detected an error!
if "%javaerr%" == "enabled" ( 
  set javaerr = false
  goto setup
) else (
  set /p node="Node.js installed? (Y/N): " 
  if %node%=="Y" (goto modules)
  if %node%=="y" (goto modules)
  if %node%=="N" (goto node)
  if %node%=="n" (
   goto node
  ) else (
   goto error
  )
)

:installjava
echo Installing Java
powershell Invoke-WebRequest "https://javadl.oracle.com/webapps/download/AutoDL?BundleId=246474_2dee051a5d0647d5be72a7c0abff270e" -OutFile "%temp%\java.exe"
%temp%\java.exe
echo Installing JDK 17
powershell Invoke-WebRequest "https://download.oracle.com/java/17/latest/jdk-17_windows-x64_bin.exe" -OutFile "%temp%\jdk.exe"
%temp%\jdk.exe
goto paper

:paper
echo Installing Paper
cd paper
powershell Invoke-WebRequest "https://papermc.io/api/v2/projects/paper/versions/1.17.1/builds/411/downloads/paper-1.17.1-411.jar" -OutFile "paper.jar"
echo eula=true>> eula.txt
powershell Invoke-WebRequest "https://raw.githubusercontent.com/yeeterlol/Eaglerhost/main/storage/server.properties" -OutFile "server.properties"
echo @echo off >> start.bat
echo java -Xms2G -Xmx16G -jar paper.jar >> start.bat
echo pause >> start.bat
echo Installing ProtocolSupport (Allows to connect to paper server)
mkdir plugins
cd plugins
powershell Invoke-WebRequest "https://protocol.support/view/ProtocolSupport/job/ProtocolSupport/lastStableBuild/artifact/target/ProtocolSupport.jar" -OutFile "ProtocolSupport.jar"
if "%node%"=="Y" (
 goto modules
 set option2 = enabled
)

if "%node%"=="y" (
 goto modules
 set option2 = enabled
)

if "%node%"=="N" (
 goto node
 set option2 = enabled
)

if "%node%"=="n" (
 goto node
 set option2 = enabled
)
if "%option2%"=="disabled" (
 goto errord
)

:node
echo Installing Node.js
powershell Invoke-WebRequest "https://nodejs.org/dist/v16.15.0/node-v16.15.0-x64.msi" -OutFile "%temp%\node.msi"
%temp%/node.msi
goto modules

:modules
echo Installing Node.js Modules
cd multiport
start cmd.exe @cmd /k "npm install jimp && npm install mime-types && npm install ws && npm install buffer-replace && exit"
goto multiport

:multiport
echo Installing Multiport Files
powershell Invoke-WebRequest https://github.com/ayunami2000/ayunMultiPort/archive/refs/heads/master.zip -OutFile "temp.zip"
powershell Expand-Archive -Path temp.zip 
powershell Move-Item -Path %cd%/temp/* -Destination %cd%
powershell Move-Item -Path %cd%/ayunMultiPort-master/* -Destination %cd%
rmdir temp
rmdir ayunMultiPort-master
del temp.zip
powershell Invoke-WebRequest https://raw.githubusercontent.com/yeeterlol/Eaglerhost/main/storage/eagler.js
goto startup

:startup
echo Starting up Paper
cd ..
cd paper
start cmd.exe @cmd /k "start.bat"
echo Starting up Multiport
cd .. 
cd multiport
start cmd.exe @cmd /k "run.bat"
start cmd.exe @cmd /k "runeag.bat"






