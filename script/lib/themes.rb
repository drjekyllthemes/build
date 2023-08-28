require 'pp'
require 'yaml'
require 'json'
require 'uri'
require 'time'

## 3rd party gems
require 'hubba'
require 'hubba/reports'   ## note: required for Hubba::Stats accessors!!!

module Hubba
class Stats
  def data() @data; end
end
end


class Themes

class Theme

class GitHubRepo

  attr_reader :stats

  def initialize( full_name )
    @stats = Hubba::Stats.new( full_name )
    @stats.read
    end

  def diff()  @diff ||= stats.calc_diff_stars( samples: 3, days: 30 ); end

end  # class GitHubRepo



  attr_reader :name, :data, :repo

  def initialize( name, data )
    @name = name
    @data = data

    github = data['github']  ## full_name e.g. poole/hyde

    puts "==> theme >#{@name}< @ github >#{github}<..."
    ## pp @data


    if github.nil?   ## skip if not github full_name / handle present
      ## skip do nothing? use nil pattern - why? why not??
      @repo = nil
    else
      @repo = GitHubRepo.new( github )
    end
  end

end # class Theme



  def self.read( path )
    text = File.open( path, 'r:utf-8' ) { |file| file.read }
    new( text )
  end

  def data_by_name() @theme_by_name; end    ## returns an hash (index/key by name)
  def data()         @themes;        end    ## returns an array (of hashes/records/key-value pairs)


  ### use rows for now (for "typed" theme records)
  ##  rename data to ??? - why? why not?
  def rows()   @rows;  end



  def initialize( text )
    themes = YAML.load( text )

    ## pp themes

    ## build a (lookup) index by name
    ## (as key for now - use github full_name for key) - why? why not?
    @theme_by_name = {}

    ### use rows for now (for "typed" theme records)
    @rows = []

    themes.each do |theme|

        ## unify
        ##  check for github shortcut - expand/(auto-)add home_url n download_url
        github = theme['github']
        if github
          branch = theme[ 'branch'] || 'master' ## if no branch listed assume master

          ## note: cut-off if starts with https://github.com/
          github = theme['github'] = github.sub( 'https://github.com/', '' )

          theme[ 'home_url' ]     = "https://github.com/#{github}"
          theme[ 'download_url' ] = "https://github.com/#{github}/archive/#{branch}.zip"
        else   ## assume no github shortcut - try adding github shortcut if present
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
            ## note: exit with error/throw exception - why? why not??
            fail "!!! *** no home_url (or github) found for >#{theme.inspect}<"
          end
        end

        name = theme['name']
        @theme_by_name[ name ] = theme

        @rows << Theme.new( name, theme )
      end

    ## puts
    ## pp themes
    @themes = themes
  end # def initialize




  def read_stats    ### merge (updated) stats into themes recs
    @themes.each do |theme|

      ## first remove/clean old stats entries
      theme.delete( 'created' )
      theme.delete( 'updated' )
      theme.delete( 'commit_msg')
      theme.delete( 'stars' )
      theme.delete( 'stars_week' )
      theme.delete( 'stars_month' )

      github = theme['github']  ## full_name e.g. poole/hyde
      next   if github.nil?   ## skip if not github full_name / handle present

      stats = Hubba::Stats.new( github )
      stats.read

      if stats.data['created_at']
        theme['created'] = Time.iso8601( stats.data['created_at'] )
      end

      commits = stats.data['commits']
      if commits && commits.size > 0
        pp commits
        theme['updated'] = Time.iso8601( commits[0]['committer']['date'] )
        committer_name   = commits[0]['committer']['name']
        commit_msg       = commits[0]['message']
        theme['commit_msg'] = "#{commit_msg} by #{committer_name}"
      end

      if stats.history
        theme['stars'] = stats.stars

        stars_diff = stats.calc_diff_stars
        if stars_diff     ## todo: rename to starts_month !!!
          theme['stars_week'] = stars_diff
        else
          theme['stars_week'] = 0   ## if no diff for week; set to 0 for now
        end
      end
    end # each theme
  end # read_stats



  def update_stats

    gh = Hubba::Github.new

    @themes.each do |theme|
      github = theme['github']  ## full_name e.g. poole/hyde
      if github
        stats = Hubba::Stats.new( github )
        stats.read

        begin
          repo  = gh.repo( github )
          stats.update( repo )
          stats.write
        rescue Hubba::HttpError => ex
          msg = "http error -- #{ex.message}"
          puts "   !! ERROR - #{msg}"
          ## continue for now 
        end
#
##  todo:
##  check for status 301 e.g.
## "status => 301 Moved Permanently"

      end
    end
  end  # update_stats

end  # class Themes
