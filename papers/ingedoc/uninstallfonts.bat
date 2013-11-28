@REM Written by Stephane Galland <stephane.galland@utbm.fr>
@echo off
set CURRENTDIR=%~dp0
kpsewhich -var-value TEXMFVAR > tmp
set /p TEXMFVARDIR=<tmp
kpsewhich -var-value TEXMFHOME > tmp
set /p TEXMFHOMEDIR=<tmp
del /f /s /q "%TEXMFVARDIR%/fonts/afm/lucas"
del /f /s /q "%TEXMFVARDIR%/fonts/map/lucas"
del /f /s /q "%TEXMFVARDIR%/fonts/tfm/lucas"
del /f /s /q "%TEXMFVARDIR%/fonts/type1/lucas"
del /f /s /q "%TEXMFVARDIR%/fonts/vf/lucas"
del /f /s /q "%TEXMFVARDIR%/tex/latex/lucas"
del /f /s /q "%TEXMFVARDIR%/web2c"
del /f /s /q "%TEXMFVARDIR%/fonts/map/dvipdfm"
del /f /s /q "%TEXMFVARDIR%/fonts/map/dvips"
del /f /s /q "%TEXMFVARDIR%/fonts/map/pdftex"
del /f /s /q "%TEXMFHOMEDIR%\web2c\updmap.cfg"
mktexlsr
updmap
del tmp
echo The font files were uninstalled from:
echo %TEXMFVARDIR%
echo %TEXMFHOMEDIR%
pause
