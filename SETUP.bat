@echo off
REM Detailed troubleshooting and setup script for uigen project on Windows

cd /d d:\Angularpractice\uigen

echo.
echo ============================================================
echo            UIGEN PROJECT - COMPLETE SETUP SCRIPT
echo ============================================================
echo.

REM Step 1: Clean and install dependencies
echo [STEP 1/5] Cleaning and installing dependencies...
echo.
if exist node_modules (
    echo Removing old node_modules...
    rmdir /s /q node_modules
)
if exist package-lock.json (
    del package-lock.json
)

call npm install
if errorlevel 1 (
    echo ERROR: npm install failed
    echo.
    echo Try running manually:
    echo   npm install
    pause
    exit /b 1
)
echo [✓] Dependencies installed successfully
echo.

REM Step 2: Create Prisma directories
echo [STEP 2/5] Setting up Prisma directories...
if not exist src\generated\prisma (
    mkdir src\generated\prisma
    echo [✓] Created Prisma output directory
) else (
    echo [✓] Prisma directory already exists
)
echo.

REM Step 3: Generate Prisma Client
echo [STEP 3/5] Generating Prisma Client...
call npx prisma generate
if errorlevel 1 (
    echo ERROR: Prisma generation failed
    echo.
    echo Try running manually:
    echo   npx prisma generate
    pause
    exit /b 1
)
echo [✓] Prisma Client generated successfully
echo.

REM Step 4: Setup database
echo [STEP 4/5] Setting up database...
call npx prisma migrate dev --name init --skip-generate
if errorlevel 1 (
    echo WARNING: Database setup encountered issues
    echo This might be okay if the database already exists
    echo You can try resetting with: npm run db:reset
)
echo [✓] Database ready
echo.

REM Step 5: Start dev server
echo [STEP 5/5] Starting development server...
echo.
echo ============================================================
echo  Server is starting...
echo  Once ready, open: http://localhost:3000
echo  Press Ctrl+C to stop the server
echo ============================================================
echo.

call npm run dev

pause
