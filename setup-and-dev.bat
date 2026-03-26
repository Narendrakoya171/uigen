@echo off
REM Comprehensive setup and development server startup script for Windows
REM This script will clean install everything and start the dev server

cd /d d:\Angularpractice\uigen

echo ========================================
echo Installing dependencies...
echo ========================================
call npm ci
if errorlevel 1 (
    echo ERROR: npm ci failed
    pause
    exit /b 1
)

echo.
echo ========================================
echo Generating Prisma Client...
echo ========================================
call npx prisma generate
if errorlevel 1 (
    echo ERROR: prisma generate failed
    pause
    exit /b 1
)

echo.
echo ========================================
echo Setting up database...
echo ========================================
call npx prisma migrate dev --name init --skip-generate
if errorlevel 1 (
    echo WARNING: Database setup had issues (this may be ok if already initialized)
)

echo.
echo ========================================
echo Starting development server...
echo ========================================
echo The dev server should now be running on http://localhost:3000
echo Press Ctrl+C to stop the server
echo.
call npm run dev

pause
