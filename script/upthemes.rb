require_relative 'lib/themes'


require_relative 'settings'


Hubba.configure do |config|
    config.data_dir  = './data'
    config.cache_dir = './cache'
end


themes = Themes.read( "#{THEMES_REPO}/themes.yml" )
themes.update_stats


__END__

fix 404 (not found) and 301 (moved permanently)



GET https://api.github.com/repos/artemsheludko/melotta...
!! HTTP ERROR: 404 Not Found:

GET https://api.github.com/repos/jugglerx/jekyll-serif-theme...
!! HTTP ERROR: 301 Moved Permanently:

GET https://api.github.com/repos/pro-panda/cocoon...
!! HTTP ERROR: 301 Moved Permanently:

GET https://api.github.com/repos/kaptn/blog...
!! HTTP ERROR: 404 Not Found:

GET https://api.github.com/repos/mighildotcom/sparrowx...
!! HTTP ERROR: 301 Moved Permanently:

GET https://api.github.com/repos/sharadcodes/blogo...
!! HTTP ERROR: 404 Not Found:

GET https://api.github.com/repos/sharadcodes/simplifico...
!! HTTP ERROR: 404 Not Found:

GET https://api.github.com/repos/SupunKavinda/jekyll-theme-leaf...
!! HTTP ERROR: 301 Moved Permanently:

GET https://api.github.com/repos/sziv2p/jekyll-theme-scaffold...
!! HTTP ERROR: 404 Not Found:

GET https://api.github.com/repos/coderzhaoziwei/jekyll-theme-acg...
!! HTTP ERROR: 301 Moved Permanently:
