#!/usr/bin/env bash
# Render project Markdown to HTML with shared site.css (matches catalog chrome).
set -euo pipefail
cd "$(dirname "$0")"

render() {
  local src="$1"
  local out="${src%.md}.html"
  local title
  title=$(sed -n 's/^# //p' "$src" | head -1)
  title=${title:-${src%.md}}

  # Body-only HTML from pandoc, then wrap with shared shell
  local body
  body=$(pandoc "$src" --from markdown+pipe_tables+fenced_code_blocks+raw_html -t html)

  # Drop the markdown back-link paragraph if present (we inject chrome)
  body=$(printf '%s\n' "$body" | python3 -c '
import sys, re
html = sys.stdin.read()
html = re.sub(r"<p>\s*<a[^>]*>.*?Back to.*?</a>\s*</p>\s*", "", html, count=1, flags=re.I|re.S)
print(html)
')

  cat > "$out" <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>${title} — Joe</title>
  <link rel="stylesheet" href="site.css" />
</head>
<body>
  <nav class="page-nav"><a href="index.html">← Products</a></nav>
  <article class="page-card">
${body}
  </article>
  <footer class="page-foot"><a href="index.html">All products</a></footer>
</body>
</html>
EOF
  echo "wrote $out"
}

for f in project-*.md; do
  case "$f" in *-ja.md) continue ;; esac
  [ -f "$f" ] || continue
  render "$f"
done

echo "Build complete (project pages). index.html is the product catalog (edit directly)."
