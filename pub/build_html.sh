#!/bin/bash
find "." -type f -name "*.md" | while read -r file; do
  INPUT_MD_FILE="${file}"
  HTML_DIR=$(dirname "${file}")
  HTML_NAME=$(basename "${file}" .md)
  OUTPUT_HTML_FILE="$HTML_DIR/$HTML_NAME.html"
  INDEX_HTML_FILE="./index.html"

  # Generate the HTML content from the Markdown file
  HTML_CONTENT=$(pandoc "$INPUT_MD_FILE" -f markdown -t html)

  # Wrap the HTML content with basic HTML structure
  cat <<EOF > "$OUTPUT_HTML_FILE"
<!DOCTYPE html>
<!--
 *  (c) Copyright erarnitox.de - All rights reserved
 *  Author: Erarnitox <david@erarnitox.de>
 *  
-->
<html lang="en-US">
    <head>
        <title>Erarnitox</title>
        <meta name="title" content="Erarnitox" />

        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="X-UA-Compatible" content="ie=edge" />
        <meta property="og:title" content="Erarnitox" />
        <meta property="og:description" content="" />
        <meta property="og:type" content="website" />
        <meta property="og:url" content="https://erarnitox.de/"/><meta property="og:site_name" content="Erarnitox" />

        <link rel="canonical" href="https://erarnitox.de/"/>
        <link rel="alternate" type="application/json" href="../index.json" title="Erarnitox" />

        <link rel="stylesheet" href="/style.css">

        <link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon.png" />
        <link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png" />
        <link rel="icon" type="image/png" sizes="16x16" href="/favicon-16x16.png" />
        <link rel="manifest" href="/site.webmanifest" />
    </head>
    <body>
        <header>
            <nav>
                <div class="flex-container-hz">
                    <a href="/index.html"><img class="logo-img" src="/logo.png" alt="erarnitox logo"></a>
                    <ul>
                        <li><a href="/products/">Products</a></li>
                        <li><a href="/pub/">Publications</a></li>
                        <li><a href="/art/">Art</a></li>
                    </ul>
                </div>
            </nav>
        </header>
        <main>
            $HTML_CONTENT
        </main>
        <footer id="home-footer">
            <ul>
                <li><a href="/legal/">Impressum</a></li>
            </ul>
            <small>© 2025 Erarnitox</small> 
        </footer>
    </body>
</html>
EOF

  echo "Generated HTML file: $OUTPUT_HTML_FILE"

  # Extract the filename without the path for the link
  HTML_DESC=$(date "+%Y-%m-%d %H:%M:%S")
  HTML_TITLE=$(grep -m 1 '^# ' "$INPUT_MD_FILE" | sed 's/^# //')

  # Add a link to the generated HTML in the index.html file
  if [ -f "$INDEX_HTML_FILE" ]; then
    # Check if the link already exists
    if grep -q "$HTML_DIR" "$INDEX_HTML_FILE"; then
      echo "Link to '$HTML_DIR' already exists in '$INDEX_HTML_FILE'."
    else
      # Add a link to the new file before the closing </body> tag
      sed -i "/<!--ends here-->/i <div class=\"pub-item\"><img class=\"pub-image\" src=\"/res/book.png\" alt=\"image\"><div><h2 class=\"pub-heading\">$HTML_TITLE</h2><p class=\"pub-description\">$HTML_DESC</p><a href=\"./$HTML_DIR\" class=\"pub-button\">Read</a></div></div>" "$INDEX_HTML_FILE"
      echo "Updated index file: $INDEX_HTML_FILE"
    fi
  else
    echo "Error: Index file '$INDEX_HTML_FILE' not found."
  fi
done

