# encoding: utf-8

##### run as:
# $ ruby  ./script/mkgems.rb


require 'pp'
require 'yaml'


require_relative 'settings'    # e.g. THEMES_REPO, SITE_REPO


themes_repo = THEMES_REPO    ## File.expand_path( '../themes' )
site_repo   = SITE_REPO      ## File.expand_path( '../drjekyllthemes.github.io' )



###
## note: use generated themes array / records - include stats!!!

## text   = File.open( "#{themes_repo}/themes.yml", 'r:utf-8') { |f| f.read }
text   = File.open( "#{site_repo}/_data/o/themes.yml", 'r:utf-8') { |f| f.read }
themes = YAML.load( text )

pp themes



## build array with gems
gems = []

themes.each do |theme|

  gem_name = theme['gem']
  if gem_name
    puts "*** bingo! adding gem >#{gem_name}<"
    gem = {
      'name'  => gem_name,
      'theme' => theme
    }
    gems << gem
  end
end

pp gems



## puts YAML.dump( gems )

## File.open( "./o/gems.yml", 'w:utf-8' ) do |f|
File.open( "#{site_repo}/_data/o/gems.yml", 'w:utf-8' ) do |f|
  f.write YAML.dump( gems )
end
