require 'spec_helper'

describe Watchlist do
  describe '.get' do
    subject { Watchlist.get('ur52111019') }

    it { should be_an Array }

    its(:size) { should eq(4) }

    it 'deve ser um array contendo os nomes dos filmes na Watchlist' do
      subject.should == [
        'Um Sonho de Liberdade', 'O Poderoso Chefão',
        'O Poderoso Chefão II',  'Batman - O Cavaleiro das Trevas'
      ]
    end

  end
end
