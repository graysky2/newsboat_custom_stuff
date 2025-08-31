#!/bin/bash

target="https://gitlab.archlinux.org/groups/archlinux/packaging/packages/-/issues.atom"
mapfile -t items < <(curl -s "$target" | xmlstarlet sel -N atom="http://www.w3.org/2005/Atom" -t -m "//atom:entry" -v "atom:id" -o "|" -v "atom:title" -n)

cat <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0">
  <channel>
    <title>Arch Linux Packages</title>
    <link>https://gitlab.archlinux.org/groups/archlinux/packaging/packages</link>
    <description>Arch Linux package issues with package names</description>
EOF

{
for i in "${items[@]}"; do
  if [[ -n "$i" ]]; then
    id="${i%|*}"
    title="${i#*|}"

    if [[ "$id" =~ /packages/([^/]+)/ ]]; then
      package="${BASH_REMATCH[1]}"
      combined_title="[$package] $title"
    else
      combined_title="$title"
    fi

    echo "    <item>"
    echo "      <title>$combined_title</title>"
    echo "      <link>$id</link>"
    echo "    </item>"
  fi
done
echo '  </channel>'
echo '</rss>'
}
