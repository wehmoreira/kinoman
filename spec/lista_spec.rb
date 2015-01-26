require 'spec_helper'

describe Imdb::Lista do
  describe '.get_watchlist' do
    context 'quando recebe o código de usuário "ur52111019"' do
      subject { Imdb::Lista.get_watchlist('ur52111019') }

      it { is_expected.to be_an Array }

      it { expect(subject.size).to eq(4) }

      it 'deve retornar um array contendo os nomes dos filmes na Watchlist do usuário' do
        expect(subject).to include(
          'Um Sonho de Liberdade', 'O Poderoso Chefão',
          'O Poderoso Chefão II',  'Batman - O Cavaleiro das Trevas'
        )
      end
    end

  end
end
