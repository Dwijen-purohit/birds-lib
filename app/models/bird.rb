class Bird
  	include Mongoid::Document

  	# Fields for Bird Model
  	field :name, 		type: String
  	field :family, 		type: String
  	field :continents, 	type: Array
	field :visible, 	type: Boolean
	field :added,		type: DateTime, 	default: Time.now

	validates :name, presence: true
	validates :family, presence: true
	validates :continents, presence: true

	def self.create_new(data)
		bird 			= 		Bird.new
		bird.name 		= 		data[:name]
		bird.family 	= 		data[:family]
		bird.continents = 		data[:continents].uniq
		bird.visible 	= 		data[:visible] || false
		
		raise "Failed to save - #{bird.errors.full_messages.join(', ')}" unless bird.save

		return bird
	end

	# Transform Method
	def transform
		{
			id: 			self.id.to_s,
			name: 			self.name,
			family: 		self.family,
			continents: 	self.continents,
			added: 			self.added,
			visible: 		self.visible
		}
	end

end

