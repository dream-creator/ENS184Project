======================================================================
  ENS 184  |  FlowGuard 5000  |  Pump Health Monitoring
  Mini-Project Starter Package  —  Version 2
======================================================================

READ THIS FILE BEFORE OPENING ANY CODE.

----------------------------------------------------------------------
WHAT IS INCLUDED
----------------------------------------------------------------------

  README.txt                     <- this file
  pump_health_data.csv           <- sensor dataset (120 rows, 4 columns)
  project_manual_v2.pdf          <- full project manual with theory,
                                    task descriptions, and Scilab reference
  target_outputs/
    pump_health_report_v2.png    <- target 2-panel dashboard (Task D3)
    pump_health_diagnostic_v2.png<- target 4-panel diagnostic (full system)

  phm_project/                   <- TEAM integration workspace
    main.sce                       complete when integrating
    warmup_scilab.sce              run this first (see below)
    data_loader/
      load_data.sci                stub — paste Student D's implementation here
    interpolation/
      interpolation.sci            stub — paste Student A's implementation here
    differentiation/
      differentiation.sci          stub — paste Student B's implementation here
    integration/
      integration.sci              stub — paste Student C's implementation here
    user_interface/
      health_dashboard.sci         stub — paste Student D's implementation here
    test_suites/
      run_all_tests.sci            master test runner
      test_studentA.sci            unit tests for Student A
      test_studentB.sci            unit tests for Student B
      test_studentC.sci            unit tests for Student C
      test_studentD.sci            unit tests for Student D
      test_integration.sci         full pipeline integration test

  StudentA/
    interpolation.sci              <- Student A: work here (hints inside)
  StudentB/
    differentiation.sci            <- Student B: work here (hints inside)
  StudentC/
    integration.sci                <- Student C: work here (hints inside)
  StudentD/
    load_data.sci                  <- Student D: work here (hints inside)
    health_dashboard.sci           <- Student D: work here (hints inside)
    main.sce                       <- Student D: work here (hints inside)

----------------------------------------------------------------------
STEP 0 — INSTALL SCILAB (if you have not already)
----------------------------------------------------------------------

  Download from: https://www.scilab.org  (free, all platforms)
  Recommended version: Scilab 6.x or later.

  No special toolboxes are required.

----------------------------------------------------------------------
STEP 1 — RUN THE WARM-UP SCRIPT FIRST (all students)
----------------------------------------------------------------------

  Open Scilab.  In the console, navigate to the phm_project/ folder:

    cd '/full/path/to/ENS184_MiniProject/phm_project';

  Then run:

    exec('warmup_scilab.sce', -1);

  This script teaches you every Scilab idiom you will need in about
  20 minutes, using toy examples unrelated to pump data.  Ten sections
  should each print "OK".  If you see an error, check your working
  directory with disp(pwd()).

----------------------------------------------------------------------
STEP 2 — DEVELOP YOUR INDIVIDUAL MODULE
----------------------------------------------------------------------

  Open the skeleton file for YOUR student role:

    Student A  ->  StudentA/interpolation.sci
    Student B  ->  StudentB/differentiation.sci
    Student C  ->  StudentC/integration.sci
    Student D  ->  StudentD/load_data.sci
                   StudentD/health_dashboard.sci
                   StudentD/main.sce   (after Tasks D1 and D2 work)

  Each file contains:
    - Function signatures you MUST NOT change
    - Guiding hints as comments
    - A stub return value so tests do not crash while you work

  Read your task description in project_manual_v2.pdf alongside your
  skeleton file.

----------------------------------------------------------------------
STEP 3 — RUN YOUR UNIT TESTS
----------------------------------------------------------------------

  When you have an implementation you want to test:

  3a. COPY your completed file into the corresponding phm_project/
      subfolder (replace the stub):

        Student A  ->  copy StudentA/interpolation.sci
                       to   phm_project/interpolation/interpolation.sci

        Student B  ->  copy StudentB/differentiation.sci
                       to   phm_project/differentiation/differentiation.sci

        Student C  ->  copy StudentC/integration.sci
                       to   phm_project/integration/integration.sci

        Student D  ->  copy StudentD/load_data.sci
                       to   phm_project/data_loader/load_data.sci

                       copy StudentD/health_dashboard.sci
                       to   phm_project/user_interface/health_dashboard.sci

  3b. In Scilab, change to phm_project/ and run your module's tests:

        cd '/full/path/to/ENS184_MiniProject/phm_project';
        exec('test_suites/test_studentA.sci', -1);   // for Student A
        exec('test_suites/test_studentB.sci', -1);   // for Student B
        exec('test_suites/test_studentC.sci', -1);   // for Student C
        exec('test_suites/test_studentD.sci', -1);   // for Student D

  Each test prints PASS or FAIL.  Fix failures before moving to Step 4.

----------------------------------------------------------------------
STEP 4 — TEAM INTEGRATION TEST
----------------------------------------------------------------------

  Once all four students have placed their implementations in
  phm_project/ (Step 3a), run the full integration test:

    exec('test_suites/test_integration.sci', -1);

  Then run the full pipeline:

    exec('main.sce', -1);

  Student D should complete phm_project/main.sce so that all five
  STEP blocks call the correct functions.

  Compare your output figures against the targets in target_outputs/.

----------------------------------------------------------------------
STEP 5 — WHAT TO SUBMIT
----------------------------------------------------------------------

  Each student submits their OWN skeleton file (the one in StudentX/,
  not the copy in phm_project/):

    Student A  ->  StudentA/interpolation.sci
    Student B  ->  StudentB/differentiation.sci
    Student C  ->  StudentC/integration.sci
    Student D  ->  StudentD/load_data.sci
                   StudentD/health_dashboard.sci
                   StudentD/main.sce

  The team also submits:
    - phm_project/main.sce (completed by Student D)
    - pump_health_report_v2.png (generated by your run of main.sce)
    - A PDF report (see project_manual_v2.pdf for content requirements)

  See Section 7 (Submission Checklist) in the manual for the full list.

----------------------------------------------------------------------
IMPORTANT NOTES
----------------------------------------------------------------------

  * Do NOT modify function signatures (name or argument list).
  * Do NOT call forbidden built-ins: polyfit, reglin, inv, lsq, fsolve.
  * All code must be your own.  You must be able to explain every line.
  * If pump_health_data.csv is not found, check that your working
    directory is phm_project/ (one level below the CSV file).
  * Type  help function_name  in the Scilab console for documentation
    on any built-in (e.g.  help read_csv).

======================================================================
