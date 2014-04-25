require_relative 'modelize'

class Programacao < Struct.new(:data, :hora, :canal)

  include Modelize

end
