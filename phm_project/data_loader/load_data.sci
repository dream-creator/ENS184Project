// ============================================================
// load_data.sci  —  Data Loader Module  [INTEGRATION COPY]
// Pump Health Monitoring  |  ENS 184 Mini-Project
//
// HOW TO USE THIS FILE:
//   1. Develop and test your code in  StudentD/load_data.sci
//   2. When ready to run the test suite, COPY your finished
//      implementation into THIS file (replace the stub below).
//   3. Run:  exec('test_suites/test_studentD.sci', -1)
//      from the phm_project/ directory.
// ============================================================

// ------------------------------------------------------------
// Function: load_data
// Input:  fname     - path to the CSV file (string)
// Output: pressure  - differential pressure (bar)      (n x 1)
//         voltage   - sensor voltage (mV)              (n x 1)
//         hours     - operational hours (h)            (n x 1)
//         vibration - vibration amplitude (mm/s_rms)   (n x 1)
// ------------------------------------------------------------
function [pressure, voltage, hours, vibration] = load_data(fname)

    // TODO — see StudentD/load_data.sci for task details
    pressure  = [];
    voltage   = [];
    hours     = [];
    vibration = [];

endfunction
