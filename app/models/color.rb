class Color

  PROPERTIES = [:timestamp, :hex, :id, :tags]
  PROPERTIES.each { |prop|
    attr_accessor prop
  }

  def initialize(hash = {})
    hash.each { |key, value|
      if PROPERTIES.member? key.to_sym
        self.send((key.to_s + '=').to_s, value)
      end
    }
  end

  def tags
    @tags ||= []
  end

  def tags=(tags)
    if tags.first.is_a? Hash
      tags = tags.collect { |tag| Tag.new(tag) }
    end

    tags.each { |tag|
      if not tag.is_a? Tag
        raise 'wrong class for attempted tags, check if tag results are invalid'
      end
    }

    @tags = tags
  end

  def self.find(hex, &block)
    BubbleWrap::HTTP.get("http://www.colr.org/json/color/#{hex}") do |response|
      result_data = BW::JSON.parse(response.body.to_s)

      color_data = result_data['colors'] ? result_data['colors'][0] : {}

      color = Color.new(color_data)

      if color.id.to_i == -1 || color_data == {}
        block.call(nil)
      else
        block.call(response)
      end

    end
  end
end