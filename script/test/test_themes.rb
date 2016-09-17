# encoding: utf-8

require_relative '../lib/themes'


text =<<EOS
###############################
#  Jekyll Themes

- title:     Ed
  github:    elotroalex/ed
  branch:    gh-pages
  demo_url:  http://elotroalex.github.io/ed/
  author:    Alex Gil et al
  thumbnail: ed.png
  license:   MIT

- title:     Henry's Starter (Minimal)
  github:    henrythemes/jekyll-starter-theme
  branch:    gh-pages          # used for github download archive link; defaults to master (for now)
  demo_url:  http://henrythemes.github.io/jekyll-starter-theme/
  thumbnail: henry-starter.png
  author:    Gerald Bauer
  license:   Public Domain
  tags:      [white]
EOS

t = Themes.new( text )
pp t.data
pp t.data_by_title
