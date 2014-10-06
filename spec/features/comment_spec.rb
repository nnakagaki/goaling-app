require 'spec_helper'
require 'rails_helper'

feature "Comment" do

  before(:each) do
    visit new_user_url
    fill_in 'Username', with: "jimbo"
    fill_in 'Password', with: "biscuits"
    click_on "Create User"

    @jimbo = User.last

    fill_in 'Title', with: "jumbo"
    fill_in 'Description', with: "biscuits"
    click_on "Create Goal"
    @jimbo_goal = Goal.last

    click_on('Logout')

    visit new_user_url
    fill_in 'Username', with: "bobby"
    fill_in 'Password', with: "tables"
    click_on "Create User"

    @bobby = User.last

    visit user_goal_url(@jimbo, @jimbo_goal)

    fill_in 'Comment', with: "biscuits are great!"
    click_on "Post Comment"
    @bobby_comment = GoalComment.last
  end

  feature "Comment on goal" do
    it "redirects back to goal page" do
      expect(current_url).to eq(user_goal_url(@jimbo, @jimbo_goal))
    end

    it "adds comments to the goal" do
      expect(page).to have_content("biscuits are great!")
    end

    it "diplays who made the comment" do
      expect(page).to have_content("bobby says:")
    end

    it "reject empty comments" do
      expect(FactoryGirl.build(:goal_comment, body: "")).not_to be_valid
    end

    it "cannot comment unless signed in" do
      click_on('Logout')
      visit user_goal_url(@jimbo, @jimbo_goal)

      expect(has_no_button?('Post Comment')).to eq(true)
    end
  end

  feature "Comment on user" do
    before(:each) do
      visit user_url(@jimbo)
      fill_in 'Comment', with: "Jimbo you suck!"
      click_on "Post Comment"
      @bobby_user_comment = UserComment.last
    end
    it "redirects back to user page" do
      expect(current_url).to eq(user_url(@jimbo))
    end

    it "adds comments to the user" do
      expect(page).to have_content("Jimbo you suck!")
    end

    it "diplays who made the comment" do
      expect(page).to have_content("bobby says:")
    end

    it "reject empty comments" do
      expect(FactoryGirl.build(:user_comment, body: "")).not_to be_valid
    end

    it "cannot comment unless signed in" do
      click_on('Logout')
      visit user_url(@jimbo)

      expect(has_no_button?('Post Comment')).to eq(true)
    end
  end


end