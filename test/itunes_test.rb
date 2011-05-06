require 'test_helpers.rb'
require 'itunes'

class ItunesTest < ActiveSupport::TestCase
  setup do 
    Itunes.prepare
  end

  test 'true' do
    true
  end

end
