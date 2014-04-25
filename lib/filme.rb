require 'nokogiri'
require 'open-uri'
require_relative 'programacao'

class Filme < Struct.new(:tipo, :titulo)

  attr_accessor :programacao

  include Modelize

  def initialize(*args)
    super(*args)
    @programacao = []
  end

  def self.find(movie)
    nokogiri_object = Nokogiri::HTML(open("http://www.hagah.com.br/programacao-tv/jsp/default.jspx?uf=26&action=busca&operadora=13&palavras=#{URI.escape(movie)}&gds=0&skin="))
    grades = nokogiri_object.xpath('//ul[@class="grade-resultado"]')
    filmes = []
    grades.each do |grade|
      filme = self.new(tipo: grade.child.children.last.remove.text, titulo: grade.child.children.text)
      prog = grade.children.css('li[@class="linha filme"]')
      prog.children.each do |r|
        programacao = r.children[0].children.map { |el| el.text }
        programacao = Hash[[:data, :hora, :canal].zip(programacao)]
        filme.programacao << Programacao.new(programacao)
      end
    filmes << filme
    end
    filmes
  end

end
