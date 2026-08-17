#!/bin/bash
set -euo pipefail

# Clean and prepare directories
mkdir -p dist/en/products dist/ja/products
# Legacy URL stubs: /en/projects/* → /en/products/*
mkdir -p dist/en/projects dist/ja/projects
cp -r includes dist/

# Load environment variables if .env exists
if [ -f .env ]; then
    set -a
    # shellcheck disable=SC1091
    source .env
    set +a
fi

update_file_timestamp() {
    src_file=$1
    dest_html=$2
    file_ts=$(git log -1 --format="%aI" "$src_file" 2>/dev/null || true)
    if [ -z "$file_ts" ]; then
        file_ts=$(date -u -r "$src_file" "+%Y-%m-%dT%H:%M:%SZ" 2>/dev/null || date -u "+%Y-%m-%dT%H:%M:%SZ")
    fi
    perl -i -pe "s/\{\{UPDATED_AT\}\}/$file_ts/g" "$dest_html"
    perl -i -pe "s/\{\{ISO_TIMESTAMP\}\}/$file_ts/g" "$dest_html"
}

generate_index() {
    target_dir=$1
    title=$2
    if [ ! -d "$target_dir" ]; then return; fi
    outfile="$target_dir/index.html"
    cat <<EOF > "$outfile"
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>$title</title>
<link rel="stylesheet" href="../site.css?v=${CSS_VER:-0}">
</head>
<body>
<nav class="page-nav"><a href="../index.html">← Products</a></nav>
<article class="page-card">
<h1>$title</h1>
<ul>
EOF
    for f in "$target_dir"/*.html; do
        if [ -f "$f" ]; then
            filename=$(basename "$f")
            if [ "$filename" != "index.html" ]; then
                name=$(echo "${filename%.html}" | sed 's/[-_]/ /g')
                echo "<li><a href=\"$filename\">$name</a></li>" >> "$outfile"
            fi
        fi
    done
    echo "</ul></article></body></html>" >> "$outfile"
}

# Product detail pages from Markdown → polished HTML shell
render_product() {
    local src="$1"
    local dest_dir="$2"
    local base=${src##*/}
    local out="$dest_dir/${base%.md}.html"
    local title
    title=$(sed -n 's/^# //p' "$src" | head -1)
    title=${title:-${base%.md}}

    local body
    body=$(pandoc "$src" --from markdown+pipe_tables+fenced_code_blocks+raw_html -t html)
    body=$(printf '%s\n' "$body" | python3 -c '
import sys, re
html = sys.stdin.read()
html = re.sub(r"<p>\s*<a[^>]*>.*?Back to.*?</a>\s*</p>\s*", "", html, count=1, flags=re.I|re.S)
html = re.sub(r"<p>\s*<a[^>]*>.*?Products.*?</a>\s*</p>\s*", "", html, count=1, flags=re.I|re.S)
print(html)
')

    # Mermaid + shared widgets live in includes/common-scripts.html
    local after_body=""
    if [ -f includes/common-scripts.html ]; then
        after_body=$(cat includes/common-scripts.html)
    fi

    cat > "$out" <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>${title} — Joe</title>
  <link rel="stylesheet" href="../site.css?v=${CSS_VER}" />
</head>
<body>
  <nav class="page-nav"><a href="../index.html">← Products</a></nav>
  <article class="page-card">
${body}
  </article>
  <footer class="page-foot"><a href="../index.html">All products</a></footer>
${after_body}
</body>
</html>
EOF
    update_file_timestamp "$src" "$out"
    echo "wrote $out"
}

# Thin redirect for old /…/projects/… URLs after rename to products/
write_legacy_project_redirect() {
    local lang="$1"   # en | ja
    local base="$2"   # e.g. tutored.html
    local out="dist/${lang}/projects/${base}"
    cat > "$out" <<EOF
<!DOCTYPE html>
<html lang="${lang}">
<head>
  <meta charset="utf-8" />
  <meta http-equiv="refresh" content="0; url=../products/${base}" />
  <link rel="canonical" href="../products/${base}" />
  <title>Redirecting…</title>
</head>
<body>
  <p>Moved to <a href="../products/${base}">products/${base}</a>.</p>
</body>
</html>
EOF
}

# Shared CSS for en tree
cp includes/site.css dist/en/site.css 2>/dev/null || cp site.css dist/en/site.css
cp dist/en/site.css dist/ja/site.css 2>/dev/null || true

# Cache-buster for the stylesheet. Without it browsers (especially over file://)
# keep serving a stale site.css after a rebuild, so layout changes appear not to land.
if command -v md5 >/dev/null 2>&1; then
    CSS_VER=$(md5 -q dist/en/site.css | cut -c1-8)
else
    CSS_VER=$(md5sum dist/en/site.css | cut -c1-8)
fi
export CSS_VER
echo "css version: $CSS_VER"

# English product catalog (static) + avatar
if [ -f src/en/index.html ]; then
    cp src/en/index.html dist/en/index.html
    echo "wrote dist/en/index.html (catalog)"
elif [ -f src/en/index.md ]; then
    pandoc src/en/index.md -f gfm -t html -s --include-after-body=includes/common-scripts.html -o dist/en/index.html
    update_file_timestamp src/en/index.md dist/en/index.html
fi
if [ -f src/en/avatar.jpg ]; then
    cp src/en/avatar.jpg dist/en/avatar.jpg
    echo "wrote dist/en/avatar.jpg"
elif [ -f assets/avatar.jpg ]; then
    cp assets/avatar.jpg dist/en/avatar.jpg
    echo "wrote dist/en/avatar.jpg (from assets/)"
fi

# Product page images (screenshots referenced from product markdown + catalog cards)
if [ -d src/en/products/images ]; then
    mkdir -p dist/en/products/images
    # --delete so images removed from src do not linger in dist
    rsync -a --delete src/en/products/images/ dist/en/products/images/
    echo "wrote dist/en/products/images/"
fi

# English product pages
for f in src/en/products/*.md; do
    [ -f "$f" ] || continue
    render_product "$f" dist/en/products
    base=${f##*/}
    write_legacy_project_redirect en "${base%.md}.html"
done

# Japanese (markdown path; optional)
if [ -f src/ja/index.md ]; then
    pandoc src/ja/index.md -f gfm -t html -s --include-after-body=includes/common-scripts.html -o dist/ja/index.html
    update_file_timestamp src/ja/index.md dist/ja/index.html
fi
for f in src/ja/products/*.md; do
    [ -f "$f" ] || continue
    base=${f##*/}
    outfile="dist/ja/products/${base%.md}.html"
    pandoc "$f" -f gfm -t html -s --include-after-body=includes/common-scripts.html -o "$outfile"
    update_file_timestamp "$f" "$outfile"
    write_legacy_project_redirect ja "${base%.md}.html"
done

# Personal placeholders
if [ -n "${MY_NAME:-}" ]; then
    find dist -name "*.html" -type f -exec perl -i -pe 's/\{\{MY_NAME\}\}/$ENV{MY_NAME}/g' {} +
fi
if [ -n "${MY_PHONE:-}" ]; then
    find dist -name "*.html" -type f -exec perl -i -pe 's/\{\{MY_PHONE\}\}/$ENV{MY_PHONE}/g' {} +
fi
if [ -n "${MY_EMAIL:-}" ]; then
    find dist -name "*.html" -type f -exec perl -i -pe 's/\{\{MY_EMAIL\}\}/$ENV{MY_EMAIL}/g' {} +
fi

# Root redirect to English catalog
echo '<meta http-equiv="refresh" content="0; url=en/index.html" />' > dist/index.html

# Secondary indexes (canonical products path)
generate_index "dist/en/products" "Products"
generate_index "dist/ja/products" "プロダクト"
# Legacy projects/ index → products/
cat > dist/en/projects/index.html <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta http-equiv="refresh" content="0; url=../products/" />
  <link rel="canonical" href="../products/" />
  <title>Redirecting…</title>
</head>
<body>
  <p>Moved to <a href="../products/">products/</a>.</p>
</body>
</html>
EOF
cat > dist/ja/projects/index.html <<'EOF'
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="utf-8" />
  <meta http-equiv="refresh" content="0; url=../products/" />
  <link rel="canonical" href="../products/" />
  <title>Redirecting…</title>
</head>
<body>
  <p><a href="../products/">products/</a> に移動しました。</p>
</body>
</html>
EOF

echo "Build complete."
