require 'spec_helper'
resource = File.join(File.dirname(__FILE__), 'resources', 'programacao.html')
filme = 'Matrix'

include WebMock::API

describe Filme do

  before do
    stub_request(:get, "www.hagah.com.br/programacao-tv/jsp/default.jspx").
    with(
      query: {
        action: 'busca',
        gds: '0',
        operadora: '13',
        palavras: filme,
        skin: '',
        uf: '26'
      }
    ).to_return(body: File.read(resource))
  end

  subject { Filme.new('Filme', filme) }

  its(:programacao) { should be_kind_of Array }

  describe '.find' do

    subject { Filme.find(filme) }

    its(:size) { should eq(2) }

  end

end
