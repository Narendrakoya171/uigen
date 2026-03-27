@echo off
REM Fix ai/react module error and start dev server

cd /d d:\Angularpractice\uigen

echo.
echo ============================================================
echo         FIXING AI MODULE ERROR & STARTING SERVER
echo ============================================================
echo.

echo [1/3] Updating ai package to latest version...
call npm install ai@latest
if errorlevel 1 (
    echo ERROR: Failed to update ai package
    pause
    exit /b 1
)
echo [✓] AI package updated
echo.

echo [2/3] Reinstalling dependencies...
call npm install
if errorlevel 1 (
    echo ERROR: npm install failed
    pause
    exit /b 1
)
echo [✓] Dependencies ready
echo.

echo [3/3] Starting development server...
echo The server should start on http://localhost:3000
echo.
call npm run dev

pause
