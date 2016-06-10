FactoryGirl.define do
  factory :classroom, class: Classroom do
    name "DevPoint Labs"
    size 14

    trait :big do
    	size 51
    end

    trait :medium do
    	size 40
    end
    school
  end
end
