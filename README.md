# newsboat custom stuff
Hacky shell scripts to generate RSS feeds on the fly for use is-as or [Newsboat](https://github.com/newsboat/newsboat).

* All scripts require: bash and xmlstarlet and any additional dependencies in the table

Once copied to `~/.config/newsboat/` make the script(s) executable. Newsboat can use them via the `filter:` prefix in `~/.config/newsboat/urls` like so:
```
filter:~/.config/newsboat/stable-review.sh:stable
```

File | Description | Additional depends |
 --- | --- | --- |
`arch_bug_feed.sh` | Arch Linux Gitlab feed for bug reports | curl |
`p0rnhub.sh` | Track a model's public videos | coreutils gawk lynx sed |
`queue-5.4.sh` | Track patches in the stable-queue for 5.4 | lynx |
`stable-review.sh` | Track stable-review kernel tarballs | lynx |

Inspiration taken from a discussion with Minoru/[newsboat#1157](https://github.com/newsboat/newsboat/issues/1157).
