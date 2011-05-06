require "uri"
require 'erb'
require "rexml/document"
require 'itunes/track'


module Itunes
  extend self

  def library_path
    @@library_path ||= File.expand_path('~/') + '/Music/iTunes/iTunes Music Library.xml'
  end


  def library
    @@library ||= REXML::Document.new(open(library_path, 'r'))
  end


  def prepare
    dict = Hash.new { |h, k| h[k] = {} }
    library.elements.each("plist/dict/dict") do |track|
      track.elements.each("key") do |id|
        id.next_element.elements.each("key") do |key|
          next if key.next_element.text == nil
          value = key.next_element.text
          if key.text == "Location"
            value = URI.parse(key.next_element.text) - "file://localhost"
            value = URI.decode_www_form_component(value.to_s)
          else
            value = URI.decode_www_form_component(value)
          end
          dict[id.text.to_i][key.text] = value 
        end
      end
    end
    @@tracks = dict
  end

  def info(key)
    value = ""
    library.elements.each("plist/dict/key") do |info|
      if info.text == key
        value = info.next_element.text
        break
      end
    end
    value
  end

  def major_version; info("Major Version"); end    

  def minor_version; info("Minor Version"); end

  def application_version; info("Application Version"); end
  
  def features; info("Features"); end

  def show_content_ratings; info("Show Content Ratings"); end

  def music_folder; info("Music Folder"); end

  def library_persisten_id; info("Library Persistent ID"); end


  def tracks
    prepare unless @@tracks
    @@tracks
  end


  def find(id)
    if id == :all
      tracks.map { | key, track |  Track.new(track) }
    else
      Track.new(tracks[id.to_i])
    end
  end


  ['name', 'artist', 'album'].each do |key|
    define_method("find_by_#{key}") do |name|
      ts = []
      tracks.each do |id, track|
        if track[key.capitalize] == name
          ts << Track.new(tracks[id.to_i])
        end
      end
      ts
    end
  end

end

