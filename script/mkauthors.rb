# encoding: utf-8

##### run as:
# $ ruby  ./script/mkauthors.rb

require 'pp'
require 'yaml'


themes_repo = File.expand_path( '../themes' )
site_repo   = File.expand_path( '../drjekyllthemes.github.io' )

text   = File.read( "#{themes_repo}/themes.yml" )
themes = YAML.load( text )

pp themes

## build hash with authors and list of themes
authors = {}

themes.each do |theme|
  author = theme['author']
  if author.nil?
    pp theme
    fail "author missing; sorry"
  end
  ## cleanup
  ## todo/fix: allow multi authors!! split using comma (,) etc.
  ## for now remove et al
  author = author.sub( 'et al', '' ).strip
  ary = authors[ author ] || []
  ary << theme['title']  ## add theme to theme list/array
  authors[ author ] = ary
end

pp authors

### convert to nice yaml datafile format

authors2 = []
authors.each do |k,v|
  authors2 << { 'name' => k, 'themes' => v}  # note: use string as key (for pretty printing yaml output)
end

puts YAML.dump( authors2 )


File.open( "#{site_repo}/_data/o/themes/authors.yml", 'w' ) do |f|
  f.write YAML.dump( authors2 )
end
