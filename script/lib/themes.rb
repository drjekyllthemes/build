# encoding: utf-8


require 'pp'
require 'yaml'
require 'json'
require 'uri'
require 'time'

## 3rd party gems
require 'hubba'



class Themes

  def self.from_file( path )
    text = File.open( path, 'r:utf-8' ) { |file| file.read }
    self.new( text )
  end

  def data_by_name() @h;      end    ## returns an hash (index/key by name)
  def data()         @themes; end    ## returns an array (of hashes/records/key-value pairs)


  def initialize( text )
    themes = YAML.load( text )

    ## pp themes

    ## build a (lookup) index by name
    ## (as key for now - use github full_name for key) - why? why not?
    @h = {}

    themes.each do |theme|

        ## unify
        ##  check for github shortcut - expand/(auto-)add home_url n download_url
        github = theme['github']
        if github
          branch = theme[ 'branch'] || 'master' ## if no branch listed assume master
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
        @h[ name ] = theme
      end

    @themes = themes
  end # def initialize


  def read_stats( data_dir: './data')    ### merge (updated) stats into themes recs
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

      stats = GithubRepoStats.new( github )
      stats.read( data_dir: data_dir )

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

      history = stats.data['history']
      if history
        history_keys  = stats.data['history'].keys.sort.reverse
        ## todo/fix: for now assumes one entry per week
        ##    simple case [0] and [1] for a week later
        ##   check actual date - why? why not?
        stats_this_week = history_keys[0] ? history[ history_keys[0] ] : nil
        stats_last_week = history_keys[1] ? history[ history_keys[1] ] : nil

        if stats_this_week
          stars1 = stats_this_week['stargazers_count']
          theme['stars'] = stars1
          if stats_last_week
            stars2 =stats_last_week['stargazers_count']
            theme['stars_week'] = stars1 - stars2
          else
            theme['stars_week'] = 0   ## if no diff for week; set to 0 for now
          end
        end
      end
    end # each theme
  end # read_stats


  def update_stats( cache_dir: './cache', data_dir: './data' )

    gh = Hubba::Github.new( cache_dir: cache_dir )

    @themes.each do |theme|
      github = theme['github']  ## full_name e.g. poole/hyde
      if github
        stats = Hubba::Stats.new( github )
        stats.read( data_dir: data_dir )
        stats.fetch( gh )
##
##  todo:
##  check for status 301 e.g.
## "status => 301 Moved Permanently"

        stats.write( data_dir: data_dir )
      end
    end
  end  # update_stats

end  # class Themes
