@echo off

set /p URL="please input the URL you want to use: "

set /p DelayTimeout="please input the delay between pings you want to use (in seconds. Use -1 for infinite): "

set /p DelayPing="please input the max. ping delay you want to use (in ms): "

set /p PingSize="please input the ping-size you want to use (in bytes): "

del %cd%\configs\URL.conf
del %cd%\configs\DelayPing.conf
del %cd%\configs\PingSize.conf
del %cd%\configs\TimeoutDelay.conf

echo %URL% >> %cd%\configs\URL.conf
echo %DelayPing% >> %cd%\configs\DelayPing.conf
echo %PingSize% >> %cd%\configs\PingSize.conf
echo %DelayTimeout% >> %cd%\configs\TimeoutDelay.conf

set /p Continue="configuration complete. Would you like to start the main script? [y/n]: "

if %Continue%==y (
start %cd%\PingLog.bat
exit
) else (
exit
)
