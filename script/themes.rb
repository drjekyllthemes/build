# encoding: utf-8


require 'pp'
require 'yaml'
require 'uri'


##
require_relative 'stats'


class Themes

  def self.from_file( path )
    text = File.read( path )
    self.new( text )
  end

  def initialize( text )
    themes = YAML.load( text )

    ## pp themes

    ## build a (lookup) index by github key
    hash = {}

    themes.each do |theme|

      github = theme['github']
      if github.nil?
        home_url_str = theme['home_url']
        if home_url_str
          home_url = URI.parse( home_url_str )
          if home_url.host == 'github.com'
             theme['github'] = home_url.path[1..-1]   # note: cut-off leading slash (e.g. /)
             puts "adding github shortcut >#{theme['github']}<"
          else
             puts "!!! *** no github shortcut found for >#{home_url_str}<"
          end
        else
          puts "!!! *** no home_url (and github) found for >#{theme.inspect}<"
        end
      end

      github = theme['github']
      if github     ## note: skip themes without github key for now
        hash[ github ] = theme
      end
    end

    @themes = themes
    @h = hash
  end # def initialize


  def update_stats( cache_dir: './cache', data_dir: './data' )

    gh = Hubba::Github.new( cache_dir: cache_dir )

    @themes.each do |theme|
      github = theme['github']  ## full_name e.g. poole/hyde
      if github
        stats = GithubRepoStats.new( github )
        stats.read( data_dir: data_dir )
        ## stats.fetch( gh )
        ## stats.write( data_dir: data_dir )
      end
    end
  end  # update_stats

end  # class Themes



themes_repo = File.expand_path( '../themes' )

themes = Themes.from_file( "#{themes_repo}/themes.yml" )

themes.update_stats( cache_dir: './cache',
                     data_dir: './data' )
