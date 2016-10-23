

Build scripts (fetch project info from github, import themes from wiki page, etc.)



## Update Dr Jekyll's Themes Directory

Use (run) these scripts/steps:

```
$ ruby  ./script/mkauthors.rb         # note: will add/update o/themes/authors.yml in drjekyllthemes.github.io
$ ruby  ./script/mktags.rb
$ ruby  ./script/mkthemes.rb
```    




## Update Notes / Tips & Tricks

Use `git clone --recursive` to include submodule(s) e.g.:

```
$ git clone --recursive git@github.com:drjekyllthemes/drjekyllthemes.github.io.git
```

Resulting in:

```
Cloning into 'drjekyllthemes.github.io'...
...
Submodule 'themes' (https://github.com/drjekyllthemes/themes) registered for path '_data/themes'
Cloning into '_data/themes'...
...
```

**Update `_data/themes` submodule**

To pull in the latest changes from the `/themes` repo, use:

```
$ cd _data/themes
$ git status
$ git fetch
$ git merge origin/master
```

For more docu see the Git Book V2 chapter titled
["Git Tools - Submodules"](https://git-scm.com/book/en/v2/Git-Tools-Submodules)


**Update stats (GitHub stars, etc.)**

Set your GitHub env credentials e.g.

```
set HUBBA_USER=you
set HUBBA_PASSWORD=topsecret
```

Update stats (in /data) via GitHub API calls:

```
$ ruby script/upthemes.rb
```

Update datafiles:

```
$ ruby script/mkthemes.rb
```
