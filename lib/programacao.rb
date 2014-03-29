class Programacao

  attr_accessor :canal, :data, :hora

  def initialize(data, hora, canal)
    @data, @hora, @canal =  data, hora, canal
  end

end
