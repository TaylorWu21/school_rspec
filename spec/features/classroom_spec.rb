require 'rails_helper'

feature 'School index', js: true do
	before(:each) do
		@school = 'DevPoint Labs'
		@year = 2013
		@mascot = 'Brogrammer'
		visit new_school_path
		fill_in('school[name]', with: @school)
		fill_in('school[year]', with: @year)
		fill_in('school[mascot]', with: @mascot)
		find('.submit-school-btn').click
		find('.classrooms-btn').click
	end

	context 'without classrooms' do

		scenario 'no classroom header' do
			expect(find('.no-classrooms-header')).to_not eq(nil)
		end

		scenario 'click new classroom' do
			find('.new-classroom-btn').click
			expect(find('#new-classroom-header').text).to eq("Creating a Class")
		end

		scenario 'creating a new classroom and backing out' do
			find('.new-classroom-btn').click
			fill_in('classroom[name]', with: 'test')
			find('.cancel-classroom-btn').click
			expect(find('#classrooms-header')).to_not eq(nil)
		end

	end

	context 'with classrooms' do
		before(:each) do
			@classroom = 'Summer 2016'
			@size = '14'
			@new_classroom = 'Spring 2016'
			find('.new-classroom-btn').click
			fill_in('classroom[name]', with: @classroom)
			fill_in('classroom[size]', with: @size)
			find('.submit-classroom-btn').click
		end

		scenario 'display classroom' do
			expect(find('.show-classroom-header').text).to eq("Class: #{@classroom}")
		end

		scenario 'edit and cancel' do
			find('.edit-classroom-btn').click
			fill_in('classroom[name]', with: @new_classroom)
			find('.cancel-classroom-btn').click
			expect(find('.show-classroom-header').text).to eq("Class: #{@classroom}")
		end

		scenario 'edit classroom' do
			find('.edit-classroom-btn').click
			fill_in('classroom[name]', with: @new_classroom)
			find('.submit-classroom-btn').click
			expect(find('.show-classroom-header').text).to eq("Class: #{@new_classroom}")
		end

		scenario 'delete classroom' do
			find('.delete-classroom-btn').click
			expect(find('.no-classrooms-header')).to_not eq(nil)
		end

		scenario 'go back to classroom index' do
			find('.back-to-classrooms-btn').click
			expect('#classrooms-header').to_not eq(nil)
		end
	end
end