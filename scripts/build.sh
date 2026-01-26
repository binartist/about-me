#!/bin/bash

# Clean and prepare directories
rm -rf dist
mkdir -p dist/en/projects dist/en/cover-letters dist/ja/projects dist/ja/cover-letters
cp -r includes dist/

# Load environment variables if .env exists
if [ -f .env ]; then
    set -a
    source .env
    set +a
fi

# Function to update timestamps in a specific file
# usage: update_file_timestamp source_file dest_html
update_file_timestamp() {
    src_file=$1
    dest_html=$2
    
    # Try git first (Author Date in ISO 8601)
    # 2>/dev/null hides error if not in git repo
    file_ts=$(git log -1 --format="%aI" "$src_file" 2>/dev/null)
    
    # If empty (untracked or git error), use file modification time
    if [ -z "$file_ts" ]; then
        # Use date -r to get file modification time in UTC ISO format
        # Works on both macOS (BSD) and Linux (GNU)
        file_ts=$(date -u -r "$src_file" "+%Y-%m-%dT%H:%M:%SZ")
    fi
    
    # Replace in the specific html file
    perl -i -pe "s/\{\{UPDATED_AT\}\}/$file_ts/g" "$dest_html"
    perl -i -pe "s/\{\{ISO_TIMESTAMP\}\}/$file_ts/g" "$dest_html"
}

# Function to process files
# usage: process_files source_dir dest_dir
process_files() {
    src_dir=$1
    dest_dir=$2
    
    for f in "$src_dir"/*.md; do
        if [ -f "$f" ]; then
            base=${f##*/}
            outfile="$dest_dir/${base%.md}.html"
            
            # Convert to html
            pandoc "$f" -f gfm -t html -s --include-after-body=includes/common-scripts.html -o "$outfile"
            
            # Update timestamps locally
            update_file_timestamp "$f" "$outfile"
        fi
    done
}

# Build English pages
process_files "src/en" "dist/en"
process_files "src/en/projects" "dist/en/projects"
process_files "src/en/cover-letters" "dist/en/cover-letters"

# Build Japanese pages
process_files "src/ja" "dist/ja"
process_files "src/ja/projects" "dist/ja/projects"
process_files "src/ja/cover-letters" "dist/ja/cover-letters"

# Replace Personal Info from env
if [ -n "$MY_NAME" ]; then
    find dist -name "*.html" -type f -exec perl -i -pe 's/\{\{MY_NAME\}\}/$ENV{MY_NAME}/g' {} +
fi
if [ -n "$MY_PHONE" ]; then
    find dist -name "*.html" -type f -exec perl -i -pe 's/\{\{MY_PHONE\}\}/$ENV{MY_PHONE}/g' {} +
fi
if [ -n "$MY_EMAIL" ]; then
    find dist -name "*.html" -type f -exec perl -i -pe 's/\{\{MY_EMAIL\}\}/$ENV{MY_EMAIL}/g' {} +
fi

# Create root redirect
echo '<meta http-equiv="refresh" content="0; url=en/index.html" />' > dist/index.html

echo "Build complete."
