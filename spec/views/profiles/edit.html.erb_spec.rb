require 'spec_helper'

describe 'profiles/edit' do
  fixtures :all

  before(:each) do
    @profile = assign(:profile, profiles(:admin))
    assign(:user_groups, UserGroup.all)
    assign(:libraries, Library.all)
    assign(:roles, Role.all)
    assign(:available_languages, Language.available_languages)
    view.stub(:current_user).and_return(User.friendly.find('enjuadmin'))
  end

  describe 'when logged in as librarian' do
    before(:each) do
      @profile = assign(:profile, profiles(:librarian2))
      user = users(:librarian1)
      view.stub(:current_user).and_return(user)
    end

    it 'renders the edit user form' do
      allow(view).to receive(:policy).and_return double(destroy?: true)
      render
      assert_select 'form', action: profiles_path(@profile), method: 'post' do
        assert_select 'input#profile_user_number', name: 'profile[user_number]'
      end
    end

    it "should not display 'delete' link" do
      allow(view).to receive(:policy).and_return double(destroy?: false)
      render
      expect(rendered).not_to have_selector("a[href='#{profile_path(@profile.id)}'][data-method='delete']")
    end

    it 'should disable role selection' do
      allow(view).to receive(:policy).and_return double(destroy?: true)
      render
      expect(rendered).to have_selector("select#profile_user_attributes_user_has_role_attributes_role_id[disabled='disabled']")
    end
  end
end
