#!/bin/bash
cd /home/ryan/Desktop/Projex/ENS184Project/phm_project

echo "=== Student A ==="
scilab-cli -nb -quit -f test_suites/test_studentA.sci 2>/dev/null

echo "=== Student B ==="
scilab-cli -nb -quit -f test_suites/test_studentB.sci 2>/dev/null

echo "=== Student C ==="
scilab-cli -nb -quit -f test_suites/test_studentC.sci 2>/dev/null

echo "=== Student D ==="
xvfb-run scilab -nw -nb -quit -f test_suites/test_studentD.sci 2>/dev/null

echo "=== Integration ==="
xvfb-run scilab -nw -nb -quit -f test_suites/run_all_tests.sci 2>/dev/null

echo "=== Main Pipeline ==="
xvfb-run scilab -nw -nb -quit -f main.sce 2>/dev/null

echo "=== PNG Check ==="
if [ -f "pump_health_report_v2.png" ]; then
    ls -lh pump_health_report_v2.png
    echo "PNG generated successfully"
else
    echo "FAIL: pump_health_report_v2.png not found"
fi

echo ""
echo "=== ALL DONE ==="
echo ""
read -p "Press Enter to close..."
