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
// Input:  fname - full path to the CSV file (string)
// Output: pressure, voltage, hours, vibration (all n x 1)
// ------------------------------------------------------------
function [pressure, voltage, hours, vibration] = load_data(fname)

    // Check that the file exists
    if ~isfile(fname) then
        error('load_data: file not found: ' + fname);
    end

    // Read entire CSV into a string matrix
    // read_csv returns every cell as a string, including numeric values
    raw = read_csv(fname, ',');

    // Skip header row (row 1 starts with '#')
    // raw(2:$, :) means: from row 2 to the last row, all columns
    data_str = raw(2:$, :);

    // Convert string matrix to numeric matrix
    // evstr() evaluates each string as a Scilab expression
    data = evstr(data_str);

    // Extract the four columns:
    // col 1 = pressure, col 2 = voltage, col 3 = hours, col 4 = vibration
    pressure  = data(:, 1);
    voltage   = data(:, 2);
    hours     = data(:, 3);
    vibration = data(:, 4);

endfunction
