module Modelize

  def initialize(hsh = {})
    super(*sort_hash(hsh).values)
  end

  def members
    super
  end

   def inspect
    data = attributes.map { |attr| "#{attr}=#{send(attr).inspect}" }
    "#<#{self.class}: #{data.join(', ')}>"
  end

  alias :attributes :members
  alias :to_s       :inspect

  private

  def sort_hash(hsh)
    attrs = attributes
    array = hsh.map { key = attrs.shift; [ key, hsh[key] ] }
    Hash[array]
  end
 
end
