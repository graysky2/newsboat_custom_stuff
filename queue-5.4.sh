#!/bin/bash

target="https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-5.4/"
mapfile -t items < <(lynx -dump -listonly "$target" | grep plain | sed 's|.*queue-5.4/||')

cat <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0">

	<channel>
		<title>Stable Queue for 5.4 Series</title>
		<link>$target</link>
		<description>stable-queue for 5.4.x</description>

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
