class Color
  PROPERTIES = [:timestamp, :hex, :id, :tags]
  PROPERTIES.each { |prop|
    attr_accessor prop
  }

  def initialize(hash = {})
    hash.each { |key,value|
      if PROPERTIES.member? key.to_sym
        self.send((key.to_s + '=').to_s, value)
      end
    }
  end
end