#!/bin/bash

# Clean and prepare directories
# rm -rf dist
mkdir -p dist/en/projects dist/ja/projects
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

# Function to generate index.html
generate_index() {
    target_dir=$1
    title=$2
    
    if [ ! -d "$target_dir" ]; then return; fi
    
    outfile="$target_dir/index.html"
    # echo "Generating index for $target_dir"
    
    cat <<EOF > "$outfile"
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>$title</title>
<style>
body { font-family: system-ui, -apple-system, sans-serif; max-width: 800px; margin: 0 auto; padding: 2rem; line-height: 1.5; }
ul { list-style-type: none; padding: 0; }
li { margin: 0.5rem 0; }
a { color: #0066cc; text-decoration: none; font-size: 1.1rem; }
a:hover { text-decoration: underline; }
h1 { border-bottom: 1px solid #eee; padding-bottom: 0.5rem; }
</style>
</head>
<body>
<h1>$title</h1>
<ul>
EOF

    for f in "$target_dir"/*.html; do
        if [ -f "$f" ]; then
            filename=$(basename "$f")
            if [ "$filename" != "index.html" ]; then
                name=$(echo "${filename%.html}" | sed 's/[-_]/ /g' | awk '{for(i=1;i<=NF;i++)sub(/./,toupper(substr($i,1,1)),$i)}1')
                echo "<li><a href=\"$filename\">$name</a></li>" >> "$outfile"
            fi
        fi
    done

    echo "</ul></body></html>" >> "$outfile"
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

# Build Job Descriptions / Cover Letters
if [ -d "data/en/cover-letters" ]; then
    mkdir -p dist/en/cover-letters
    process_files "data/en/cover-letters" "dist/en/cover-letters"
fi
if [ -d "data/ja/cover-letters" ]; then
    mkdir -p dist/ja/cover-letters
    process_files "data/ja/cover-letters" "dist/ja/cover-letters"
fi

# Build Japanese pages
process_files "src/ja" "dist/ja"
process_files "src/ja/projects" "dist/ja/projects"

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

# Generate Indexes
generate_index "dist/en/projects" "Projects"
generate_index "dist/ja/projects" "プロジェクト"
generate_index "dist/en/cover-letters" "Cover Letters"
generate_index "dist/ja/cover-letters" "カバーレター"

echo "Build complete."
