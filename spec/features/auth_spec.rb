require 'spec_helper'
require 'rails_helper'

feature User do
  before(:each) do
    visit new_user_url
    fill_in 'Username', with: "jimbo"
    fill_in 'Password', with: "biscuits"
    click_on "Create User"

    @jimbo = User.last

  end

  feature "the signup process" do

    it "has a new user page" do
      visit new_user_url
      expect(page).to have_content("Create New User")
    end

    feature "signing up a valid user" do

      it "shows username on the userpage after signup" do
        expect(page).to have_content(@jimbo.username)
        expect(current_url).to eq(user_url(@jimbo))
      end
    end

    feature "signing up an invalid user" do
      it "does not save an empty username" do
        expect(FactoryGirl.build(
          :user, username: "", password: "factory")
        ).not_to be_valid
      end

      it "does not duplicate usernames" do
        expect(FactoryGirl.build(
          :user, username: "jimbo", password: "factory")
        ).not_to be_valid
      end

      it "does not accept an empty password" do
        expect(FactoryGirl.build(
          :user, username: "test_user", password: "")
        ).not_to be_valid
      end

      it "does not accept a password smaller than 6 characters" do
        expect(FactoryGirl.build(
          :user, username: "FactoryGirl", password: "test")
        ).not_to be_valid
      end
    end
  end

  feature "logging in" do
    before(:each) do
      visit new_session_url
      fill_in 'Username', with: 'jimbo'
      fill_in 'Password', with: 'biscuits'
      click_on "Login"
    end

    it "shows username on the homepage (user index) after login" do
      expect(page).to have_content("Hi, #{@jimbo.username}")
      expect(current_url).to eq(users_url)
    end

  end

end

feature "logging out" do

  it "begins with logged out state" do
    visit root_url
    expect(page).to have_content("Login")
  end

  it "doesn't show username on the homepage after logout" do
    visit new_user_url
    fill_in 'Username', with: "jimbo"
    fill_in 'Password', with: "biscuits"
    click_on "Create User"

    click_on "Logout"
    expect(page).to_not have_content("Hi, jimbo")
  end

end
