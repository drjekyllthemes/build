##### 
#  run as:
# $ ruby script/page_stars.rb

require_relative 'lib/themes'


require_relative 'settings'


themes = Themes.read( "#{THEMES_REPO}/themes_i.yml" )

puts "  #{themes.rows.size} themes"

buf = ''
buf << "# #{themes.rows.size} themes\n"
buf << "\n"


entries = themes.rows.dup   ## duplicate array (will resort etc.)


entries = entries.sort do |l,r|
  ## note: use reverse sort (right,left) - e.g. most stars first
  r_stars = r.repo ? r.repo.stats.stars : -1
  l_stars = l.repo ? l.repo.stats.stars : -1

  r_stars <=> l_stars
end

## pp entries


entries.each_with_index do |theme,i|
  buf << "#{i+1}."
  if theme.repo
    buf << " ★#{theme.repo.stats.stars}"
  end
  buf <<" **#{theme.name}** by #{theme.data['author']}"
  if theme.repo
    buf << " - [#{theme.data['github']}](#{theme.data['home_url']})"
    buf << " (#{theme.repo.stats.size} kb)"
  end
  buf << "\n"
end


puts buf


File.open( "./STARS.md", "w" ) do |f|
  f.write buf
end
