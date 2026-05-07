// ============================================================
// run_all_tests.sci  —  Master Test Runner  (Version 2)
// Executes all student unit tests + integration test
// ============================================================

funcprot(0);
base = get_absolute_file_path('run_all_tests.sci');

disp('');
disp('======================================================');
disp('   ENS 184 — Pump Health Monitoring V2  |  Test Suite');
disp('======================================================');

exec(fullfile(base, 'test_studentA.sci'), -1);
disp('');
exec(fullfile(base, 'test_studentB.sci'), -1);
disp('');
exec(fullfile(base, 'test_studentC.sci'), -1);
disp('');
exec(fullfile(base, 'test_studentD.sci'), -1);
disp('');
exec(fullfile(base, 'test_integration.sci'), -1);

disp('');
disp('======================================================');
disp('   All tests complete.');
disp('======================================================');
