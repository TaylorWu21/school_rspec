class School < ActiveRecord::Base
	validates_presence_of :name, :year, :mascot

	def school_name
		"The school name is #{name}, with a #{mascot} as the mascot"
	end

	def year_built
		school_year = year.to_i
		if (school_year > 2000)
			"New"
		elsif (school_year >= 1950 && school_year < 2000)
			"Old"
		else (school_year < 1950)
			"Old as hell"
		end
	end
end
