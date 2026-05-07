// ============================================================
// load_data.sci  —  Student D Skeleton (Task D1)
// Load and Parse Sensor CSV Data
//
// NAME: ________________________________
// ID:   ________________________________
//
// Implement ONE function in this file.
// Do NOT change the function signature.
// ============================================================

funcprot(0);   // suppress redefinition warnings when re-running

// ------------------------------------------------------------
// Function: load_data
//
// Reads the CSV sensor data file and returns four column vectors.
//
// Input:
//   fname - full path to the CSV file (string)
//
// Output:
//   pressure  - differential pressure  [bar]      (n x 1)
//   voltage   - sensor voltage         [mV]       (n x 1)
//   hours     - operational hours      [h]        (n x 1)
//   vibration - vibration amplitude    [mm/s_rms] (n x 1)
//
// File format:
//   - Row 1 starts with '#' (header/comment line — skip it)
//   - Columns: differential_pressure, sensor_voltage,
//               operational_hours, vibration_amplitude
//   - Values are text strings; use evstr() to convert to numbers.
//
// Hints:
//   - Scilab's read_csv(fname, ',') reads the entire file into a matrix
//     of strings — every cell is a string, even numeric values.
//   - The first row is a comment/header line — skip it using Scilab's
//     row-indexing notation before converting to numbers.
//   - Use evstr() to convert the full string matrix to a numeric matrix.
//   - Extract each output vector from its corresponding column.
// ------------------------------------------------------------
function [pressure, voltage, hours, vibration] = load_data(fname)

    // TODO: check that the file exists  (use isfile(fname))

    // TODO: read the CSV file with read_csv

    // TODO: skip the header row

    // TODO: convert to numeric matrix with evstr

    // TODO: extract the four columns

endfunction
