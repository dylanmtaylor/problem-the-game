ECHO This script must be run from the command prompt on a UNC share, unfortunately.
cd %CD%
del game.zip
rmdir distribution
mkdir distribution
zip -r game.zip . * -x loveFiles/* -x distribution/*
copy loveFiles\*.dll distribution\
copy /b "%CD%"\loveFiles\love.exe+game.zip distribution\game.exe
REM "%CD%"\loveFiles\love.exe "%CD%"\game.zip
"%CD%"\distribution\game.exe