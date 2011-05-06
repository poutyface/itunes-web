require 'uri'

module Itunes
  class Track

    def initialize(description={})
      @description = description
    end

    def [](key)
      @description[key]
    end

    def id
      self['Track ID']
    end

    def name
      self['Name']
    end

    def artist
      self['Artist']
    end

    def album
      self['Album']
    end

    def location
      URI.decode_www_form_component self['Location'].gsub(/^file:\/\/localhost/, '').to_s
    end

    def play_count
      self['Play Count']
    end

    def size
      self['Size']
    end

    def total_time
      self['Total Time']
    end

  end
end
