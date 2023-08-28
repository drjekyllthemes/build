##### run as:
# $ ruby  script/mkthemes.rb

require_relative 'lib/themes'


require_relative 'settings'


themes = Themes.read( "#{THEMES_REPO}/themes_i.yml" )
themes.read_stats

puts YAML.dump( themes.data_by_name )
puts YAML.dump( themes.data )

# File.open( "#{SITE_REPO}/_data/o/theme_by_name.yml", 'w:utf-8' ) do |f|
File.open( "./tmp/theme_by_name.yml", 'w:utf-8' ) do |f|
    f.write YAML.dump( themes.data_by_name )   ## it's a hash
end

# File.open( "#{SITE_REPO}/_data/o/themes.yml", 'w:utf-8' ) do |f|
File.open( "./tmp/themes.yml", 'w:utf-8' ) do |f|
f.write YAML.dump( themes.data )   ## it's an array
end
