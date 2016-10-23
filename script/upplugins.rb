# encoding: utf-8

require_relative 'lib/stats'
require_relative 'lib/plugins'


require_relative 'settings'


plugins = Plugins.from_file( "./o/plugins.yml" )

plugins.update_stats( cache_dir: './cache',
                      data_dir:  './data' )
