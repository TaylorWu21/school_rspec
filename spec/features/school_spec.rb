require 'rails_helper'

feature 'School index', js: true do
	context 'no school' do
		before(:each) do
			visit root_path
		end

		scenario 'validate header' do
			expect(find('#school-header').text).to eq('Schoolio')
		end

		scenario 'correct message if no school' do
			expect(find('#no-school-header').text).to eq('No schools, please add one.')
		end

		scenario 'create a school' do
			find('.new-school-btn').click
			expect(find('#new-school-header').text).to eq('Creating a New School')
		end

		scenario 'fill out new school form and back out' do
			visit new_school_path
			fill_in('school[name]', with: 'New School')
			find('.cancel-school-btn').click
			expect(find('#school-header')).to_not eq(nil)
			expect(first('.card-title')).to eq(nil)
		end

	end

	context 'with school' do
		before(:each) do
			@school = 'DevPoint Labs'
			@year = 2013
			@mascot = 'Brogrammer'
			@new_name = 'DPL'
			visit new_school_path
			fill_in('school[name]', with: @school)
			fill_in('school[year]', with: @year)
			fill_in('school[mascot]', with: @mascot)
			find('.submit-school-btn').click
		end

		scenario 'go to the index and see the school' do
			visit root_path
			expect(find('.card-title').text).to eq(@school)
		end

		scenario 'click the card link' do
			visit root_path
			first('.view-school-btn').click
			expect(find('.show-school-header')).to_not eq(nil)
		end

		scenario 'show the right info' do
			expect(find('.show-school-header').text).to eq("Displaying: #{@school} Home of the #{@mascot}!")
		end

		scenario 'back to index' do
			first('.back-to-schools-btn').click
			expect(find('#school-header').text).to eq('Schoolio')
		end

		scenario 'edit school' do
			find('.edit-school-btn').click
			fill_in('school[name]', with: @new_name)
			find('.submit-school-btn').click
			expect(find('.school-info-header').text).to eq("#{@new_name} was founded in #{@year}")
		end

		scenario 'edit and cancel edit' do
			find('.edit-school-btn').click
			fill_in('school[name]', with: @new_name)
			find('.cancel-school-btn').click
			expect(find('.show-school-header').text).to eq("Displaying: #{@school} Home of the #{@mascot}!")
		end

		scenario 'delete the school' do
			find('.delete-school-btn').click
			expect(find('#school-header').text).to eq('Schoolio')
		end

		scenario "view the school's classrooms" do
			find('.classrooms-btn').click
			expect(find('#classrooms-header').text).to_not eq(nil)
		end
	end
end