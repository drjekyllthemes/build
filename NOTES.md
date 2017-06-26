# Notes

## Todos

- [ ] change hompage to source_url ??
- [ ] change demo   to demo_url ??
- [ ] change  thumbnail to screenshot ??

<!--- new list -->

- [ ] auto-generate donwload link from github link??

### todo -  for upthemes.rb

- [ ] check for 301 Moved Permanently (will crash for commits request)

```
reading (loading) from talk2ankan~uno-dbyll...
fetching talk2ankan/uno-dbyll...
GET /repos/talk2ankan/uno-dbyll
  using basic auth - user: ***, password: ***
"server => GitHub.com"
"date => Sun, 23 Oct 2016 16:33:14 GMT"
"content-type => application/json; charset=utf-8"
"content-length => 154"
"connection => close"
"status => 301 Moved Permanently"
"x-ratelimit-limit => 5000"
"x-ratelimit-remaining => 4839"
"x-ratelimit-reset => 1477243904"
"location => https://api.github.com/repositories/30156159"
"x-github-media-type => github.v3; format=json"
"access-control-expose-headers => ETag, Link, X-GitHub-OTP, X-RateLimit-Limit, X-RateLimit-Remaining, X-RateLimit-Reset, X-OAuth-Scopes, X-Accepted-OAuth-Scopes, X-Poll-Interval"
"access-control-allow-origin => *"
"content-security-policy => default-src 'none'"
"strict-transport-security => max-age=31536000; includeSubdomains; preload"
"x-content-type-options => nosniff"
"x-frame-options => deny"
"x-xss-protection => 1; mode=block"
"vary => Accept-Encoding"
"x-served-by => a6882e5cd2513376cb9481dbcd83f3a2"
"x-github-request-id => 5B732977:10F8A:1633BAA4:580CE649"
stargazers_count

add record 2016-10-23 to history...
GET /repos/talk2ankan/uno-dbyll/commits
  using basic auth - user: ***, password: ***
"server => GitHub.com"
"date => Sun, 23 Oct 2016 16:33:14 GMT"
"content-type => application/json; charset=utf-8"
"content-length => 162"
"connection => close"
"status => 301 Moved Permanently"
"x-ratelimit-limit => 5000"
"x-ratelimit-remaining => 4838"
"x-ratelimit-reset => 1477243904"
"location => https://api.github.com/repositories/30156159/commits"
"x-github-media-type => github.v3; format=json"
"access-control-expose-headers => ETag, Link, X-GitHub-OTP, X-RateLimit-Limit, X-RateLimit-Remaining, X-RateLimit-Reset, X-OAuth-Scopes, X-Accepted-OAuth-Scopes, X-Poll-Interval"
"access-control-allow-origin => *"
"content-security-policy => default-src 'none'"
"strict-transport-security => max-age=31536000; includeSubdomains; preload"
"x-content-type-options => nosniff"
"x-frame-options => deny"
"x-xss-protection => 1; mode=block"
"vary => Accept-Encoding"
"x-served-by => 0e17b94a265a427d9cafe798ceea7c02"
"x-github-request-id => 5B732977:10F88:111FF6A0:580CE64A"
last commit/update:
script/lib/stats.rb:68:in `fetch': undefined method `[]' for nil:NilClass (NoMethodError)
        from script/lib/themes.rb:129:in `block in update_stats'
        from script/lib/themes.rb:124:in `each'
        from script/lib/themes.rb:124:in `update_stats'
        from script/upthemes.rb:12:in `<main>'
```


## More Jekyll Theme Listings / Directories

- http://jekyll-themes.com     by Sharath Kumar (aka webjeda)
- http://jekyllthemes.ru       by Artem Sheludko
- http://jekyllthemes.org      by Matt Harzewski
- http://jekyllthemes.io       by Tyler Cubell
- http://themes.jekyllrc.org   by Max White (aka mushishi78) and Günter Kits (aka gynter)


## Jekyll Theme Listing Sources

### Jekyll

- [Themes @ Wiki ](https://github.com/jekyll/jekyll/wiki/Themes)

Format:

Single Markdown wiki page (a list item with links for each theme) e.g.

~~~
* Pixyll - ([source](https://github.com/johnotander/pixyll), [demo](http://pixyll.com/))
~~~

### Jekyll Tips by CloudCannon Ltd.

- [Templates](http://jekyll.tips/templates)

Format:

One markdown file (for each theme) with yaml front matter e.g.

~~~
name: Agency
github_url: https://github.com/y7kim/agency-jekyll-theme
branch: gh-pages              ## note: branch optional - defaults to master
~~~

Source: [Jekyll-Tips/_templates](https://github.com/CloudCannon/Jekyll-Tips/tree/master/_templates)

Rendered via

~~~
{% for template in site.templates %}

{{ template.name }}
{{ template.github_url }}

-- calculate preview (img) path
<img src="/img/templates/{{ template.name | downcase | replace:' ','_' }}.jpg" alt="{{ template.name }}">
-- calculate download (zip/archive) path
{{ template.github_url }}/archive/{% if template.branch %}{{ template.branch }}{% else %}master{% endif %}.zip
{% endfor %}
~~~


### JekyllThemes.org by Matt Harzewski (et al)

- [Themes](http://jekyllthemes.org)

Format:

One markdown file (for each theme) with yaml front matter e.g.

~~~
layout: post
title: "Balzac"
date: 2013-08-19 13:52:00
homepage: https://github.com/coletownsend/balzac-for-jekyll
download: https://github.com/coletownsend/balzac-for-jekyll/archive/master.zip
demo: http://jekyll.gtat.me
author: Cole Townsend
thumbnail: Balzac-for-Jekyll-thumb.jpg
license: MIT License
license_link: https://github.com/ColeTownsend/Balzac-for-Jekyll/blob/master/LICENSE
~~~

Source: [jekyllthemes/_posts](https://github.com/mattvh/jekyllthemes/tree/master/_posts)


### Others ???



## More Theme Directories

**Dynamic Sites**

- WordPress.org <https://wordpress.org/themes> - sort by: features, popular, latest + feature filter
- WordPress.com <https://theme.wordpress.com> - sort by: trending, a-z, newest, popular, free, premium


**Static Sites**

- Hexo <https://hexo.io/themes> - Static Site Generator in JavaScript

- Middleman <https://directory.middlemanapp.com> - Static Site Generator in Ruby

  tags include: scss, sass, etc.

- Hugo <http://gohugo.io/showcase> - Static Site Generator in Go


**Others**

- Atom Editor <https://atom.io/themes>
