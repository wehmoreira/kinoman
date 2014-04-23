require 'spec_helper'

describe Programacao do

  subject { Programacao.new(data: 'Dom - 06/04', hora: '22:00', canal: 'Warner') }

  its(:data)  { should eql('Dom - 06/04') }
  its(:hora)  { should eql('22:00')  }
  its(:canal) { should eql('Warner') }

  its(:inspect) do
    should eql(
      '#<Programacao: data="Dom - 06/04", hora="22:00", canal="Warner">'
    )
  end

end
