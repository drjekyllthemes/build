# encoding: utf-8

##### run as:
# $ ruby  ./script/mkthemes.rb

require 'pp'
require 'yaml'


repo = File.expand_path( '~/github/drjekyllthemes/themes' )

text   = File.read( "#{repo}/themes.yml" )
themes = YAML.load( text )

pp themes

## build hash with themes by title 
hash = {}

themes.each do |theme|
  title = theme.delete( 'title' )  ## remove title from hash and use as new key
  
  ## unify
  ##  check for github shortcut
  github = theme.delete( 'github' )
  if github
    theme[ 'home_url' ] = "https://github.com/#{github}"
    branch = theme.delete( 'branch' )
    branch = 'master'  if branch.nil?   ## if no branch listed assume master
    theme[ 'download_url' ] = "https://github.com/#{github}/archive/#{branch}.zip"
  end
  hash[ title ] = theme
end

puts YAML.dump( hash )

File.open( "#{repo}/o/themes.yml", 'w' ) do |f|
  f.write YAML.dump( hash )
end
