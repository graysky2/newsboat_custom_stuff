# newsboat custom stuff
Hacky shell scripts to generate RSS feeds on the fly for use is-as or [Newsboat](https://github.com/newsboat/newsboat).

* All scripts require: bash lynx
* The p0rnhub script additionally requires: coreutils gawk sed

Once copied to `~/.newsboat/` make the script(s) executable. Newsboat can use them via the `filter:` prefix in `~/.newsboat/urls` like so:
```
filter:~/.newsboat/stable-review.sh:stable
```

File | Description | 
 --- | --- |
`p0rnhub.sh` | Track a model's public videos |
`queue-5.4.sh` | Track patches in the stable-queue for 5.4 |
`stable-review.sh` | Track stable-review kernel tarballs |

Inspiration taken from a discussion with Minoru/[newsboat#1157](https://github.com/newsboat/newsboat/issues/1157).
