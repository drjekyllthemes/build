# encoding: utf-8

##### run as:
# $ ruby  ./script/mktags.rb

require 'pp'
require 'yaml'


require_relative 'settings'    # e.g. THEMES_REPO, SITE_REPO


themes_repo = THEMES_REPO    ## File.expand_path( '../themes' )
site_repo   = SITE_REPO      ## File.expand_path( '../drjekyllthemes.github.io' )


text   = File.read( "#{themes_repo}/themes.yml" )
themes = YAML.load( text )

pp themes

## build hash with tags and list of themes
tags = {}

themes.each do |theme|
  theme_tags = theme['tags']
  next if theme_tags.nil? || theme_tags.empty?
  theme_tags.each do |tag|
    ary = tags[ tag ] || []
    ary << theme['name'] ## add theme to theme list/array
    tags[ tag ] = ary
  end
end

pp tags

### convert to nice yaml datafile format

tags2 = []
tags.each do |k,v|
  tags2 << { 'name' => k, 'themes' => v}  # note: use string as key (for pretty printing yaml output)
end

puts YAML.dump( tags2 )


File.open( "#{site_repo}/_data/o/tags.yml", 'w' ) do |f|
  f.write YAML.dump( tags2 )
end
