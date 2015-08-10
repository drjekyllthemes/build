# encoding: utf-8

##### run as:
# $ ruby  ./script/importers/posts.rb

require 'pp'
require 'yaml'


root = File.expand_path( '~/github/jekyllthemes/jekyllthemes' )

files = Dir[ "#{root}/_posts/**" ]

pp files

## sort (e.g. by date)
files.sort!

pp files



FRONT_MATTER_REGEX = /
     ^(?:---\s*\n)
       (.*?\n?)        ## capture front matter
     ^(?:---\s*$\n?)
          /xm


themes = []

files.each do |file|
  text = File.read( file )



  puts " reading #{file}..."
  if text =~ FRONT_MATTER_REGEX
     puts $1.to_s
     data = YAML.load($1)
     
     data.delete( 'layout' )
     data.delete( 'date' )
     data.delete( 'license_link' )
     
     pp data
     
     themes << data
  else
     fail "no front matter found"
  end
end

## puts  YAML.dump( themes )

File.open( './o/themes.yml', 'w' ) do |f|
  f.write YAML.dump( themes )
end

