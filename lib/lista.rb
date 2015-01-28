require 'mechanize'

module Imdb

  class PrivateListError < StandardError
  end

  class Lista

    def self.get_watchlist(user_id)
      agent = Mechanize.new
      agent.request_headers = {'accept-language' => 'pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3'}
      page = agent.get("http://www.imdb.com/user/#{user_id}/watchlist")
      raise PrivateListError, "esta lista não é pública" if page.search('div.info h2').text == "This list is not public"
      page.search('//div[@class="title"]/a').map { |movie| movie.text }
    end

    def self.get_list(list_id)
      agent = Mechanize.new
      agent.request_headers = {'accept-language' => 'pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3'}
      page = agent.get("http://www.imdb.com/list/#{list_id}?start=1&view=compact")
)
    end

  end
end
