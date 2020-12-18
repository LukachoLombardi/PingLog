@echo off

rem setting some variables
set TimeStarted=%date%:%time%
set /A TimesReached = 0
set /A TimesFailed = 0

rem loading config files
set /p URL=<%cd%\configs\URL.conf
set /p delayPing=<%cd%\configs\DelayPing.conf
set /p PingSize=<%cd%\configs\PingSize.conf
set /p timeout=<%cd%\configs\TimeoutDelay.conf


rem giving some output about the entered URL
echo starting Ping with URL "%URL%", a maximum ping delay of %delayPing% and a ping-size of %PingSize%

rem deleting old "OLDstats" and "OLDreach" logfiles and swapping them out with "reach" and "stats", so that the program wont overwrite the previous logs
echo >> %cd%\logs\OLDreach.log
echo >> %cd%\logs\OLDstats.log
del %cd%\logs\OLDreach.log
del %cd%\logs\OLDStats.log
echo >> %cd%\logs\reach.log
echo >> %cd%\logs\stats.log
ren %cd%\logs\reach.log OLDreach.log
ren %cd%\logs\stats.log OLDstats.log


:loop 
rem setting the current time
set CurrentTime=%date%:%time%


rem some code i found that checks if the ping was successful. Uses the delay and Pingsize from the config files
ping  %URL% -n 1 -w %delayPing% -l %PingSize% -4 | find /i "TTL" >nul 2>&1
if errorlevel 1 (

rem raises the failed-counter by 1
set /A TimesFailed = TimesFailed + 1

rem sets the last-failed variable to the current time and date
set LastFailed=%CurrentTime%
rem adds a corresponding line to reach.log and displays the same output in cmd
echo can't reach %URL% at %CurrentTime%. Last Reached at %LastReached% >> %cd%\logs\reach.log
echo can't reach %URL% at %CurrentTime%. Last Reached at %LastReached%

) else (

rem basically the same thing from above but with succcesful pings
set LastReached=%CurrentTime%
set /A TimesReached = TimesReached + 1
echo reached %URL% at %CurrentTime%. >> %cd%\logs\reach.log
echo reached %URL% at %CurrentTime%.
)

rem adds an empty line to the reach-log after every entry
echo. >> %cd%\logs\reach.log

rem writes the stats-logfile new every time executed
del %cd%\logs\stats.log
echo STATS: >> %cd%\logs\stats.log
echo. >> %cd%\logs\stats.log
echo Time Started: %TimeStarted% >> %cd%\logs\stats.log
echo. >> %cd%\logs\stats.log
echo Timeout-Delay: %timeout% seconds >> %cd%\logs\stats.log
echo. >> %cd%\logs\stats.log
echo Max. Ping-Delay: %delayPing% >> %cd%\logs\stats.log
echo. >> %cd%\logs\stats.log
echo Ping-Size: %PingSize% >> %cd%\logs\stats.log
echo. >> %cd%\logs\stats.log
echo Times Reached: %TimesReached% >> %cd%\logs\stats.log
echo. >> %cd%\logs\stats.log
echo Times Failed: %TimesFailed% >> %cd%\logs\stats.log
echo. >> %cd%\logs\stats.log
echo Last Time Reached: %LastReached% >> %cd%\logs\stats.log
echo. >> %cd%\logs\stats.log
echo Last Time Failed: %LastFailed% >> %cd%\logs\stats.log

timeout /t %timeout%

goto loop


pause
exit




