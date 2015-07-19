# Jekyll Theme Listing Sources


## Jekyll 

- [Themes @ Wiki ](https://github.com/jekyll/jekyll/wiki/Themes)

Format:

Single Markdown wiki page (a list item with links for each theme) e.g.

~~~
* Pixyll - ([source](https://github.com/johnotander/pixyll), [demo](http://pixyll.com/))
~~~

## Jekyll Tips by CloudCannon Ltd.

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


## JekyllThemes.org by Matt Harzewski (et al)

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


## Others ???
