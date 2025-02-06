#!/bin/bash

# Define an array of folder names to exclude
EXCLUDE_FOLDERS=("ModularPlugin")

# Find all directories containing 'Project.swift' files
find . -type f -name "Project.swift" -exec dirname {} \; | while read dir; do
    # Extract the folder name from the directory path
    folder_name=$(basename "$dir")

    # Check if the folder or any of its parent folders is in the exclude list
    exclude=false
    for exclude_folder in "${EXCLUDE_FOLDERS[@]}"; do
        if [[ "$dir" == *"$exclude_folder"* ]]; then
            exclude=true
            break
        fi
    done

    # Skip if the folder or any parent folder is in the exclude list
    if $exclude; then
        echo "Skipping folder: $dir (excluded)"
        continue  # Skip to the next directory
    fi

    # Print the folder name
    echo "Folder name: $folder_name"

    # Check if a README.md file already exists in the directory
    if [ ! -f "$dir/README.md" ]; then
        # Create a simple README.md file in each directory with a basic template
        echo "# Project Documentation" > "$dir/README.md"
        echo "## Dependency Graph" >> "$dir/README.md"
        echo "![Module Graph](./graph.png)" >> "$dir/README.md"
    else
        echo "README.md already exists in $dir"
    fi

    # Check if Application folder, if so, generate graph for Surcharges
    if [[ "$folder_name" == "Applications" ]]; then 
        tuist graph Surcharges SurchargesDev -d --no-open -o "$dir"
    else 
        # Check if there is an 'App' folder in the same directory
        if [ -d "$dir/App" ]; then
            tuist graph "$folder_name"Demo -d --no-open -o "$dir"
        else
            tuist graph $folder_name --no-open -o "$dir"
        fi
    fi

done

tuist graph Surcharges UseCasesTests ViewModelsTests -d --no-open -o "$dir"