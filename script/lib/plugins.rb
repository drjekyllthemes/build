# encoding: utf-8


require 'pp'
require 'yaml'
require 'uri'


##
require_relative 'stats'


class Plugins

  def self.from_file( path )
    text = File.open( path, 'r:utf-8' ) { |file| file.read }
    self.new( text )
  end

  ## def data_by_title() @h;      end    ## returns an hash (index/key by title)
  def data()          @plugins; end    ## returns an array (of hashes/records/key-value pairs)


  def initialize( text )
    @plugins = YAML.load( text )
  end # def initialize


  def read_stats( data_dir: './data')    ### merge (updated) stats into plugins recs
    @plugins.each do |plugin|

      ## first remove/clean old stats entries
      plugin.delete( 'created' )
      plugin.delete( 'updated' )
      plugin.delete( 'commit_msg')
      plugin.delete( 'stars' )
      plugin.delete( 'stars_week' )
      plugin.delete( 'stars_month' )

      github = plugin['github']  ## full_name e.g. poole/hyde
      next   if github.nil?   ## skip if not github full_name / handle present

      stats = GithubRepoStats.new( github )
      stats.read( data_dir: data_dir )

      if stats.data['created_at']
        plugin['created'] = Time.iso8601( stats.data['created_at'] )
      end

      commits = stats.data['commits']
      if commits && commits.size > 0
        pp commits
        plugin['updated'] = Time.iso8601( commits[0]['committer']['date'] )
        committer_name   = commits[0]['committer']['name']
        commit_msg       = commits[0]['message']
        plugin['commit_msg'] = "#{commit_msg} by #{committer_name}"
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
          plugin['stars'] = stars1
          if stats_last_week
            stars2 =stats_last_week['stargazers_count']
            plugin['stars_week'] = stars1 - stars2
          else
            plugin['stars_week'] = 0   ## if no diff for week; set to 0 for now
          end
        end
      end
    end # each plugin
  end # read_stats


  def update_stats( cache_dir: './cache', data_dir: './data' )

    gh = Hubba::Github.new( cache_dir: cache_dir )

    @plugins.each do |plugin|
      github = plugin['github']  ## full_name e.g. poole/hyde
      if github
        stats = GithubRepoStats.new( github )
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

end  # class Plugins
