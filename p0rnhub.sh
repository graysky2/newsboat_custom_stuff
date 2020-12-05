#!/bin/bash

# watch for new videos from pornhub with newboats
#
# depends on: bash coreutils gawk lynx sed
#
# note that there is a difference between a model and user.
# if the URL contains "user" in it, define the "user" variable and conversely
# if it contains "model" in it, use the "model" variable.
#
# 1. save this script to ~/.newsboat/foo.sh and make it executable
# 2. add an entry to ~/.newsboat/urls referencing this script like so:
#    filter:~/.newsboat/foo.sh:foo "~foo new video feed" p0rn

# pornhub user in either model or user but not both
model=
user=

## should not need to edit below this line
target=/tmp/$model.html
fixed=${target/.html/}.fixed.html

if [[ -n $model ]]; then
  url=https://www.pornhub.com/model/$model/videos
else
  url=https://www.pornhub.com/users/$model/videos/public
fi

lynx -source $url > $target || exit 1

# cut at public videos to remove non-specific
if [[ -n $model ]]; then
  sed -ne "/'s Videos/,$ p" <$target >$fixed
else
  sed -ne "/'s Public Videos/,$ p" <$target >$fixed
fi

mapfile -t hashes < <(grep 'title=' $fixed | grep 'class=\"\"' | awk -F'viewkey=' '{ print $2 }' | awk -F'"' '{print $1}')
mapfile -t titles < <(grep 'title=' $fixed | grep 'class=\"\"' | awk -F'viewkey=' '{ print $2 }' | awk -F'"' '{print $3}'|sed 's/ /_/g' | sed 's/[^a-zA-Z0-9_]//g')

cat <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0">

  <channel>
    <title>$model videos</title>
    <link>$url</link>
    <description>${#hashes[@]} totally</description>

EOF
{
  ending=$(( ${#hashes[@]} - 1 ))
  for i in $(seq 0 $ending); do
    echo "    <item>"
    echo "      <title>$i. ${titles[i]}</title>"
    echo "      <link>https://www.pornhub.com/view_video.php?viewkey=${hashes[i]}</link>"
    echo "    </item>"
  done
  echo '  </channel>'
  echo '</rss>'
}

rm -f $target $fixed

# vim:set ts=2 sw=2 et:
