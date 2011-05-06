require 'test_helpers.rb'
require 'itunes'

Itunes.prepare

class ItunesTest < ActiveSupport::TestCase
  setup do 
  end

  test 'find' do
    track = Itunes.find(275)
    assert_equal(track.name, "Fantasy for Violin and Orchestra")
    assert_equal(track.artist, "Emiri Miyamoto")
    assert_equal(track.album, "Tears")
  end

  test 'find_by_name' do
    track = Itunes.find_by_name("Fantasy for Violin and Orchestra").first
    assert_equal(track.name, "Fantasy for Violin and Orchestra")
    assert_equal(track.artist, "Emiri Miyamoto")
    assert_equal(track.album, "Tears")
  end

  test 'find_by_artist' do
    track = Itunes.find_by_artist("Emiri Miyamoto")
    assert_not_equal(track, [])
  end

  test 'find_by_album' do
    track = Itunes.find_by_album("Tears")
    assert_not_equal(track, [])
  end

end
