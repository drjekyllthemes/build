# encoding: utf-8

##### run as:
# $ ruby  ./script/mkplugins.rb

require_relative 'lib/stats'
require_relative 'lib/plugins'


require_relative 'settings'


plugins = Plugins.from_file( "./o/plugins.yml" )
plugins.read_stats( data_dir: './data' )

puts YAML.dump( plugins.data )

File.open( "./o/o/plugins.yml", 'w:utf-8' ) do |f|
  f.write YAML.dump( plugins.data )   ## it's an array
end
