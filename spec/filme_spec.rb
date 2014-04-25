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

  subject { Filme.new(titulo: filme, tipo: 'Filme') }
  its(:titulo)      { should eql(filme) }
  its(:tipo)        { should eql('Filme') }
  its(:programacao) { should be_an Array }

  its(:inspect) do
    should eql(
      "#<Filme: tipo=\"Filme\", titulo=\"#{filme}\">"
    )
  end

  describe '.find' do
    subject { Filme.find(filme) }

    it { should be_an Array }

    its(:size) { should eq(2) }

    it 'deve ser um array de filmes contendo um array de programacoes' do
      subject.each do |film|
        film.should be_a Filme
        film.programacao.each do |prog|
          prog.should be_a Programacao
        end
      end
    end

    it 'deve conter todas as informacoes de programacao adequadamente' do
      array = descanter(subject, [build(:filme), build(:sequel)])
      array.each_slice(2) do |result, expected|
        result.should eq(expected)
      end
    end

  end
end
