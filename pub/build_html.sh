#!/usr/bin/env bash
# Generate publication HTML from Markdown (pandoc + chapter spoilers).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"

OPEN_INTRO_TITLES='General Information|Support Me|Motivation'

build_one() {
  local INPUT_MD_FILE="$1"
  local HTML_DIR
  HTML_DIR="$(dirname "${INPUT_MD_FILE}")"
  local OUTPUT_HTML_FILE="${HTML_DIR}/index.html"

  if [[ "$HTML_DIR" == *"/test" ]]; then
    echo "Skipping test publication: $INPUT_MD_FILE"
    return 0
  fi

  python3 - "$INPUT_MD_FILE" "$OUTPUT_HTML_FILE" "$OPEN_INTRO_TITLES" <<'PY'
import re, subprocess, sys
from pathlib import Path
from html import escape

md_path = Path(sys.argv[1])
out_path = Path(sys.argv[2])
open_titles = set(sys.argv[3].split("|"))

title_line = next((ln[2:].strip() for ln in md_path.read_text(encoding="utf-8").splitlines() if ln.startswith("# ")), md_path.parent.name)
title_esc = escape(title_line)

fragment = subprocess.check_output(
    [
        "pandoc",
        str(md_path),
        "-f", "markdown",
        "-t", "html5",
        "--highlight-style=breezedark",
    ],
    text=True,
)

# Lazy-load YouTube iframes
fragment = re.sub(r"<iframe(\s)", r'<iframe loading="lazy"\1', fragment, flags=re.I)

parts = re.split(r"(?=<h2\b)", fragment, flags=re.I)
chunks = []
for i, part in enumerate(parts):
    if i == 0 or not part.lower().startswith("<h2"):
        chunks.append(part)
        continue
    m = re.match(r"<h2[^>]*>(.*?)</h2>", part, flags=re.I | re.S)
    if not m:
        chunks.append(part)
        continue
    heading = re.sub(r"<[^>]+>", "", m.group(1))
    heading = re.sub(r"\s+", " ", heading).strip()
    body = part[m.end():]
    if heading in open_titles:
        chunks.append(part)
        continue
    chunks.append(
        f'<details class="chapter">\n'
        f"<summary>{escape(heading)}</summary>\n"
        f"{body}"
        f"</details>\n"
    )

content = "".join(chunks)

html = f"""<!DOCTYPE html>
<!--
 *  (c) Copyright erarnitox.de - All rights reserved
 *  Author: Erarnitox <david@erarnitox.de>
 *
-->
<html lang="en-US">
    <head>
        <title>Erarnitox — {title_esc}</title>
        <meta name="title" content="Erarnitox — {title_esc}" />
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="X-UA-Compatible" content="ie=edge" />
        <meta property="og:title" content="Erarnitox — {title_esc}" />
        <meta property="og:type" content="article" />
        <meta property="og:site_name" content="Erarnitox" />

        <link rel="stylesheet" href="../../style.css" />
        <link rel="stylesheet" href="../../res/pandoc-highlight.css" />

        <link rel="apple-touch-icon" sizes="180x180" href="../../apple-touch-icon.png" />
        <link rel="icon" type="image/png" sizes="32x32" href="../../favicon-32x32.png" />
        <link rel="icon" type="image/png" sizes="16x16" href="../../favicon-16x16.png" />
        <link rel="manifest" href="../../site.webmanifest" />
    </head>
    <body class="article">
        <header class="site-header">
            <nav class="site-nav">
                <a class="nav-brand" href="../../index.html">
                    <img class="logo-img" src="../../logo.png" alt="Erarnitox" />
                </a>
                <ul>
                    <li><a href="../../products/">Products</a></li>
                    <li><a href="../../pub/">Publications</a></li>
                    <li><a href="../../art/">Art</a></li>
                    <li><a href="../../index.html#contact">Contact</a></li>
                </ul>
            </nav>
        </header>
        <main>
            <div class="page-shell">
                <a class="article-back" href="../">← Publications</a>
                <article class="prose">
{content}
                </article>
            </div>
        </main>
        <footer class="site-footer">
            <ul>
                <li><a href="../../legal/">Impressum</a></li>
            </ul>
            <small>© 2026 Erarnitox</small>
        </footer>
    </body>
</html>
"""
out_path.write_text(html, encoding="utf-8")
print(f"Generated: {out_path}")
PY
}

while IFS= read -r -d '' file; do
  build_one "$file"
done < <(find . -type f -name 'index.md' -print0)

echo "Done."
