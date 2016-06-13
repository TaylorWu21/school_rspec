class SchoolsController < ApplicationController
	before_action :school, except: [:index, :new, :create]

  def index
  	@schools = School.all.paginate(:page => params[:page], :per_page => 6)

  end

  def show
  end

  def edit
  end

  def update
  	if @school.update(school_params)
  		flash[:success] = "School updated."
  		redirect_to school_path(@school)
  	else
  		render :edit
  	end
  end

  def new
    @school = School.new
  end

  def create
  	@school = School.new(school_params)
  	if @school.save
  		flash[:success] = "School created."
  		redirect_to school_path(@school)
  	else
  		render :new
  	end
  end

  def destroy
  	@school.destroy
  	flash[:success] = "School deleted"
  	redirect_to schools_path
  end

  private
  	def school_params
  		params.require(:school).permit(:name, :mascot, :year)
  	end

  	def school
  		@school = School.find(params[:id])
  	end
end
