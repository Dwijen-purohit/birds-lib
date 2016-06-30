require 'test_helper'

class BirdTest < ActiveSupport::TestCase
  
	test "creating_new_bird_without_visible" do
		data = {
			:name => "Bird 1", 
			:family => "family 1",
			:continents => ["One", "Two"]
		}
		bird = Bird.create_new data

		assert_instance_of Bird, bird, "Failed to create new bird without visible"
		assert_equal bird.name, data[:name], "Bird Name Mismatch"
		assert_equal bird.family, data[:family], "Bird family Mismatch"
		assert_equal bird.continents, data[:continents], "Bird continents Mismatch"
		assert_equal bird.visible, false, "Bird visible should be false"
	end

	test "creating_new_bird_with_visible" do
		data = {
			:name => "Bird 2", 
			:family => "family 1",
			:continents => ["One", "Two"],
			:visible => true
		}
		bird = Bird.create_new data

		assert_equal bird.visible, data[:visible], "Bird visible should be true"
	end

	test "creating_new_bird_with_duplicate_continents" do
		data = {
			:name => "Bird 3", 
			:family => "family 4",
			:continents => ["One", "Two", "Two"],
			:visible => true
		}
		bird = Bird.create_new data

		assert_equal bird.continents, data[:continents].uniq, "Bird continents should be unique"
	end

end
