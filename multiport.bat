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
echo #By changing the setting below to TRUE you are indicating your agreement to our EULA (https://account.mojang.com/documents/minecraft_eula).>> eula.txt
echo #You also agree that tacos are tasty, and the best food in the world.>> eula.txt
echo #Tue May 17 14:59:33 PDT 2022>> eula.txt
echo eula=true>> eula.txt
echo #Minecraft server properties>> server.properties
echo #Tue May 17 15:01:27 PDT 2022>> server.properties
echo enable-jmx-monitoring=false>> server.properties
echo rcon.port=25575>> server.properties
echo enable-command-block=false>> server.properties
echo gamemode=survival>> server.properties
echo enable-query=false>> server.properties
echo level-name=world>> server.properties
echo motd=A Minecraft Server>> server.properties
echo query.port=25565>> server.properties
echo pvp=true>> server.properties
echo difficulty=easy>> server.properties
echo network-compression-threshold=256>> server.properties
echo max-tick-time=60000>> server.properties
echo require-resource-pack=false>> server.properties
echo max-players=20>> server.properties
echo use-native-transport=true>> server.properties
echo online-mode=false>> server.properties
echo enable-status=true>> server.properties
echo allow-flight=false>> server.properties
echo broadcast-rcon-to-ops=true>> server.properties
echo view-distance=10>> server.properties
echo server-ip=>> server.properties
echo resource-pack-prompt=>> server.properties
echo allow-nether=true>> server.properties
echo server-port=25569>> server.properties
echo enable-rcon=false>> server.properties
echo sync-chunk-writes=true>> server.properties
echo op-permission-level=4>> server.properties
echo prevent-proxy-connections=false>> server.properties
echo resource-pack=>> server.properties
echo entity-broadcast-range-percentage=100>> server.properties
echo rcon.password=>> server.properties
echo player-idle-timeout=0>> server.properties
echo debug=false>> server.properties
echo force-gamemode=false>> server.properties
echo rate-limit=0>> server.properties
echo hardcore=false>> server.properties
echo white-list=false>> server.properties
echo broadcast-console-to-ops=true>> server.properties
echo spawn-npcs=true>> server.properties
echo spawn-animals=true>> server.properties
echo snooper-enabled=true>> server.properties
echo function-permission-level=2>> server.properties
echo text-filtering-config=>> server.properties
echo spawn-monsters=true>> server.properties
echo enforce-whitelist=false>> server.properties
echo resource-pack-sha1=>> server.properties
echo spawn-protection=16>> server.properties
echo max-world-size=29999984>> server.properties
echo  >> server.properties
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
echo const Net = require('net');>>eagler.js
echo const { WebSocketServer, WebSocket } = require('ws');>>eagler.js
echo const fs = require("fs");>>eagler.js
echo const path = require("path");>>eagler.js
echo const mime = require("mime-types");>>eagler.js
echo const bufferReplace = require('buffer-replace');>>eagler.js
echo const crypto = require('crypto');>>eagler.js
echo const Jimp = require('jimp');>>eagler.js
echo >>eagler.js
echo const listenPort = 80;>>eagler.js
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






