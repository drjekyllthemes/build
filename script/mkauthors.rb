# encoding: utf-8

##### run as:
# $ ruby  ./script/mkauthors.rb

require 'pp'
require 'yaml'


require_relative 'settings'    # e.g. THEMES_REPO, SITE_REPO


themes_repo = THEMES_REPO    ## File.expand_path( '../themes' )
site_repo   = SITE_REPO      ## File.expand_path( '../drjekyllthemes.github.io' )


## read known ("white-listed") authors from site repo
text    = File.open( "#{site_repo}/_data/author_by_name.yml", 'r:utf-8') { |f| f.read }
known_authors = YAML.load( text )

pp known_authors

###
## note: use generated themes array / records - include stats!!!

## text   = File.open( "#{themes_repo}/themes.yml", 'r:utf-8') { |f| f.read }
text   = File.open( "#{site_repo}/_data/o/themes.yml", 'r:utf-8') { |f| f.read }
themes = YAML.load( text )

pp themes

## build hash with authors and list of themes
all_authors = {}

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
  ary = all_authors[ author ] || []
  ary << theme  ## add theme to theme list/array
  all_authors[ author ] = ary
end

pp all_authors



### generate authors collection pages
all_authors.each do |k,v|

  author = known_authors[k]
  if author
    puts "   *** bingo!!! found #{k}"

    github = author['github']
    if github.nil?
      puts "sorry github handle missing!!!"
      exit 1
    end

    front_matter = {
      'name'   => k,
      'themes' => v.map { |h| h['name'] }    ## just include array of theme names
    }

    ## File.open( "./o/#{github}.md", 'w:utf-8' ) do |f|
    File.open( "#{site_repo}/_authors/#{github}.md", 'w:utf-8' ) do |f|
      f.write YAML.dump( front_matter )
      f.write "---\n"    ## add end front matter marker too (note: begin gets auto-added)
    end
  else
    puts "!!! warn: author record missing for >#{k}<"
  end
end






### convert to nice yaml datafile format

all_authors2 = []
all_authors.each do |k,v|

  theme_names = v.map { |h| h['name'] }    ## just include array of theme names

  author = {
    'name' => k,
    'themes'       =>  theme_names,
    'themes_count' =>  theme_names.size     ## add for easy sorting
  }  # note: use string as key (for pretty printing yaml output)

  ## add up all stars
  stars = v.reduce(0) { |sum,h| sum + (h['stars'] || 0) }

  if stars > 0
    author['stars'] = stars

    ## try add up all stars_week too
    stars_week = v.reduce(0) { |sum,h| sum + (h['stars_week'] || 0) }
    author['stars_week'] = stars_week
  end

  all_authors2 << author
end


## puts YAML.dump( all_authors2 )

## todo/fix: use utf8 encoding!!!
## File.open( "./o/authors.yml", 'w:utf-8' ) do |f|
File.open( "#{site_repo}/_data/o/authors.yml", 'w:utf-8' ) do |f|
  f.write YAML.dump( all_authors2 )
end
