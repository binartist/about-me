#!/bin/bash

# Clean and prepare directories
rm -rf dist
mkdir -p dist/en/projects dist/ja/projects
cp -r includes dist/

# Get current timestamp
TIMESTAMP=$(date -u "+%Y-%m-%dT%H:%M:%SZ")
echo "Build Timestamp: $TIMESTAMP"

# Function to process files
# usage: process_files source_dir dest_dir
process_files() {
    src_dir=$1
    dest_dir=$2
    
    for f in "$src_dir"/*.md; do
        if [ -f "$f" ]; then
            base=${f##*/}
            # Convert to html
            pandoc "$f" -t html -s --include-after-body=includes/common-scripts.html -o "$dest_dir/${base%.md}.html"
        fi
    done
}

# Build English pages
process_files "src/en" "dist/en"
process_files "src/en/projects" "dist/en/projects"

# Build Japanese pages
process_files "src/ja" "dist/ja"
process_files "src/ja/projects" "dist/ja/projects"

# Replace timestamp placeholder in all generated HTML files
# Using perl for cross-platform compatibility (macOS vs Linux sed differences)
find dist -name "*.html" -type f -exec perl -i -pe "s/\{\{UPDATED_AT\}\}/$TIMESTAMP/g" {} +
find dist -name "*.html" -type f -exec perl -i -pe "s/\{\{ISO_TIMESTAMP\}\}/$TIMESTAMP/g" {} +

# Create root redirect
echo '<meta http-equiv="refresh" content="0; url=en/index.html" />' > dist/index.html

echo "Build complete."
