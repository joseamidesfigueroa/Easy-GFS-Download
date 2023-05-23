@ECHO OFF	
color 17

mode con: cols=70 lines=55

echo.
echo                                 ***
echo                     PROGRAM TO DOWNLOAD A SUBSECTION
echo           SECTOR AREAS AT 1.00, 0.5 AND 0.25 DEG OF GFS DATA 
echo       	     FOR A MEXICO-CARIBBEAN OR SOUTH-AMERICA SECTOR 
echo	   THIS PROGRAM IS DERIVATES FROM THE ORIGINAL SCRIPT FROM
echo	      by JUAN JOSE AMIDES FIGUEROA, ANGELO PASCUALETTI
echo                     JOSE GALVEZ AND MIKE DAVISON
echo.
echo.
echo.
echo.
echo.
echo	             Juan Jose Amides Figueroa. El Salvador 
echo                -----/ Version 1.99 -- 28/03/2022 \------
echo.
echo.
echo. 
echo	  To run it you will need: 
echo	  (1) Create a folder "C:\data_gfs"
echo	  (2) place this program and "aria.exe" on the aforementioned folder
echo.
echo.
echo.

echo        ------               _____
echo       /      \ ___\     ___/    ___
echo    --/-  ___  /    \/  /  /    /   \
echo   /     /           \__     //_     \
echo  /                     \   / ___     \
echo  /           ___       \//--/        /
echo   \__           \       \           /
echo      \__                 \          /     Dont be selfish,
echo     \     /____      /  /       \   /     Share your knowledge.    
echo          _/         ___       \/  /\         
echo           \__      /      /    /    /     A person is a person
echo         /    \____/   \       /   //      through other people.                           
echo     // / / // / /\    /-_-/\//-__-                  
echo      /  /  // /   \__// / / /  //         Go to the Loonies...
echo     //   / /   //   /  // / // /      
echo      /// // / /   /  //  / //
echo   //   //       //  /  // / /
echo     / / / / /     /  /    /
echo  ///  / / /  //  // /  // //
echo     ///    /    /    / / / /
echo///  /    // / /  // / / /  /
echo   // ///   /      /// / /

echo.
echo.
echo.
echo.
echo.

pause

::WINGRIDDS FOLDERS---------------------------------------------------------------------
set foldertempdata=C:\data_gfs\temp
set folderaria2c=C:\data_gfs\aria2c
set folderdata=C:\data_gfs
::set folderwingridds=C:\WINGRIDDS

::ERASE RESIDUAL DATA-------------------------------------------------------------------
C:
cd %foldertempdata%
del *.* /Q
cd %folderdata%
del *.* /Q
cd %folderaria2c%
copy aria2c.exe %folderdata%
cd %folderdata%
:: FINISH CLEANING----------------------------------------------------------------------

:: DEFINE COORDINATES OF SECTOR TO DOWNLOAD -----------------------------
:: COORDINATES ARE SET FOR A MEXICO-CARIBBEAN SECTOR --------------------

::cd C:\WINGRIDDS\datosector_gfs\en

cls
 echo Please select the area to use. 
 echo.
 echo.
echo ---------------------------------------------
echo  ::::::::::::::`::.---::::.  `           
echo  ::::::::::::::-::--::::-.               
echo  :::::::::::::::::::::-.                 
echo  :::::::::::::::::::::-                  
echo  :::::::::::::::::::-.                   
echo  :::::::::::::-::::`                     
echo  ::::::-`` ``   ``:`                     
echo  ::::::`          .-                     
echo  :::::-           `` `                   
echo  -:::::`    .-.  ````..` ``              
echo  `.-:::-.--:-       `` ``..` `          
echo       ```.:::-..`                        
echo            `..:::`                       
echo                .:`     `.--.-....-..     
echo                 `...`..::::::::::::::-.``
echo                       :::::::::::::::::::
echo                       -::::::::::::::::::
echo                     .:::::::::::::::::::: 
echo.
echo For MEXICO-CARIBBEAN	Type: 1
echo ---------------------------------------------
echo.
echo.
echo ---------------------------------------------
echo   `.....`           
echo  `---.-....``       
echo `..--..---.-.`      
echo .--..--------.-...``
echo  .-..--------------.
echo   ..-.------------` 
echo     `.---..------.  
echo      ..-.-..--..``  
echo      .----..--`     
echo      .----.-.`      
echo      .-----`        
echo      .--.``         
echo      `--`           
echo      ..-`           
echo      `..            
echo        ``      
echo For SOUTH-AMERICA	Type: 2
echo ---------------------------------------------
echo.
echo.
set /p area= What is Your Choice? 
echo.
IF %area% EQU 1 (set toplat=37) ELSE (set toplat=8) 
IF %area% EQU 1 (set leftlon=-119) ELSE (set leftlon=-88)
IF %area% EQU 1 (set bottomlat=-1) ELSE (set bottomlat=-60)
IF %area% EQU 1 (set rightlon=-42) ELSE (set rightlon=-30)
IF %area% EQU 1 (set region=MEXICO-CARIBBEAN) ELSE (set region=SOUTH-AMERICA)

::FORCE THE DATE TO DOWNLOAD---------------------------------------------
echo Please input date in format: YYYYMMDD:  
echo.
set /p date_string= Type the date: 
echo.
echo Now Input the GFS cycle to download in format: 00, 06, 12, 18: 
echo.
set /p cycle= Type the cycle: 
echo.
echo Choose the GFS resolution to download: 
echo.
echo For 0.50 deg	Type 1 
echo For 0.25 deg	Type 2
echo For 1.00 deg 	Type 3
echo.
set /p res= What is Your Choice?  
echo.

IF %res% EQU 1 (set data_type=0p50)
IF %res% EQU 1 (set resolution_name=0.50)
IF %res% EQU 2 (set data_type=0p25)
IF %res% EQU 2 (set resolution_name=0.25)
IF %res% EQU 3 (set data_type=1p00)
IF %res% EQU 3 (set resolution_name=1.00)
IF %res% EQU 1 (set text=pgrb2full)
IF %res% EQU 2 (set text=pgrb2)
IF %res% EQU 3 (set text=pgrb2)

echo.
echo.
echo The region to download is %region%
echo The data to use are: %date_string% 
echo The cycle %cycle%UTC and %resolution_name% degrees of resolution
echo.
echo Ready to begin?
echo.
PAUSE

::cd C:\WINGRIDDS\datosector_gfs\en 

					
::DATA DOWNLOAD----------------------------------------------------------

START /B aria2c.exe -j7 -k1M -x16 --check-certificate=false "https://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_%data_type%.pl?file=gfs.t%cycle%z.%text%.%data_type%.f000&all_lev=on&all_var=on&subregion=&leftlon=%leftlon%&rightlon=%rightlon%&toplat=%toplat%&bottomlat=%bottomlat%&dir=%%2Fgfs.%date_string%%%2F%cycle%%%2Fatmos"
START /B aria2c.exe -j7 -k1M -x16 --check-certificate=false "https://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_%data_type%.pl?file=gfs.t%cycle%z.%text%.%data_type%.f006&all_lev=on&all_var=on&subregion=&leftlon=%leftlon%&rightlon=%rightlon%&toplat=%toplat%&bottomlat=%bottomlat%&dir=%%2Fgfs.%date_string%%%2F%cycle%%%2Fatmos"
START /B aria2c.exe -j7 -k1M -x16 --check-certificate=false "https://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_%data_type%.pl?file=gfs.t%cycle%z.%text%.%data_type%.f012&all_lev=on&all_var=on&subregion=&leftlon=%leftlon%&rightlon=%rightlon%&toplat=%toplat%&bottomlat=%bottomlat%&dir=%%2Fgfs.%date_string%%%2F%cycle%%%2Fatmos"
START /B aria2c.exe -j7 -k1M -x16 --check-certificate=false "https://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_%data_type%.pl?file=gfs.t%cycle%z.%text%.%data_type%.f018&all_lev=on&all_var=on&subregion=&leftlon=%leftlon%&rightlon=%rightlon%&toplat=%toplat%&bottomlat=%bottomlat%&dir=%%2Fgfs.%date_string%%%2F%cycle%%%2Fatmos"
START /B aria2c.exe -j7 -k1M -x16 --check-certificate=false "https://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_%data_type%.pl?file=gfs.t%cycle%z.%text%.%data_type%.f024&all_lev=on&all_var=on&subregion=&leftlon=%leftlon%&rightlon=%rightlon%&toplat=%toplat%&bottomlat=%bottomlat%&dir=%%2Fgfs.%date_string%%%2F%cycle%%%2Fatmos"
START /B aria2c.exe -j7 -k1M -x16 --check-certificate=false "https://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_%data_type%.pl?file=gfs.t%cycle%z.%text%.%data_type%.f030&all_lev=on&all_var=on&subregion=&leftlon=%leftlon%&rightlon=%rightlon%&toplat=%toplat%&bottomlat=%bottomlat%&dir=%%2Fgfs.%date_string%%%2F%cycle%%%2Fatmos"
START /B aria2c.exe -j7 -k1M -x16 --check-certificate=false "https://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_%data_type%.pl?file=gfs.t%cycle%z.%text%.%data_type%.f036&all_lev=on&all_var=on&subregion=&leftlon=%leftlon%&rightlon=%rightlon%&toplat=%toplat%&bottomlat=%bottomlat%&dir=%%2Fgfs.%date_string%%%2F%cycle%%%2Fatmos"
START /B aria2c.exe -j7 -k1M -x16 --check-certificate=false "https://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_%data_type%.pl?file=gfs.t%cycle%z.%text%.%data_type%.f042&all_lev=on&all_var=on&subregion=&leftlon=%leftlon%&rightlon=%rightlon%&toplat=%toplat%&bottomlat=%bottomlat%&dir=%%2Fgfs.%date_string%%%2F%cycle%%%2Fatmos"
START /B aria2c.exe -j7 -k1M -x16 --check-certificate=false "https://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_%data_type%.pl?file=gfs.t%cycle%z.%text%.%data_type%.f048&all_lev=on&all_var=on&subregion=&leftlon=%leftlon%&rightlon=%rightlon%&toplat=%toplat%&bottomlat=%bottomlat%&dir=%%2Fgfs.%date_string%%%2F%cycle%%%2Fatmos"
START /B aria2c.exe -j7 -k1M -x16 --check-certificate=false "https://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_%data_type%.pl?file=gfs.t%cycle%z.%text%.%data_type%.f054&all_lev=on&all_var=on&subregion=&leftlon=%leftlon%&rightlon=%rightlon%&toplat=%toplat%&bottomlat=%bottomlat%&dir=%%2Fgfs.%date_string%%%2F%cycle%%%2Fatmos"
START /B aria2c.exe -j7 -k1M -x16 --check-certificate=false "https://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_%data_type%.pl?file=gfs.t%cycle%z.%text%.%data_type%.f060&all_lev=on&all_var=on&subregion=&leftlon=%leftlon%&rightlon=%rightlon%&toplat=%toplat%&bottomlat=%bottomlat%&dir=%%2Fgfs.%date_string%%%2F%cycle%%%2Fatmos"
START /B aria2c.exe -j7 -k1M -x16 --check-certificate=false "https://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_%data_type%.pl?file=gfs.t%cycle%z.%text%.%data_type%.f066&all_lev=on&all_var=on&subregion=&leftlon=%leftlon%&rightlon=%rightlon%&toplat=%toplat%&bottomlat=%bottomlat%&dir=%%2Fgfs.%date_string%%%2F%cycle%%%2Fatmos"
START /B aria2c.exe -j7 -k1M -x16 --check-certificate=false "https://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_%data_type%.pl?file=gfs.t%cycle%z.%text%.%data_type%.f072&all_lev=on&all_var=on&subregion=&leftlon=%leftlon%&rightlon=%rightlon%&toplat=%toplat%&bottomlat=%bottomlat%&dir=%%2Fgfs.%date_string%%%2F%cycle%%%2Fatmos"
START /B aria2c.exe -j7 -k1M -x16 --check-certificate=false "https://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_%data_type%.pl?file=gfs.t%cycle%z.%text%.%data_type%.f078&all_lev=on&all_var=on&subregion=&leftlon=%leftlon%&rightlon=%rightlon%&toplat=%toplat%&bottomlat=%bottomlat%&dir=%%2Fgfs.%date_string%%%2F%cycle%%%2Fatmos"
START /B aria2c.exe -j7 -k1M -x16 --check-certificate=false "https://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_%data_type%.pl?file=gfs.t%cycle%z.%text%.%data_type%.f084&all_lev=on&all_var=on&subregion=&leftlon=%leftlon%&rightlon=%rightlon%&toplat=%toplat%&bottomlat=%bottomlat%&dir=%%2Fgfs.%date_string%%%2F%cycle%%%2Fatmos"
START /B aria2c.exe -j7 -k1M -x16 --check-certificate=false "https://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_%data_type%.pl?file=gfs.t%cycle%z.%text%.%data_type%.f090&all_lev=on&all_var=on&subregion=&leftlon=%leftlon%&rightlon=%rightlon%&toplat=%toplat%&bottomlat=%bottomlat%&dir=%%2Fgfs.%date_string%%%2F%cycle%%%2Fatmos"
START /B aria2c.exe -j7 -k1M -x16 --check-certificate=false "https://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_%data_type%.pl?file=gfs.t%cycle%z.%text%.%data_type%.f096&all_lev=on&all_var=on&subregion=&leftlon=%leftlon%&rightlon=%rightlon%&toplat=%toplat%&bottomlat=%bottomlat%&dir=%%2Fgfs.%date_string%%%2F%cycle%%%2Fatmos"
START /B aria2c.exe -j7 -k1M -x16 --check-certificate=false "https://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_%data_type%.pl?file=gfs.t%cycle%z.%text%.%data_type%.f102&all_lev=on&all_var=on&subregion=&leftlon=%leftlon%&rightlon=%rightlon%&toplat=%toplat%&bottomlat=%bottomlat%&dir=%%2Fgfs.%date_string%%%2F%cycle%%%2Fatmos"
START /B aria2c.exe -j7 -k1M -x16 --check-certificate=false "https://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_%data_type%.pl?file=gfs.t%cycle%z.%text%.%data_type%.f108&all_lev=on&all_var=on&subregion=&leftlon=%leftlon%&rightlon=%rightlon%&toplat=%toplat%&bottomlat=%bottomlat%&dir=%%2Fgfs.%date_string%%%2F%cycle%%%2Fatmos"
START /B aria2c.exe -j7 -k1M -x16 --check-certificate=false "https://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_%data_type%.pl?file=gfs.t%cycle%z.%text%.%data_type%.f114&all_lev=on&all_var=on&subregion=&leftlon=%leftlon%&rightlon=%rightlon%&toplat=%toplat%&bottomlat=%bottomlat%&dir=%%2Fgfs.%date_string%%%2F%cycle%%%2Fatmos"
START /B aria2c.exe -j7 -k1M -x16 --check-certificate=false "https://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_%data_type%.pl?file=gfs.t%cycle%z.%text%.%data_type%.f120&all_lev=on&all_var=on&subregion=&leftlon=%leftlon%&rightlon=%rightlon%&toplat=%toplat%&bottomlat=%bottomlat%&dir=%%2Fgfs.%date_string%%%2F%cycle%%%2Fatmos"

timeout /t 120

::MOVE DOWNLOADED DATA TO THE NWS FOLDER------------------------------------------------
del *aria2c.exe* /Q
type *.f* > gfs.grib2
::move *gfs.* %folderwingriddsnws%

::CONVERT &all DATA TO THE WINGRIDDS FORMAT----------------------------------------------
::cd %folderwingridds%
::Ngrb2pcg32.exe

cls
echo. 
echo. 
echo                                 `NMNdo`               
echo                                -MMMMMN:              
echo                                +MMMMMMN`             
echo                                mMMMMMMM-             
echo                               +MMMMMMMM`             
echo                              +MMMMMMMMy              
echo                           `/dMMMMMMMMh               
echo                          oNMMMMMMMMMh                
echo                         sMMMMMMMMMMm`                
echo                        +MMMMMMMMMMM:                 
echo                       /MMMMMMMMMMMMdyyyyhhhyyyyso+`  
echo                      +MMMMMMMMMMMMMMMMMMMMMMMMMMMMMo 
echo                    `sMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMh
echo    .+ooooooo/    `+mMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMh
echo    NMMMMMMMMM+ +MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMs 
echo    MMMMMMMMMMo +MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMd`
echo    MMMMMMMMMMo +MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMm
echo    MMMMMMMMMMo +MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMd-
echo    MMMMMMMMMMo +MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMN  
echo    MMMMMMMMMMo +MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM+ 
echo    MMMMMMMMMMo +MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMd 
echo    MMMMMMMMMMo +MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNo` 
echo    MMMMMMMMMMo +MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMN`   
echo    MMMMMMMMMMo +MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMm    
echo    NMMMMMMMMMo /dNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMh.    
echo    .+ooooooo/      `-:/+syhddmmNNNMMMMMMMNNmho.    
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo ******************       Your data is ready to use, bye.
echo.
echo.
echo.
echo.
echo.
echo.
PAUSE