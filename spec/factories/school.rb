FactoryGirl.define do
	factory :school, class: School do
		name 'Taylorsville'
		year '1981'
		mascot 'Warriors'

		trait :new do
			year '2005'
		end

		trait :old_as_hell do
			year '1930'
		end
	end
end