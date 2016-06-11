class ClassroomsController < ApplicationController
	before_action :school
	before_action :classroom, except: [:index, :new, :create]

  def index
  	@classrooms = @school.classrooms.all

  end

  def show
  end

  def edit
  end

  def update
  	if @classroom.update(classroom_params)
  		redirect_to school_classroom_path(@school, @classroom)
  	else
  		render :edit
  	end
  end

  def new
  	@classroom = @school.classrooms.new
  end

  def create
  	@classroom = @school.classrooms.new(classroom_params)
  	if @classroom.save
  		redirect_to school_classroom_path(@school, @classroom)
  	else
  		render :new
  	end
  end

  def destroy
  	@classroom.destroy
  	redirect_to school_classrooms_path(@school)
  end

  private
  	def classroom_params
  		params.require(:classroom).permit(:name, :size)
  	end

  	def classroom
  		@classroom = @school.classrooms.find(params[:id])
  	end

  	def school
  		@school = School.find(params[:school_id])
  	end
end
