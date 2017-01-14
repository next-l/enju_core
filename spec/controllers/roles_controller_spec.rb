require 'rails_helper'

describe RolesController do
  fixtures :all

  describe 'GET index' do
    describe 'When logged in as Administrator' do
      login_fixture_admin

      it 'assigns all roles as @roles' do
        get :index
        expect(assigns(:roles)).to eq(Role.order(:position))
      end
    end

    describe 'When logged in as Librarian' do
      login_fixture_librarian

      it 'assigns all roles as @roles' do
        get :index
        expect(assigns(:roles)).to eq(Role.order(:position))
      end
    end

    describe 'When logged in as User' do
      login_fixture_user

      it 'assigns all roles as @roles' do
        get :index
        expect(assigns(:roles)).to be_nil
      end
    end

    describe 'When not logged in' do
      it 'assigns all roles as @roles' do
        get :index
        expect(assigns(:roles)).to be_nil
      end
    end
  end

  describe 'GET show' do
    describe 'When logged in as Administrator' do
      login_fixture_admin

      it 'assigns the requested role as @role' do
        role = Role.find(1)
        get :show, params: { id: role.id }
        expect(assigns(:role)).to eq(role)
      end
    end

    describe 'When not logged in' do
      it 'assigns the requested role as @role' do
        role = Role.find(1)
        get :show, params: { id: role.id }
        expect(assigns(:role)).to eq(role)
      end
    end
  end

  describe 'GET edit' do
    describe 'When logged in as Administrator' do
      login_fixture_admin

      it 'assigns the requested role as @role' do
        role = Role.find(1)
        get :edit, params: { id: role.id }
        expect(assigns(:role)).to eq(role)
      end
    end

    describe 'When not logged in' do
      it 'should not assign the requested role as @role' do
        role = Role.find(1)
        get :edit, params: { id: role.id }
        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end

  describe 'PUT update' do
    before(:each) do
      @role = Role.find(1)
      @attrs = { display_name: 'guest user' }
      @invalid_attrs = { name: '' }
    end

    describe 'When logged in as Administrator' do
      login_fixture_admin

      describe 'with valid params' do
        it 'updates the requested role' do
          put :update, params: { id: @role.id, role: @attrs }
        end

        it 'assigns the requested role as @role' do
          put :update, params: { id: @role.id, role: @attrs }
          expect(assigns(:role)).to eq(@role)
        end

        it 'moves its position when specified' do
          put :update, params: { id: @role.id, role: @attrs, move: 'lower' }
          expect(response).to redirect_to(roles_url)
        end
      end

      describe 'with invalid params' do
        it 'assigns the requested role as @role' do
          put :update, params: { id: @role.id, role: @invalid_attrs }
          expect(response).to render_template('edit')
        end
      end
    end

    describe 'When not logged in' do
      describe 'with valid params' do
        it 'updates the requested role' do
          put :update, params: { id: @role.id, role: @attrs }
        end

        it 'should be forbidden' do
          put :update, params: { id: @role.id, role: @attrs }
          expect(response).to redirect_to(new_user_session_url)
        end
      end

      describe 'with invalid params' do
        it 'assigns the requested role as @role' do
          put :update, params: { id: @role.id, role: @invalid_attrs }
          expect(response).to redirect_to(new_user_session_url)
        end
      end
    end
  end
end
