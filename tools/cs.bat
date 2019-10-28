rem @echo off
REM cs.bat
REM summary: Collects everything for a OOLoadStyles release
REM          and puts it into localized setup directories to be zipped.
REM author: Peter Triesberger
REM see: https://github.com/peter88213/OOLoadStyles
REM license: The MIT License (https://opensource.org/licenses/mit-license.php)
REM copyright: (c) 2019, Peter Triesberger
REM since: 2019-06-25

set _release=1.0.2

set _project=OOLoadStyles

set _root=..

rem ********************************************************
rem English/international release
rem ********************************************************

rem --------------------------------------------------------
rem Set up directory structure
rem --------------------------------------------------------

set _source=%_root%\
set _target=%_root%\build\OOLoadStyles_v%_release%

if exist %_target% rd /s /q %_target%
mkdir %_target%
mkdir %_target%\program
mkdir %_target%\fonts
mkdir %_target%\add-on

copy %_source%\add-on\*.* %_target%\add-on\
copy %_source%\fonts\*.* %_target%\fonts\

rem --------------------------------------------------------
rem Generate english README file with release info
rem --------------------------------------------------------

echo OOLoadStyles (OpenOffice style loader) v%_release%>%_target%\README.txt
echo For further information see https://github.com/peter88213/OOLoadStyles/wiki/>>%_target%\README.txt
echo Icons made by Freepik (https://www.freepik.com) from Flaticon (https://www.flaticon.com) are licensed by Creative Commons BY 3.0 (http://creativecommons.org/licenses/by/3.0/).>>%_target%\README.txt

rem --------------------------------------------------------
rem Copy language dependent release items 
rem --------------------------------------------------------

set _file=%_root%\tools\Install.bat
set _dest=%_target%\
call :copyFile

set _file=%_root%\tools\Uninstall.bat
set _dest=%_target%\
call :copyFile

set _file=%_root%\oxt\OOLoadStyles-%_release%.oxt
set _dest=%_target%\program\
call :copyFile

set _file=%_root%\oxt\OOLoadStyles-A-%_release%.oxt
set _dest=%_target%\program\
call :copyFile

set _file=%_root%\oxt\OOLoadStyles-L-%_release%.oxt
set _dest=%_target%\program\
call :copyFile

set _file=%_source%\ott\Default.ott
set _dest=%_target%\program\
call :copyFile

set _file=%_source%\ott\StandardPages.ott
set _dest=%_target%\program\
call :copyFile

set _file=%_source%\ott\Printout.ott
set _dest=%_target%\program\
call :copyFile

set _file=%_root%\LICENSE
set _dest=%_target%\
call :copyFile

exit /b


:copyFile

rem --------------------------------------------------------
rem Copy a file
rem --------------------------------------------------------

if not exist %_file% goto error
copy /y  %_file% %_dest%
exit /b


:error

rmdir /s /q %_target%
echo ERROR: %_file% does not exist!
pause
exit

:end