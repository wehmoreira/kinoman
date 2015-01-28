require 'spec_helper'

describe Imdb::Lista do

  describe '.get_watchlist' do
    subject { Imdb::Lista.get_watchlist(user_id) }

    context 'quando recebe um código válido de usuário para uma lista pública' do
      let(:user_id) { 'ur52111019' }

      it { is_expected.to be_an Array }

      it 'retorna os nomes dos filmes na Watchlist do usuário' do
        expect(subject.size).to eq(4)
        is_expected.to include(
          'Um Sonho de Liberdade', 'O Poderoso Chefão',
          'O Poderoso Chefão II',  'Batman - O Cavaleiro das Trevas'
        )
      end
    end

    context 'quando recebe um código de usuário de lista não pública' do
      let(:user_id) { 'ur24191790' }

      it { expect{ subject }.to raise_error(Imdb::PrivateListError, "esta lista não é pública") }
    end

    context 'quando recebe um código de usuário inexistente' do
      let(:user_id) { 'str_invalida' }

      it { expect{ subject }.to raise_error(/Net::HTTPNotFound/) }
    end
  end

  describe '.get_list' do
    context 'quando recebe o código de lista ""' do
    end
  end
end
