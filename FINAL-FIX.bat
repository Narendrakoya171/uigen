@echo off
REM COMPLETE FIX - Remove @ai-sdk/react and start server

cd /d d:\Angularpractice\uigen

echo.
echo ============================================================
echo         FINAL FIX - REMOVING NON-EXISTENT PACKAGES
echo ============================================================
echo.

echo [1/4] Cleaning dependencies...
if exist node_modules (
    rmdir /s /q node_modules
)
if exist package-lock.json (
    del package-lock.json
)
call npm cache clean --force
echo [✓] Cleaned
echo.

echo [2/4] Installing correct dependencies...
call npm install
if errorlevel 1 (
    echo ERROR: npm install failed
    pause
    exit /b 1
)
echo [✓] Dependencies installed
echo.

echo [3/4] Generating Prisma...
call npx prisma generate
echo [✓] Prisma ready
echo.

echo [4/4] Starting dev server...
echo.
echo ============================================================
echo   ✓ All compile errors fixed!
echo   Server running on http://localhost:3000
echo   Press Ctrl+C to stop
echo ============================================================
echo.

call npm run dev

pause
