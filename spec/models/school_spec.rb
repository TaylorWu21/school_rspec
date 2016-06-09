require 'rails_helper'

RSpec.describe School, type: :model do
	describe 'validations' do
  	it { should validate_presence_of :name }
  	it { should validate_presence_of :mascot }
  	it { should validate_presence_of :year }
	end

	describe '#school_name' do
		it 'returns the name of the school' do
			school = School.create(name: 'Taylorsville', mascot: 'Warriors', year: '1981')
			expect(school.name).to eq(School.first.name)
		end

		it 'should return the mascot of the school' do
			school = School.create(name: 'Taylorsville', mascot: 'Warriors', year: '1981')
			expect(school.mascot).to eq(School.first.mascot)
		end
	end

	describe '#school_year' do
		it 'returns new if school year is > 2000' do
			school = School.create(name: 'Taylorsville', mascot: 'Warriors', year: '2010')
			expect(school.year_built).to eq("New")
		end

		it 'returns old if school year is >= 1950' do
			school = School.create(name: 'Taylorsville', mascot: 'Warriors', year: '1981')
			expect(school.year_built).to eq("Old")
		end

		it 'returns old as hell if school year is < 1950' do
			school = School.create(name: 'Taylorsville', mascot: 'Warriors', year: '1930')
			expect(school.year_built).to eq("Old as hell")
		end
	end
end
