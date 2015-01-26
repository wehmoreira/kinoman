require 'spec_helper'

describe Programacao do

  subject { Programacao.new(data: 'Dom - 06/04', hora: '22:00', canal: 'Warner') }

  it "instância de Programação contém data, hora e canal do filme" do
    expect(subject.data).to eql('Dom - 06/04')
    expect(subject.hora).to eql('22:00')
    expect(subject.canal).to eql('Warner')
    expect(subject.inspect).to eql(
      '#<Programacao: data="Dom - 06/04", hora="22:00", canal="Warner">'
    )
  end

end
