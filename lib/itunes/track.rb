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

    def location(uri=true)
      unless uri
        URI.decode_www_form_component self['Location'].sub(/^file:\/\/localhost/, '')
      else
        self['Location']
      end
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
