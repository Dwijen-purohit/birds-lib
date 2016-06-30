class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  protected

  def format_success_response data, messages = ["Success"]
  	{
  		status: 200,
  		payload: {
  			messages: messages,
  			data: data
  		}
  	}
  end

  def format_error_response messages, status = 411
  	{
  		status: status,
  		payload: {
  			messages: messages
  		}
  	}
  end

  def valid_params? param_rules
  	status = {
  		passed: true,
  		messages: []
  	}
  	param_rules.each { |p, rules|
  		rules.each { |rule|
  			result = self.send(rule.to_sym, params[p.to_sym])
	  		unless result[:is_valid]
	  		 	status[:passed] = false
	  		 	status[:messages].push p.to_s + result[:message]
	  		end
  		}  		 
  	}
  	return status
  end

  # Validation Rule Methods
  def is_required param
  	is_valid = !param.nil?
  	{
  		is_valid: is_valid,
  		message: is_valid || " is required"
  	}
  end

  def is_string param
  	is_valid = (param.match(/^[a-zA-Z\s]+$/) != nil)
  	{
  		is_valid: is_valid,
  		message: is_valid || " is not a valid string"
  	}
  end

  def is_numeric param
  	is_valid = (param.match(/^[0-9]+$/) != nil)
  	{
  		is_valid: is_valid,
  		message: is_valid || " is not a valid number"
  	}
  end

  def is_array_type param
  	is_valid = param.is_a? Array
  	{
  		is_valid: is_valid,
  		message: is_valid || " is not an Array"
  	}
  end

  # Can be used only with Arrays
  def is_not_empty param
  	is_valid = true
  	param.each { |v|
  		is_valid = false if v.to_s.length == 0
  	}

  	{
  		is_valid: is_valid,
  		message: is_valid || " cannot be empty and cannot have empty values"
  	}
  end

end
