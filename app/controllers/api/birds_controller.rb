module Api
	class BirdsController < ApplicationController

		# Get all birds
		def index
			response = self.format_success_response Bird.where(:visible => true).map(&:transform)
			render :json => response, :status => response[:status]
		end		

		# Create new Bird
		def create
			rules = {
				:name 		=> 	[:is_required, :is_string],
				:family 	=> 	[:is_required, :is_string],
				:continents => 	[:is_required, :is_array_type, :is_not_empty]
			}
			status = self.valid_params? rules

			unless status[:passed]
				response = self.format_error_response status[:messages], 400
			else
				begin
					bird = Bird.create_new params
					response = self.format_success_response bird.transform
				rescue Exception => ex
					response = self.format_error_response [ex.message], 400
				end
			end
			render :json => response, status: response[:status]
		end

		# Get Single Bird
		def show
			rules ={
				:id 	=> [:is_required, :is_alpha_numeric]
			}
			status = self.valid_params? rules
			unless status[:passed]
				response = self.format_error_response status[:messages], 400
			else
				begin
					response = self.format_success_response(Bird.find(params[:id]).transform)	
				rescue Exception => e
					response = self.format_error_response(["Bird doesn't exist."], 404)
				end				
			end
			render :json => response, status: response[:status]
		end

		# Delete Single Bird
		def destroy
			rules ={
				:id 	=> [:is_required, :is_alpha_numeric]
			}
			status = self.valid_params? rules
			unless status[:passed]
				response = self.format_error_response status[:messages], 400
			else
				begin
					Bird.find(params[:id]).destroy
					response = self.format_success_response({}, ["Successfuly deleted bird"])
				rescue Exception => e
					response = self.format_error_response(["Bird doesn't exist."], 404)
				end				
			end
			render :json => response, status: response[:status]
		end

	end	
end
