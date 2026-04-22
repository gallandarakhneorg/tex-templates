@REM Written by Stephane Galland <stephane.galland@utbm.fr>
@echo off
set CURRENTDIR=%~dp0
kpsewhich -var-value TEXMFVAR > tmp
set /p TEXMFVARDIR=<tmp
kpsewhich -var-value TEXMFHOME > tmp
set /p TEXMFHOMEDIR=<tmp
if "empty%TEXMFHOMEDIR%"=="empty" kpsewhich -var-value TEXMFLOCAL > tmp
set /p TEXMFHOMEDIR=<tmp
mkdir "%TEXMFVARDIR%\fonts\afm\lucas\thesans"
mkdir "%TEXMFVARDIR%\fonts\map\lucas\thesans"
mkdir "%TEXMFVARDIR%\fonts\tfm\lucas\thesans"
mkdir "%TEXMFVARDIR%\fonts\type1\lucas\thesans"
mkdir "%TEXMFVARDIR%\fonts\vf\lucas\thesans"
mkdir "%TEXMFVARDIR%\tex\latex\lucas\thesans"
mkdir "%TEXMFHOMEDIR%\web2c\"
xcopy /C /Y "%CURRENTDIR%\fonts\"*.afm "%TEXMFVARDIR%\fonts\afm\lucas\thesans"
xcopy /C /Y "%CURRENTDIR%\fonts\"*.map "%TEXMFVARDIR%\fonts\map\lucas\thesans"
xcopy /C /Y "%CURRENTDIR%\fonts\"*.tfm "%TEXMFVARDIR%\fonts\tfm\lucas\thesans"
xcopy /C /Y "%CURRENTDIR%\fonts\"*.pfb "%TEXMFVARDIR%\fonts\type1\lucas\thesans"
xcopy /C /Y "%CURRENTDIR%\fonts\"*.vf "%TEXMFVARDIR%\fonts\vf\lucas\thesans"
xcopy /C /Y "%CURRENTDIR%\fonts\"*.fd "%TEXMFVARDIR%\tex\latex\lucas\thesans"
copy /Y /B "%CURRENTDIR%\fonts\"*.cfg "%TEXMFHOMEDIR%\web2c\updmap.cfg"
mktexlsr
updmap
del tmp
echo The font files were installed in:
echo %TEXMFVARDIR%
echo %TEXMFHOMEDIR%
pause
