require 'spec_helper'
filme = 'Matrix'

# cria um array de objetos recebidos e esperados, do tipo
# [ "Matrix", "Matrix",
#   "Filme", "Filme",
#   "Dom - 30/03", "Dom - 30/03", "00:35", "00:35", "TNT", "TNT",
#   "Dom - 30/03", "Dom - 30/03", "13:00", "13:00", "TNT", "TNT",
#   "Dom - 30/03", "Dom - 30/03", "15:20", "15:20", "Warner", "Warner" ]
def descanter(array, ary_expected)
  array.zip(ary_expected).map do |object, obj_expected|
    object.instance_variables.map do |method|
      m = method.to_s.gsub('@', '').to_sym
      if m == :programacao
        descanter(object.programacao, obj_expected.programacao)
      else
        [ object.send(m), obj_expected.send(m) ]
      end
    end
  end.flatten
end

describe Filme do

  context 'instância com título "Matrix" e tipo "Filme"' do

    subject(:movie) { Filme.new(titulo: filme, tipo: 'Filme') }

    it 'contém título, tipo e array de programações' do
      expect(movie.titulo).to eq(filme)
      expect(movie.tipo).to eq('Filme')
      expect(movie.programacao).to be_an Array
      expect(movie.inspect).to eq("#<Filme: tipo=\"Filme\", titulo=\"#{filme}\">")
    end

  end

  describe '.find' do

    subject { Filme.find(filme) }

    it { is_expected.to be_an Array }

    context 'quando recebe o nome de um filme ("Matrix") como parâmetro' do

      it { expect(subject.size).to eq(2) }

      it 'retorna array de Filmes contendo um array de programações desse filme' do
        subject.each do |film|
          expect(film).to be_a Filme
          film.programacao.each do |prog|
            expect(prog).to be_a Programacao
          end
        end
      end

      it 'deve conter dia, horário e canal de cada programação' do
        array = descanter(subject, [build(:filme), build(:sequel)])
        array.each_slice(2) do |result, expected|
          expect(result).to eq(expected)
        end
      end
    end

  end
end
