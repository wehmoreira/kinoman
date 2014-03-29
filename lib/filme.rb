require 'nokogiri'
require 'open-uri'

require_relative 'programacao'

class Filme

  attr_accessor :titulo, :tipo, :programacao

  def initialize(tipo, titulo)
    @tipo, @titulo = tipo, titulo
    @programacao = []
  end

  def self.find(movie)
    nokogiri_object = Nokogiri::HTML(open("http://www.hagah.com.br/programacao-tv/jsp/default.jspx?uf=26&action=busca&operadora=13&palavras=#{URI.escape(movie)}&gds=0&skin="))
    grades = nokogiri_object.xpath('//ul[@class="grade-resultado"]')
    filmes = []
    grades.each do |grade|
      filme = self.new(grade.child.children.last.remove.text, grade.child.children.text)
      prog = grade.children.css('li[@class="linha filme"]')
      prog.children.each do |r|
        filme.programacao << Programacao.new(*r.children[0].children.map { |el| el.text })
      end
    filmes << filme
    end
    filmes
  end

end
