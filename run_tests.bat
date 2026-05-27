@echo off
:: Set directory to the location of this batch file
cd /d "%~dp0phm_project"

echo === Student A ===
scilab-cli -nb -quit -f test_suites\test_studentA.sci 2>nul

echo === Student B ===
scilab-cli -nb -quit -f test_suites\test_studentB.sci 2>nul

echo === Student C ===
scilab-cli -nb -quit -f test_suites\test_studentC.sci 2>nul

echo === Student D ===
scilab -nw -nb -quit -f test_suites\test_studentD.sci 2>nul

echo === Integration ===
scilab -nw -nb -quit -f test_suites\run_all_tests.sci 2>nul

echo === Main Pipeline ===
scilab -nw -nb -quit -f main.sce 2>nul

echo === PNG Check ===
if exist "pump_health_report_v2.png" (
    for %%I in (pump_health_report_v2.png) do echo %%~zI bytes - pump_health_report_v2.png
    echo PNG generated successfully
) else (
    echo FAIL: pump_health_report_v2.png not found
)

echo.
echo === ALL DONE ===
echo.
pause