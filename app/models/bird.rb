class Bird
  	include Mongoid::Document

  	# Fields for Bird Model
  	field :name, 		type: String
  	field :family, 		type: String
  	field :continents, 	type: Array
	field :visible, 	type: Boolean

	def self.create_new(data)
		bird 			= 		Bird.new
		bird.name 		= 		data[:name]
		bird.family 	= 		data[:family]
		bird.continents = 		data[:continents].uniq
		bird.visible 	= 		data[:visible] || false
		bird.save
		return bird
	end

	# Transform Method
	def transform
		{
			id: 			self.id,
			name: 			self.name,
			family: 		self.family,
			continents: 	self.continents,
			added: 			self.added,
			visible: 		self.visible
		}
	end

end

