@echo off
REM Complete compile error fix script

cd /d d:\Angularpractice\uigen

echo.
echo ============================================================
echo          FIXING COMPILE ERRORS - COMPLETE FIX
echo ============================================================
echo.

REM Clean build artifacts
echo [STEP 1/5] Cleaning build artifacts...
if exist .next (
    rmdir /s /q .next
    echo Removed .next
)
if exist dist (
    rmdir /s /q dist
    echo Removed dist
)
call npm cache clean --force
echo [✓] Build artifacts cleaned
echo.

REM Reinstall dependencies
echo [STEP 2/5] Clean dependency install...
if exist node_modules (
    rmdir /s /q node_modules
    echo Removed node_modules
)
if exist package-lock.json (
    del package-lock.json
    echo Removed package-lock.json
)
call npm install
if errorlevel 1 (
    echo ERROR: npm install failed
    pause
    exit /b 1
)
echo [✓] Fresh dependencies installed
echo.

REM Generate Prisma
echo [STEP 3/5] Generating Prisma client...
call npx prisma generate
if errorlevel 1 (
    echo ERROR: Prisma generation failed
    pause
    exit /b 1
)
echo [✓] Prisma generated
echo.

REM TypeScript check
echo [STEP 4/5] Checking TypeScript compilation...
call npx tsc --noEmit
if errorlevel 1 (
    echo WARNING: TypeScript has errors (will attempt to continue)
)
echo [✓] TypeScript check complete
echo.

REM Start dev server
echo [STEP 5/5] Starting development server...
echo The server should start on http://localhost:3000
echo.
call npm run dev

pause
