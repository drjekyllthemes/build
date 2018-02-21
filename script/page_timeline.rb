# encoding: utf-8


##### run as:
# $ ruby script/page_timeline.rb

require_relative 'lib/themes'


require_relative 'settings'


themes = Themes.from_file( "#{THEMES_REPO}/themes_i.yml" )

puts "  #{themes.rows.size} themes"

buf = ''
buf << "# #{themes.rows.size} themes\n"
buf << "\n"


entries = themes.rows.dup   ## duplicate array (will resort etc.)


entries = entries.sort do |l,r|
  ## sort by created_at (use julian days)
  r_jd = r.repo ? (r.repo.stats.created_at ? r.repo.stats.created_at.to_date.jd : -1) : -1
  l_jd = l.repo ? (l.repo.stats.created_at ? l.repo.stats.created_at.to_date.jd : -1) : -1

  r_jd <=> l_jd
end


## pp entries


last_year  = -1
last_month = -1

entries.each_with_index do |theme,i|
  if theme.repo
    year       = theme.repo.stats.created_at ? theme.repo.stats.created_at.year  : '??'
    month      = theme.repo.stats.created_at ? theme.repo.stats.created_at.month : '??'
  else
    year  = '?'
    month = '?'
  end

  if last_year != year
    buf << "\n## #{year}\n\n"
  end

  if last_month != month
    buf << "\n### #{month}\n\n"
  end


  last_year  = year
  last_month = month

  if theme.repo
    buf << "- "
    if theme.repo.stats.created_at
      buf << " #{theme.repo.stats.created_at.strftime('%Y-%m-%d')}"
    else
      buf << "??"
    end
    buf << " ★#{theme.repo.stats.stars}"
  end

  buf << " **#{theme.name}** by #{theme.data['author']}"

  if theme.repo
    buf << " - [#{theme.data['github']}](#{theme.data['home_url']})"
    buf << " (#{theme.repo.stats.size} kb)"
  end

  buf << "\n"
end

puts buf


File.open( "./TIMELINE.md", "w" ) do |f|
  f.write buf
end
