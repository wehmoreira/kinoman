require 'rspec'
require 'webmock/rspec'
$LOAD_PATH << './lib'
require 'filme'
require 'watchlist'
require 'factory_girl'

resources = File.join(File.dirname(__FILE__), 'resources')

FactoryGirl.find_definitions

WebMock.disable_net_connect!(allow_localhost: true)
hagah = resources + '/programacao.html'
imdb  = resources + '/watchlist.html'

RSpec.configure do |config|
  # including factory_girl
  config.include FactoryGirl::Syntax::Methods
  # stubs for http requests
  config.before(:each) do
    # stub for Filme class
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
    # stub for Watchlist class
    stub_request(:get, "http://www.imdb.com/user/ur52111019/watchlist")
    .to_return(body: File.read(imdb), headers: { 'Content-Type' => 'text/html' })
  end
end
