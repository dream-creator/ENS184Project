import os
import re
import sys

def check_file(filepath):
    with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
        content = f.read()
    
    # Strip comments
    # Scilab comments start with //
    lines = content.split('\n')
    clean_lines = []
    for line in lines:
        if '//' in line:
            line = line.split('//', 1)[0]
        clean_lines.append(line)
    clean_content = '\n'.join(clean_lines)

    # Check for inv()
    if re.search(r'\binv\s*\(', clean_content):
        print(f"Error in {filepath}: Forbidden function 'inv()' is used.")
        return False

    # Check for csvRead()
    if re.search(r'\bcsvRead\b', clean_content):
        print(f"Error in {filepath}: Forbidden function 'csvRead()' is used.")
        return False
        
    return True

def main():
    root_dir = "."
    files_to_check = []
    for dirpath, _, filenames in os.walk(root_dir):
        # Skip git and github folders
        if '.git' in dirpath or '.github' in dirpath:
            continue
        for filename in filenames:
            if filename.endswith('.sci') or filename.endswith('.sce'):
                files_to_check.append(os.path.join(dirpath, filename))

    success = True
    for filepath in files_to_check:
        if not check_file(filepath):
            success = False

    # Also verify that read_csv is used in load_data.sci
    load_data_paths = [
        "StudentD/load_data.sci",
        "phm_project/data_loader/load_data.sci"
    ]
    for path in load_data_paths:
        if os.path.exists(path):
            with open(path, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()
            # Strip comments
            lines = content.split('\n')
            clean_lines = []
            for line in lines:
                if '//' in line:
                    line = line.split('//', 1)[0]
                clean_lines.append(line)
            clean_content = '\n'.join(clean_lines)
            if 'read_csv' not in clean_content:
                print(f"Error: 'read_csv' is not used in {path}.")
                success = False
        else:
            print(f"Error: Required file {path} not found.")
            success = False

    if not success:
        sys.exit(1)
    print("Methodology compliance checks passed successfully!")
    sys.exit(0)

if __name__ == "__main__":
    main()
