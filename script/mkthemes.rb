# encoding: utf-8

##### run as:
# $ ruby  ./script/mkthemes.rb

require_relative 'lib/stats'
require_relative 'lib/themes'


require_relative 'settings'


themes = Themes.from_file( "#{THEMES_REPO}/themes.yml" )
themes.read_stats( data_dir: './data' )


puts YAML.dump( themes.data_by_title )
puts YAML.dump( themes.data )

File.open( "#{SITE_REPO}/_data/o/themes/themes_by_title.yml", 'w' ) do |f|
  f.write YAML.dump( themes.data_by_title )   ## it's a hash
end

File.open( "#{SITE_REPO}/_data/o/themes/themes.yml", 'w' ) do |f|
  f.write YAML.dump( themes.data )   ## it's an array
end
