require 'mechanize'

class Watchlist

  def self.get(user_id)
    agent = Mechanize.new
    agent.request_headers = {'accept-language' => 'pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3'}
    page = agent.get("http://www.imdb.com/user/#{user_id}/watchlist")
    page.links_with(:text => /((?!\n+).)/, :href => /title\/tt/).map { |movie| movie.text }
  end

end
