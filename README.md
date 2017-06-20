

Build scripts (fetch project info from github, import themes from wiki page, etc.)



## Update Dr Jekyll's Themes Directory

Use (run) these scripts/steps:

```
$ ruby  ./script/mkauthors.rb         # note: will add/update o/themes/authors.yml in drjekyllthemes.github.io
$ ruby  ./script/mktags.rb
$ ruby  ./script/mkthemes.rb
```    




## Update Notes / Tips & Tricks


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
