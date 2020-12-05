#!/bin/bash

target="https://mirrors.edge.kernel.org/pub/linux/kernel/v5.x/stable-review/"
mapfile -t items < <(lynx -dump -listonly "$target" | sed "s|.*$target||" | grep xz)

cat <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0">

	<channel>
		<title>Kernel Stable Review RCs</title>
		<link>$target</link>
		<description>Stable review patches</description>

EOF
{
	for i in "${items[@]}"; do
		echo "    <item>"
		echo "      <title>$i</title>"
		echo "      <link>$target$i</link>"
		echo "    </item>"
	done
	echo '  </channel>'
	echo '</rss>' 
}

# vim:set ts=2 sw=2 et:
