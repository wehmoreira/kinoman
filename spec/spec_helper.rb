require 'rspec'
require 'webmock/rspec'
$LOAD_PATH << './lib'
require 'filme'

WebMock.disable_net_connect!(allow_localhost: true)
resource = File.join(File.dirname(__FILE__), 'resources', 'programacao.html')

RSpec.configure do |config|
  config.before(:each) do
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
    ).to_return(body: File.read(resource))
  end
end
