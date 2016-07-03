require 'test_helper'

class BirdApisTest < ActionDispatch::IntegrationTest
  
	test 'lists_all_birds' do
		get '/api/birds'
		assert_response :success
	end

	test 'create_new_bird_without_visible' do
		post '/api/birds', { name: 'Test Bird', family: 'Family', continents: ['Africa', 'Nort America'] }
		
		response = JSON.parse(@response.body)
	
		assert_response :success, response
		assert_not_nil response["payload"]["data"], "Data should not be nil"
		assert_not_empty response["payload"]["data"], "Data should not be empty"
	end

	test 'create_new_bird_with_visible' do
		post '/api/birds', { name: 'Test Bird', family: 'Family', continents: ['Africa', 'Nort America'], visible: true }
		
		response = JSON.parse(@response.body)
	
		assert_response :success, response
		assert response['payload']['data']['visible'], 'Visible should be true'
	end

	test 'get_existing_bird_success' do
		bird_id = Bird.where(:name => 'Test Bird').first.id.to_s
		get "/api/birds/#{bird_id}"

		response = JSON.parse(@response.body)
	
		assert_response :success, response
		assert_not_nil response["payload"]["data"], "Data should not be nil"
		assert_not_empty response["payload"]["data"], "Data should not be empty"
	end

	test 'get_existing_bird_fail' do
		get '/api/birds/1'

		response = JSON.parse(@response.body)
	
		assert_response :missing, response
	end

	test 'delete_existing_bird_success' do
		post '/api/birds', { name: 'Test Bird', family: 'Family', continents: ['Africa', 'Nort America'], visible: true }
		bird_id = Bird.where(:name => 'Test Bird').first.id.to_s
		delete "/api/birds/#{bird_id}"

		response = JSON.parse(@response.body)
	
		assert_response :success, response
		assert_empty response["payload"]["data"], "Data should be nil"
	end

	test 'delete_existing_bird_fail' do
		delete '/api/birds/1'

		response = JSON.parse(@response.body)
		
		assert_response :missing, response
	end

end
