@echo off
Echo - - - - - - - - - - - - - - - - 
title Make money by Armiterre

setlocal EnableDelayedExpansion

rem Player variables
set money=555
set energy=100
set luck=50
set backpack_capacity=70
set backpack_count=0
set pickaxe=
set mining_cooldown=5
set character=
set job_license=
set job=
set job_cooldown=10
set job_energy_cost=20

rem Main game loop
:game_loop
cls
echo Welcome to the Adventure Game!
echo.

rem Check for death due to lack of energy
if %energy% leq 0 (
    cls
    echo.
    echo You've run out of energy and died.
    echo.
    echo Your adventure ends here.
    echo.
    echo ---------------------------------
    echo --------------------- R.I.P. ---------------------
    echo ---------------------------------
    timeout /t 5 >nul
    exit /b
)

rem Display player information with colored text
echo Money: $%money%   Energy: %energy%
echo Backpack: %backpack_count%/%backpack_capacity%
echo Pickaxe: %pickaxe%   Mining Cooldown: %mining_cooldown% seconds
echo Character: %character%
echo Job License: %job_license%
echo Job: %job%
echo.

echo What do you want to do?
echo 1. Work (Mining)
echo 2. Rest
echo 3. Shop
echo 4. Save Game
echo 5. About
echo 6. Customize Character
echo 7. Set Job
echo 8. View Backpack
echo 9. Quit
set /p choice=Enter your choice: 

if "%choice%"=="1" (
    call :work
) else if "%choice%"=="2" (
    call :rest
) else if "%choice%"=="3" (
    call :shop
) else if "%choice%"=="4" (
    call :save_game
) else if "%choice%"=="5" (
    start about.txt
) else if "%choice%"=="6" (
    call :customize_character
) else if "%choice%"=="7" (
    call :set_job_license
) else if "%choice%"=="8" (
    call :view_backpack
) else if "%choice%"=="9" (
    echo Thanks for playing!
    exit /b
) else (
    echo Invalid choice. Please try again.
    timeout /t 2 >nul
)

goto game_loop

:work
cls
echo You decided to work (Mining)...
echo.

rem Check if player has the required energy and job license
if %energy% geq %job_energy_cost% (
    if "%job_license%"=="" (
        echo You don't have a job license. Set a job first.
    ) else (
        echo Working...
        timeout /t %job_cooldown% >nul

        rem Simulate luck-based mining
        set /a chance=%random% %% 100
        if !chance! lss %luck% (
            echo You found a mineral!
            if %backpack_count% lss %backpack_capacity% (
                set /a earning=%random% %% 100 + 100
                echo You earned $!earning!.
                set /a money+=!earning!
                set /a backpack_count+=1
                echo Mineral added to backpack.
            ) else (
                echo Your backpack is full. Sell some minerals to make space.
            )
        ) else (
            echo You didn't find any mineral this time.
        )

        echo.
        set /a energy-=%job_energy_cost%
    )
) else (
    echo Not enough energy to work.
)

pause
goto game_loop

:explore
cls
echo You decided to explore.
echo.

rem Check if player has the required energy
if %energy% geq 10 (
    echo Exploring...
    set /a energy-=10  REM Deduct 10 energy for exploring
    echo.

    rem Simulate a random event
    set /a event=%random% %% 3
    echo Event: %event%
    if %event% equ 0 (
        echo You found a treasure chest!
        set /a earning=%random% %% 300 + 100
        echo Earning: %earning%
        echo You earned $%earning%.
        set /a money+=%earning%
    ) else (
        echo You didn't find anything interesting.
    )
) else (
    echo Not enough energy to explore.
)

pause
goto game_loop

:rest
cls
echo You decided to rest.
echo Your energy has been restored.
set energy=100
echo.
pause
goto game_loop

:shop
cls
echo Welcome to the Shop!
echo.

rem Display shop items with colors
echo What do you want to buy?
echo 1. Pickaxe
echo 2. Job License
echo 3. Back to main menu
set /p shop_choice=Enter your choice: 

if "%shop_choice%"=="1" (
    call :buy_pickaxe
) else if "%shop_choice%"=="2" (
    call :buy_job_license
) else if "%shop_choice%"=="3" (
    echo Exiting shop...
    timeout /t

2 >nul
) else (
    echo Invalid choice. Please try again.
    timeout /t 2 >nul
)
goto game_loop

:buy_job_license
cls
echo Welcome to the Job License Office!
echo.

rem Display job license options with colors
echo Choose a job license to buy:
echo 1. Miner License - $500
echo 2. Explorer License - $500
echo 3. Pilot License - $1000
echo 4. Taxi License - $1000
echo 5. Back to shop
set /p job_license_choice=Enter your choice: 

if "%job_license_choice%"=="1" (
    if %money% geq 500 (
        set /a money-=500
        set job_license=Miner
        echo You bought a Miner License, Congrats!!.
        timeout /t 1 >nul
    ) else (
        echo Not enough money to buy a Miner License.
    )
) else if "%job_license_choice%"=="2" (
    if %money% geq 500 (
        set /a money-=500
        set job_license=Explorer
        echo You bought an Explorer License.
        timeout /t 1 >nul
    ) else (
        echo Not enough money to buy an Explorer License.
    )
) else if "%job_license_choice%"=="3" (
    if %money% geq 1000 (
        set /a money-=1000
        set job_license=Pilot
        echo You bought a Pilot License.
        timeout /t 1 >nul
    ) else (
        echo Not enough money to buy a Pilot License.
    )
) else if "%job_license_choice%"=="4" (
    if %money% geq 1000 (
        set /a money-=1000
        set job_license=Taxi
        echo You bought a Taxi License.
        timeout /t 1 >nul
    ) else (
        echo Not enough money to buy a Taxi License.
    )
) else if "%job_license_choice%"=="5" (
    echo Returning to shop...
    timeout /t 2 >nul
) else (
    echo Invalid choice. Please try again.
    timeout /t 2 >nul
    goto shop
)

goto game_loop

:set_job_license
cls
echo.
echo Choose your active job:
echo 1. Miner
echo 2. Explorer
echo 3. Pilot
echo 4. Taxi
echo 5. Resting
echo 6. Back to main menu

set /p job_choice=Enter your choice: 

if "%job_choice%"=="1" (
    if "%job_license%"=="Miner" (
        set job=Miner
        echo Active job set to Miner.
        timeout /t 2 >nul
    ) else (
        echo You don't have a Miner License. Purchase one from the shop.
        timeout /t 2 >nul
    )
) else if "%job_choice%"=="2" (
    if "%job_license%"=="Explorer" (
        set job=Explorer
        echo Active job set to Explorer.
        timeout /t 2 >nul
    ) else (
        echo You don't have an Explorer License. Purchase one from the shop.
        timeout /t 2 >nul
    )
) else if "%job_choice%"=="3" (
    if "%job_license%"=="Pilot" (
        set job=Pilot
        echo Active job set to Pilot.
        timeout /t 2 >nul
    ) else (
        echo You don't have a Pilot License. Purchase one from the shop.
        timeout /t 2 >nul
    )
) else if "%job_choice%"=="4" (
    if "%job_license%"=="Taxi" (
        set job=Taxi
        echo Active job set to Taxi.
        timeout /t 2 >nul
    ) else (
        echo You don't have a Taxi License. Purchase one from the shop.
        timeout /t 2 >nul
    )
) else if "%job_choice%"=="5" (
    set job=Resting
    echo Active job set to Resting.
    timeout /t 2 >nul
) else if "%job_choice%"=="6" (
    echo Returning to main menu...
    timeout /t 2 >nul
) else (
    echo Invalid choice. Please try again.
    timeout /t 2 >nul
    goto set_job_license
)

goto game_loop

:view_backpack
cls
echo.
echo Items in your backpack:
echo.
REM Loop through the backpack items and display them
for /L %%i in (1,1,%backpack_count%) do (
    echo %%i. !backpack_item[%%i]!
)
echo.
echo What would you like to do?
echo 1. Sell an item
echo 2. Back to main menu
set /p backpack_choice=Enter your choice: 

if "%backpack_choice%"=="1" (
    call :sell_item
) else if "%backpack_choice%"=="2" (
    echo Returning to main menu...
    timeout /t 2 >nul
) else (
    echo Invalid choice. Please try again.
    timeout /t 2 >nul
    goto view_backpack
)

goto game_loop

:sell_item
cls
echo Enter the number corresponding to the item you want to sell:
set /p sell_choice=Item number: 

if %sell_choice% gtr 0 (
    if %sell_choice% leq %backpack_count% (
        REM Get the item value from backpack_item array
        set /a earning=!backpack_item[%sell_choice%]!
        echo You sold !backpack_item[%sell_choice%]! for $!earning!.
        set /a money+=!earning!
        REM Remove the item from the backpack
        set /a backpack_count-=1
        for /L %%j in (%sell_choice%,1,%backpack_count%) do (
            set /a next_index=%%j+1
            set backpack_item[%%j]=!backpack_item[!next_index!]!
        )
        set backpack_item[%backpack_count%]=
        pause
    ) else (
        echo Invalid item number. Please try again.
        timeout /t 2 >nul
    )
) else (
    echo Invalid item number. Please try again.
    timeout /t 2 >nul
)
goto view_backpack

:save_game
cls
set /p save_file=Enter the name of the save file: 
echo Saving game to "Game Save\%save_file%.txt"...
echo money=%money%> "Game Save\%save_file%.txt"
echo energy=%energy%>> "Game Save\%save_file%.txt"
echo luck=%luck%>> "Game Save\%save_file%.txt"
echo backpack_capacity=%backpack_capacity%>> "Game Save\%save_file%.txt"
echo backpack_count =%backpack_count%>> "Game Save\%save_file%.txt"
echo pickaxe=%pickaxe%>> "Game Save\%save_file%.txt"
echo mining_cooldown=%mining_cooldown%>> "Game Save\%save_file%.txt"
echo character=%character%>> "Game Save\%save_file%.txt"
echo job_license=%job_license%>> "Game Save\%save_file%.txt"
echo job=%job%>> "Game Save\%save_file%.txt"
echo Saved game to "Game Save\%save_file%.txt".
echo.
pause
goto game_loop