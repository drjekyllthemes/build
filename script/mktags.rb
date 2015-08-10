# encoding: utf-8

##### run as:
# $ ruby  ./script/mktags.rb

require 'pp'
require 'yaml'


repo = File.expand_path( '~/github/drjekyllthemes/themes' )

text   = File.read( "#{repo}/themes.yml" )
themes = YAML.load( text )

pp themes

## build hash with tags and list of themes
tags = {}

themes.each do |theme|
  theme_tags = theme['tags']
  next if theme_tags.nil? || theme_tags.empty?
  theme_tags.each do |tag|
    ary = tags[ tag ] || []
    ary << theme['title'] ## add theme to theme list/array
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


File.open( "#{repo}/o/tags.yml", 'w' ) do |f|
  f.write YAML.dump( tags2 )
end
