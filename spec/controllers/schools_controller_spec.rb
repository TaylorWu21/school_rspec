require 'rails_helper'

RSpec.describe SchoolsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'sets the school instance variable' do
      get :index
      expect(assigns(:schools)).to eq(Array.new)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'has schools in the schools instance variable' do
      3.times { |index| School.create(name: "school_#{index}", year: '10', mascot: 'turtle')}
      get :index
      expect(assigns(:schools).length).to eq(3)
      expect(assigns(:schools).first.name).to eq("school_0")
    end
  end

  describe "GET #show" do
    it "returns http success" do
      school = School.create(name: 'Taylorsville', mascot: 'Warriors', year: '1981')
      get :show, id: school.id
      expect(response).to have_http_status(:success)
    end

    it "renders the show template" do
      school = School.create(name: 'Taylorsville', mascot: 'Warriors', year: '1981')
      get :show, id: school.id
      expect(response).to render_template(:show)
    end

    it "sets the school instance variable" do
      school = School.create(name: 'Taylorsville', mascot: 'Warriors', year: '1981')
      get :show, id: school.id
      expect(assigns(:school).name).to eq(school.name)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      school = School.create(name: 'Taylorsville', mascot: 'Warriors', year: '1981')      
      get :edit, id: school.id
      expect(response).to have_http_status(:success)
    end

    it "render edit template" do
      school = School.create(name: 'Taylorsville', mascot: 'Warriors', year: '1981')
      get :edit, id: school.id
      expect(response).to render_template(:edit)
    end

    it "sets school instance variable" do
      school = School.create(name: 'Taylorsville', mascot: 'Warriors', year: '1981')
      get :edit, id: school.id
      expect(assigns(:school).id).to eq(school.id)
    end
  end

  describe "PUT #update" do
    it "sets the school instance variable" do
      school = School.create(name: 'Taylorsville', mascot: 'Warriors', year: '1981')
    end

    it "updates the school" do
      school = School.create(name: 'Taylorsville', mascot: 'Warriors', year: '1981')
      put :update, {id: school.id, school: {name: 'West High'}}
      expect(school.reload.name).to eq('West High')
    end

    it "redirects to the show in success" do
      school = School.create(name: 'Taylorsville', mascot: 'Warriors', year: '1981')
      put :update, {id: school.id, school: {name: 'West High'}}
    end

    it "renders the edit template on fail" do
      school = School.create(name: 'Taylorsville', mascot: 'Warriors', year: '1981')
      put :update, {id: school.id, school: {name: 'West High'}}
      expect(response).to redirect_to(school_path(school))
    end

    it "sets the flash on update" do
      school = School.create(name: 'Taylorsville', mascot: 'Warriors', year: '1981')
      put :update, {id: school.id, school: {name: 'West High'}}
      expect(flash[:success]).to eq("School updated.")
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'renders a new template' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'sets the school instance variable' do
      get :new
      expect(assigns(:school)).to_not eq(nil)
    end
  end

  describe "POST #create" do
    it 'sets the country instance variable' do
      school_params = { school:
                      { name: 'Taylorsville',
                        mascot: 'Warriors',
                        year: '1981'}
                      }
      post :create, school_params
      expect(assigns(:school)).to_not eq(nil)
      expect(assigns(:school).name).to eq(school_params[:school][:name])
    end

    it 'creates a new school' do
      school_params = { school:
                      { name: 'Taylorsville',
                        mascot: 'Warriors',
                        year: '1981'}
                      }
      expect(School.count).to eq(0)
      post :create, school_params
      expect(School.count).to eq(1)
      expect(School.first.name).to eq(school_params[:school][:name])
    end

    it 'redirects to the show page on success' do
      school_params = { school:
                      { name: 'Taylorsville',
                        mascot: 'Warriors',
                        year: '1981'}
                      }
      post :create, school_params
      expect(response).to redirect_to(school_path(School.first))
    end

    it 'renders new template on fail' do
      school_params = { school:
                      { name: '',
                        mascot: 'Warriors',
                        year: '1981'}
                      }
      post :create, school_params
      expect(School.count).to eq(0)
      expect(response).to render_template(:new)
    end

    it 'sets the flash success on successful create' do
      school_params = { school:
                      { name: 'Taylorsville',
                        mascot: 'Warriors',
                        year: '1981'}
                      }
      post :create, school_params
      expect(flash[:success]).to eq("School created.")
    end
  end

  describe "DELETE #destroy" do
    it 'sets the school instannce variable' do
      school = School.create(name: 'Taylorsville', mascot: 'Warriors', year: '1981')
      delete :destroy, id: school.id
      expect(assigns(:school)).to eq(school)
    end

    it 'destroys the country successfully' do
      school = School.create(name: 'Taylorsville', mascot: 'Warriors', year: '1981')
      expect(School.count).to eq(1)
      delete :destroy, id: school.id
      expect(School.count).to eq(0)
    end

    it 'sets the flash success message' do
      school = School.create(name: 'Taylorsville', mascot: 'Warriors', year: '1981')
      delete :destroy, id: school.id
      expect(flash[:success]).to eq("School deleted")
    end

    it 'redirects to the index path after deleting school' do
      school = School.create(name: 'Taylorsville', mascot: 'Warriors', year: '1981')
      delete :destroy, id: school.id
      expect(School.count).to eq(0)
      expect(response).to redirect_to(schools_path)
    end

  end

end
