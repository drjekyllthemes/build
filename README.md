

Build scripts (fetch project info from github, import themes from wiki page, etc.)



## Update Dr Jekyll's Themes Directory



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




**Update datafiles**

Who generates what?

| Script      | Output                                    |
| ----------- | ----------------------------------------- |
| `mkthemes`  | =>  `o/themes.yml`, `o/theme_by_name.yml` |
| `mkauthors` | => `o/authors.yml` and all `_authors/[name].md` pages |
| `mktags`    | => `o/tags.yml` |
| `mkgems`    | => `o/gems.yml` |


To (re)build the theme datafiles use:

```
$ ruby script/mkthemes.rb
```

Note: The `mkauthors` and `mkgems` script depend on `mkthemes`,
that is, run `mkthemes` before `mkauthors` and `mkgems`
(both will read in the generated `o/themes.yml` datafile).



Use (run) these scripts/steps:

```
$ ruby  script/mkauthors.rb
$ ruby  script/mkgems.rb
$ ruby  script/mktags.rb
```    
