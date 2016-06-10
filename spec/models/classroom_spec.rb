require 'rails_helper'

RSpec.describe Classroom, type: :model do
	let(:classroom) { FactoryGirl.create(:classroom) }
	let(:big_classroom) { FactoryGirl.create(:classroom, :big) }
	let(:medium_classroom) { FactoryGirl.create(:classroom, :medium) }

	describe 'validations' do
		it { should validate_presence_of :name }
		it { should respond_to :name }
		it { should respond_to :size }
		it { should respond_to :school_id }
		it { should belong_to :school}
	end

	describe '#classroom_name' do
		it 'returns the classroom name and the message' do
			expect(classroom.name).to eq(Classroom.first.name)
		end
	end

	describe '#classroom_size' do
		it 'returns big if class >= 50' do
			expect(big_classroom.classroom_size).to eq("Big class")
		end

		it 'returns medium if class > 50' do
			expect(medium_classroom.classroom_size).to eq("Medium class")
		end

		it 'returns small if class > 25' do
			expect(classroom.classroom_size).to eq("Small class")
		end
	end
end
