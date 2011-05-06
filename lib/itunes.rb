require 'plist'
require 'itunes/track'


module Itunes
  extend self

  def load(path)
    @@library = Plist::parse_xml(path)
  end

  def library
    @@library ||= {}
  end

  def [](key)
    library[key]
  end

  def tracks
    @@tracks ||= self['Tracks'].values.map { |t| Track.new(t) }
  end


  def find(id)
    if id == :all
      tracks
    else
      tracks.find { |t| t.id == id.to_i }
    end
  end


  ['name', 
   'artist', 
   'album'
  ].each do |key|
    define_method("find_by_#{key}") do |value|
      tracks.find_all { |t| t.__send__(key) == value }
    end
  end

end

