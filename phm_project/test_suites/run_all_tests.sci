// ============================================================
// run_all_tests.sci  —  Master Test Runner  (Version 2)
// Executes all student unit tests + integration test
// ============================================================

funcprot(0);
runner_base_dir = get_absolute_file_path('run_all_tests.sci');

disp('');
disp('======================================================');
disp('   ENS 184 — Pump Health Monitoring V2  |  Test Suite');
disp('======================================================');

exec(fullfile(runner_base_dir, 'test_studentA.sci'), -1);
disp('');
exec(fullfile(runner_base_dir, 'test_studentB.sci'), -1);
disp('');
exec(fullfile(runner_base_dir, 'test_studentC.sci'), -1);
disp('');
exec(fullfile(runner_base_dir, 'test_studentD.sci'), -1);
disp('');
exec(fullfile(runner_base_dir, 'test_integration.sci'), -1);

disp('');
disp('======================================================');
disp('   All tests complete.');
disp('======================================================');
