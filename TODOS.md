# Todos


## check for moved 301

renames - update author names/handles too

- PanosSakkos => le4ker
- ajthewebdev => thesowah
- tomjohnson1492 => tomjoht

```
add record 2018-02-16 to history...
{"stargazers_count"=>nil}
GET /repos/PanosSakkos/personal-jekyll-theme/commits
  using basic auth - user: testdada, password: ***
"server => GitHub.com"
"date => Fri, 16 Feb 2018 20:20:52 GMT"
"content-type => application/json; charset=utf-8"
"content-length => 162"
"connection => close"
"status => 301 Moved Permanently"
"x-ratelimit-limit => 5000"
"x-ratelimit-remaining => 4918"
"x-ratelimit-reset => 1518815659"
"location => https://api.github.com/repositories/38167793/commits"
"x-github-media-type => github.v3; format=json"
"access-control-expose-headers => ETag, Link, Retry-After, X-GitHub-OTP, X-RateLimit-Limit, X-RateLimit-Remaining, X-Rat
eLimit-Reset, X-OAuth-Scopes, X-Accepted-OAuth-Scopes, X-Poll-Interval"
"access-control-allow-origin => *"
"content-security-policy => default-src 'none'"
"strict-transport-security => max-age=31536000; includeSubdomains; preload"
"x-content-type-options => nosniff"
"x-frame-options => deny"
"x-xss-protection => 1; mode=block"
"x-runtime-rack => 0.049795"
"x-github-request-id => C25D:888A:1373C01:247467A:5A873D24"
last commit/update:
C:/prg/ri330/Ruby2.3.0/lib/ruby/gems/2.3.0/gems/hubba-0.4.0/lib/hubba/stats.rb:204:in `fetch': undefined method `[]' for
 nil:NilClass (NoMethodError)
        from C:/Sites/yorobot/planetjekyll/script/lib/themes.rb:131:in `block in update_stats'
        from C:/Sites/yorobot/planetjekyll/script/lib/themes.rb:126:in `each'
        from C:/Sites/yorobot/planetjekyll/script/lib/themes.rb:126:in `update_stats'
        from script/upthemes.rb:14:in `<main>'
```


## Todos

- [ ]  check if title is unique - warn if not unique ??


## add multi author support

Shu Higashi, Sam Smith, et al

- handle / add multi authors
- make et al an author in array ???

## add top 10, top 100, new / hot labels

auto-add tags or labels if in top 10 or top 100
or if new (e.g. created less than say three month ago) etc.

## add gems to author page and author datafile

add a list of all gems to the author datafile and page too.


## Themes

- check last update more than two years (600 days)
- and stars less than 20
- move to minor/more (themes_iii)
  - e.g.  https://github.com/prio101/metaphor-jekyll
  -  https://github.com/tybenz/otter-pop
