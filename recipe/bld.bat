:: MSVC is preferred.
set CC=cl.exe
set CXX=cl.exe

:: set pkg-config path so that host deps can be found
set "PKG_CONFIG_PATH=%LIBRARY_LIB%\pkgconfig;%LIBRARY_PREFIX%\share\pkgconfig;%BUILD_PREFIX%\Library\lib\pkgconfig"

mkdir build
cd build

cmake ^
    -G "Ninja" ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DFTDI_EEPROM=OFF ^
    -DSTATICLIBS=OFF ^
    -DEXAMPLES=OFF ^
    -DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=TRUE ^
    %SRC_DIR%
if errorlevel 1 exit 1

:: Build.
cmake --build . --config Release
if errorlevel 1 exit 1

:: Install.
cmake --build . --config Release --target install
if errorlevel 1 exit 1
