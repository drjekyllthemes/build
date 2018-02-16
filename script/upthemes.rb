# encoding: utf-8

require_relative 'lib/themes'


require_relative 'settings'


themes = Themes.from_file( "#{THEMES_REPO}/themes.yml" )

themes.update_stats( cache_dir: './cache',
                     data_dir:  './data' )
