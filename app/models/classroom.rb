class Classroom < ActiveRecord::Base
	validates_presence_of :name

	belongs_to :school

	def classroom_name
		"#{name} is a cool class."
	end

	def classroom_size
		if (size >= 50)
			"Big class"
		elsif (size < 50 && size > 25)
			"Medium class"
		else (size < 30)
			"Small class"
		end
	end
end
