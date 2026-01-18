@echo off
echo ========================================
echo Prisma Migration Setup Script
echo ========================================
echo.

echo This script will help you run the database migration
echo for the employee check-in/check-out feature.
echo.

echo Step 1: Checking for .env file...
if exist .env (
    echo [OK] .env file exists
) else (
    echo [WARNING] .env file not found
    echo.
    echo Please create a .env file in the Backend folder with:
    echo DATABASE_URL="your-database-connection-string"
    echo JWT_SECRET="your-secret-key"
    echo BCRYPT_ROUNDS=10
    echo.
    pause
    exit /b 1
)

echo.
echo Step 2: Running Prisma migration...
call npx prisma migrate dev --name add_employee_checkin_status

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [ERROR] Migration failed!
    echo.
    echo Common issues:
    echo 1. DATABASE_URL not set in .env file
    echo 2. Database server not running
    echo 3. Invalid database credentials
    echo.
    pause
    exit /b 1
)

echo.
echo Step 3: Generating Prisma client...
call npx prisma generate

if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Prisma generate failed!
    pause
    exit /b 1
)

echo.
echo ========================================
echo [SUCCESS] Migration completed!
echo ========================================
echo.
echo The following fields have been added to Employee table:
echo - isCheckedIn (Boolean)
echo - lastCheckIn (DateTime)
echo - lastCheckOut (DateTime)
echo.
echo Next steps:
echo 1. Restart your backend server
echo 2. Try the check-in button again
echo.
pause
