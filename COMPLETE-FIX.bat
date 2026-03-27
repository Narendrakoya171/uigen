@echo off
REM Complete clean install and type definitions fix

cd /d d:\Angularpractice\uigen

echo.
echo ============================================================
echo   FIXING TYPE DECLARATIONS - COMPLETE CLEAN INSTALL
echo ============================================================
echo.

echo [1/5] Removing all build artifacts and cache...
if exist node_modules (
    rmdir /s /q node_modules
    echo Removed node_modules
)
if exist package-lock.json (
    del package-lock.json
    echo Removed package-lock.json
)
if exist .next (
    rmdir /s /q .next
)
call npm cache clean --force
echo [✓] Clean complete
echo.

echo [2/5] Installing all dependencies with types...
call npm install
if errorlevel 1 (
    echo ERROR: npm install failed
    pause
    exit /b 1
)
echo [✓] Dependencies and types installed
echo.

echo [3/5] Ensuring @types packages are installed...
call npm install --save-dev @types/react @types/react-dom @types/node
echo [✓] Type definitions installed
echo.

echo [4/5] Generating Prisma client...
call npx prisma generate
echo [✓] Prisma ready
echo.

echo [5/5] Starting development server...
echo.
echo ============================================================
echo   ✓ Type definitions fixed!
echo   Server running on http://localhost:3000
echo   Press Ctrl+C to stop
echo ============================================================
echo.

call npm run dev

pause
