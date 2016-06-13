require 'rails_helper'

RSpec.describe ClassroomsController, type: :controller do
  let(:school) { FactoryGirl.create(:school) }
  let(:classroom) { FactoryGirl.create(:classroom, school_id: school.id) }
  let(:classroom2) { FactoryGirl.create(:classroom, school_id: school.id) }

  describe "GET #index" do
    before(:each) do
      get :index, school_id: school.id
    end
      
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'sets the classrooms instance variable' do
      expect(assigns(:classrooms)).to eq([])
    end

    it 'returns the index template' do
      expect(response).to render_template(:index)
    end

    it 'returns all the classroom for a school' do
      school
      classroom
      classroom2
      expect(assigns(:classrooms).count).to eq(2)
      expect(assigns(:classrooms).last.name).to eq(classroom2.name)
    end

  end

  describe "GET #show" do
    before(:each) do
      get :show, school_id: school.id, id: classroom.id
    end
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end

    it 'sets the classroom instance variable' do
      expect(assigns(:classroom)).to eq(classroom)
    end
  end

  describe "GET #edit" do
    before(:each) do
      get :edit, school_id: school.id, id: classroom.id
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'renders edit template' do
      expect(response).to render_template(:edit)
    end

    it 'sets the classroom variable' do
      expect(assigns(:classroom)).to eq(classroom)
    end

    it 'finds the right school' do
      expect(assigns(:school)).to eq(school)
    end
  end

  describe "PUT #update" do
    before(:each) do
      @classroom_params = { school_id: school.id, id: classroom.id, classroom: { name: 'updated class' } }
      put :update, @classroom_params
    end

    it 'returns http success' do
      expect(response).to have_http_status(302)
    end

    it 'sets the classroom instance variable' do
      expect(assigns(:classroom)).to eq(classroom)
    end

    it 'updates the classroom' do
      expect(classroom.reload.name).to eq(@classroom_params[:classroom][:name])
    end

    it 'flashes success message after update' do
      expect(flash[:success]).to eq("Classroom has been updated!")
    end

    it 'redirect to show page on success' do
      expect(response).to redirect_to(school_classroom_path(assigns(:school), assigns(:classroom)))
    end

    it 'renders edit on fail' do
      @bad_params = { school_id: school.id, id: classroom.id, classroom: { name: '' } }
      put :update, @bad_params
      expect(response).to render_template(:edit)
    end
  end

  describe "GET #new" do
    before(:each) do
      get :new, school_id: school.id
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'sets the classroom instance variable' do
      expect(assigns(:classroom).school_id).to eq(assigns(:school).id)
    end

    it 'renders new template' do
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    before(:each) do
     @classroom_params = { school_id: school.id, id: classroom.id, classroom: { name: 'new class' } }
      post :create, @classroom_params
    end

    it 'returns http success' do
      expect(response).to have_http_status(302)
    end

    it 'creates a new classroom' do
      expect(Classroom.last.name).to eq(@classroom_params[:classroom][:name])
    end

    it 'flashes success message after create' do
      expect(flash[:success]).to eq("Classroom has been created!")
    end

    it 'redirects to show page on success' do
      expect(response).to redirect_to(school_classroom_path(assigns(:school), assigns(:classroom)))
    end

    it 'renders new template on fail' do
      @bad_params = { school_id: school.id, id: classroom.id, classroom: { name: '' } }
      post :create, @bad_params
      expect(response).to render_template(:new)
    end
  end

  describe "#DELETE #destroy" do
    before(:each) do
      delete :destroy, { school_id: school.id, id: classroom.id }
    end

    it 'returns http success' do
      expect(response).to have_http_status(302)
    end

    it 'sets the classroom variable' do
      expect(assigns(:classroom)).to eq(classroom)
    end

    it 'deletes the school' do
      expect(Classroom.count).to eq(0)
    end

    it 'flashes success message after classroom deletes' do
      expect(flash[:success]).to eq("Classroom has been dropped")
    end

    it 'redirects to classroom index' do
      expect(response).to redirect_to(school_classrooms_path(assigns(:school)))
    end
  end
end
