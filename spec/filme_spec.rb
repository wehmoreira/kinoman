require 'spec_helper'
filme = 'Matrix'


describe Filme do

  subject { Filme.new('Filme', filme) }
  its(:programacao) { should be_kind_of Array }

  describe '.find' do
    subject { Filme.find(filme) }
    its(:size) { should eq(2) }
  end
end
