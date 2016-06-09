require 'rails_helper'

RSpec.describe SchoolsController, type: :controller do

  describe "GET #index" do

    before(:each) do
      get :index
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'sets the school instance variable' do
      expect(assigns(:schools)).to eq(Array.new)
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end

    it 'has schools in the schools instance variable' do
      3.times { |index| School.create(name: "school_#{index}", year: '10', mascot: 'turtle')}
      expect(assigns(:schools).length).to eq(3)
      expect(assigns(:schools).first.name).to eq("school_0")
    end
  end

  describe "GET #show" do

    let(:school) { FactoryGirl.create(:school) }

    before(:each) do
      get :show, id: school.id
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders the show template" do
      expect(response).to render_template(:show)
    end

    it "sets the school instance variable" do
      expect(assigns(:school).name).to eq(school.name)
    end
  end

  describe "GET #edit" do

    let(:school) { FactoryGirl.create(:school) }

    before(:each) do
      get :edit, id: school.id
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "render edit template" do
      expect(response).to render_template(:edit)
    end

    it "sets school instance variable" do
      expect(assigns(:school).id).to eq(school.id)
    end
  end

  describe "PUT #update" do

    let(:school) { FactoryGirl.create(:school) }

    before(:each) do
      put :update, {id: school.id, school: {name: 'West High'}}
    end

    it "sets the school instance variable" do
      expect(assigns(:school)).to_not eq(nil)
      expect(assigns(:school)).to eq(school)
    end

    it "updates the school" do
      expect(school.reload.name).to eq('West High')
    end

    it "redirects to the show in success" do
      expect(response).to redirect_to(school_path(school))
    end

    it "renders the edit template on fail" do
      put :update, {id: school.id, school: {name: ''} }
      expect(response).to render_template(:edit)
    end

    it "sets the flash on update" do
      expect(flash[:success]).to eq("School updated.")
    end
  end

  describe "GET #new" do

    before(:each) do
      get :new
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'renders a new template' do
      expect(response).to render_template(:new)
    end

    it 'sets the school instance variable' do
      expect(assigns(:school)).to_not eq(nil)
    end
  end

  describe "POST #create" do

    before(:each) do
      @school_params = {
        school: FactoryGirl.attributes_for(:school)
      }
      post :create, @school_params
    end

    it 'sets the school instance variable' do
      expect(assigns(:school)).to_not be_nil
      expect(assigns(:school).name).to eq(@school_params[:school][:name])
    end

    it 'creates a new school' do
      expect(School.count).to eq(1)
      expect(School.first.name).to eq(@school_params[:school][:name])
    end

    it 'redirects to the show page on success' do
      expect(response).to redirect_to(school_path(School.first))
    end

    it 'renders new template on fail' do
      expect(School.count).to eq(1)
      post :create, {school: {name: nil} }
      expect(School.count).to eq(1)
      expect(response).to render_template(:new)
    end

    it 'sets the flash success on successful create' do
      expect(flash[:success]).to eq("School created.")
    end
  end

  describe "DELETE #destroy" do

    let(:school) { FactoryGirl.create(:school) }

    before(:each) do
      delete :destroy, id: school.id
    end
    it 'sets the school instannce variable' do
      expect(assigns(:school)).to eq(school)
    end

    it 'destroys the school successfully' do
      expect(School.count).to eq(0)
    end

    it 'sets the flash success message' do
      expect(flash[:success]).to eq("School deleted")
    end

    it 'redirects to the index path after deleting school' do
      expect(School.count).to eq(0)
      expect(response).to redirect_to(schools_path)
    end
  end
end
