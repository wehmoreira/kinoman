require 'rspec'
require 'webmock/rspec'
$LOAD_PATH << './lib'
require 'filme'
require 'lista'
require 'factory_girl'

resources = File.join(File.dirname(__FILE__), 'resources')

FactoryGirl.find_definitions

WebMock.disable_net_connect!(allow_localhost: true)
hagah = resources + '/programacao.html'
imdb  = resources + '/watchlist.html'
rss   = resources + '/watchlist.xml'

RSpec.configure do |config|
  # including factory_girl
  config.include FactoryGirl::Syntax::Methods
  # stubs for all http requests
  config.before(:each) do
    #
    # Filme class stub
    stub_request(:get, "www.hagah.com.br/programacao-tv/jsp/default.jspx").
    with(
      query: {
        action: 'busca',
        gds: '0',
        operadora: '13',
        palavras: 'Matrix',
        skin: '',
        uf: '26'
      }
    ).to_return(body: File.read(hagah))
    #
    # watchlist stub
    stub_request(:get, "http://www.imdb.com/user/ur52111019/watchlist")
    .to_return(body: File.read(imdb), headers: { 'Content-Type' => 'text/html' })
    #
    # Rss watchlist stub
    stub_request(:get, "http://rss.imdb.com/user/ur52111019/watchlist")
    .to_return(body: File.read(rss), headers: { 'Content-Type' => 'text/html' })
  end
end
