# encoding: utf-8

## read markdown file
##   and convert to yaml datafile

require 'pp'
require 'yaml'



HEADING_RX = /^(?<num>\#{1,6})[ ]+(?<text>.+)/      # note: need to escape # e.g. use \#

# e.g. **Gems** or **Gist Pasties** etc.
SECTION_RX = /^\*\*(?<text>.+)\*\*/


## - [**Feed**](https://github.com/jekyll/jekyll-feed) ★206
## (gem: [jekyll-feed](https://rubygems.org/gems/jekyll-feed))
## -- a plugin to generate an Atom (RSS-like) feed of your posts   **#GitHub Pages**
ITEM_RX = /^-[ ]+(?<text>.+)$/   # items must start with a list marker e.g. -


## note: link must start item e.g. ^-anchor used
##   note: strip leading and trailing ** if present e.g. use \**
PROJECT_LINK_RX =  /^\[\**(?<name>.+?)\**\]\((?<link>.+?)\)/   ## note: use non-greedy match e.g. .+?

##   note: strip leading and trailing ` if present e.g. `jekyll-sitemap` => jekyll-sitemap
GEM_LINK_RX = /gem: \[`?(?<name>.+?)`?\]\((?<link>.+?)\)/   ## note: use non-greedy match e.g. .+?

DESCR_RX = /[ ]+--[ ]+(?<text>.+)$/

STARS_RX = /★[ ]*(?<stars>[0-9]+)[ ]+/


plugins = []
last_category = ''


lineno = 0
File.open( "plugins.md", 'r:utf-8' ).each_line do |line|
  lineno += 1
  line = line.chomp  # remove trailng newline

  line = line.strip  # remove leading and trailing whitespaces e.g. "    hello    ".strip #=> "hello"

  next if line.length == 0   ## skip blank lines


  if m=HEADING_RX.match( line )
    puts "*** matching heading #{m[:num]} -- >>#{m[:text]}<<"
    if m[:num].length == 2
      puts "   *** bingo: setting category to >>#{m[:text]}<<"
      last_category = m[:text]
    end
  elsif m=SECTION_RX.match( line )
    puts "*** matching section e.g. bold line -- >>#{m[:text]}<<"
  elsif m=ITEM_RX.match( line )
    item = m[:text]
    puts "*** >>#{item}<<"
    if m=GEM_LINK_RX.match( item )
      puts "*** bingo: gem >>#{m[:name]}<< - >>#{m[:link]}<<"

      plugin = {
        'gem'      => m[:name],
        'gem_url'  => m[:link],
        'category' => last_category
      }

      if m=PROJECT_LINK_RX.match( item )
        puts "   *** project >>#{m[:name]}<< - >>#{m[:link]}<<"
        plugin[ 'title' ]         = m[:name]
        ## use site_url, repo_url or something or check for github and use github or github_url - why? why not??
        plugin[ 'project_url']    = m[:link]
      end
      if m = DESCR_RX.match( item )
        puts "   *** descr >>#{m[:text]}<<"
        plugin[ 'descr' ] = m[:text]
      end
      if m = STARS_RX.match( item )
        puts "   *** stars >>#{m[:stars]}<<"
        plugin[ 'stars' ] = m[:stars].to_i
      end

      plugins << plugin
    end
  else
    # no match - skip line
    puts "skipping [%-3d] >>%s<<" % [lineno,line]
  end

end


## pp plugins

File.open( "plugins.yml", 'w:utf-8' ) do |f|
  f.write YAML.dump( plugins )   ## it's an array
end
