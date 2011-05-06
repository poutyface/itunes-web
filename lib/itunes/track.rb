module Itunes
  class Track
    attr_reader :id

    def initialize(desc={})
      @id = desc["Track ID"]
      desc.each do |key, value|
        key = key.split.map(&:downcase).join('_')
        instance_variable_set("@#{key}", value)
        self.class.__send__(:attr_reader, key.to_sym) unless self.class.public_method_defined? key.to_sym     
      end
    end

    def method_missing(name, *args)
      ""
    end
  end
end
