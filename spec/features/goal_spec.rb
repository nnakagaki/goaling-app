require 'spec_helper'
require 'rails_helper'

feature Goal do

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
  end

  feature "Make new goals" do

    it "remembers who made the goal" do
      expect(@jimbo_goal.author).to eq(@jimbo)
    end

    it "does not save an empty title" do
      expect(FactoryGirl.build(
        :goal, title: "", description: "factory")
      ).not_to be_valid
    end

    it "does not duplicate goals for same user" do
      expect(FactoryGirl.build(
        :goal, title: "jumbo", description: "factory")
      ).not_to be_valid
    end

    feature "Checking another user's goals" do
      before(:each) do
        click_button('Logout')
        visit(user_url(@jimbo))
      end

      it "defaults to public goal" do
        expect(page).to have_content('jumbo')
      end

      it "defaults to incomplete goal" do
        click_on('jumbo')
        expect(page).to have_content('incompleted')
      end

      it "does not display private goals to other users" do
        @jimbo_goal.update(public: false)

        visit(user_url(@jimbo))
        expect(page).to_not have_content('jumbo')
      end
    end

    feature "Checking your own goals" do
      before(:each) do
        visit(user_url(@jimbo))
      end

      it "displays private goals" do
        @jimbo_goal.update(public: false)

        visit(user_url(@jimbo))
        expect(page).to have_content('jumbo')
      end
    end
  end

  feature "Change a goal" do

    it "shows edit button to goal author and redirect to the correct page" do
      click_on('Edit')
      expect(current_url).to eq(edit_goal_url(@jimbo_goal))
    end

    it "does not show option to edit goal if you are not the goal's author" do
      click_on('Logout')
      visit user_goal_url(@jimbo, @jimbo_goal)
      expect(has_no_button?('Edit')).to eq(true)
    end

    it "should change the goal" do
      click_on('Edit')
      fill_in 'Title', with: "gigantic"
      fill_in 'Description', with: "cookie"
      click_on('Submit')

      expect(page).to have_content('gigantic')
      expect(page).to have_content('cookie')
    end
  end

  feature "Destroy a goal" do

    it "shows delete button to goal author and redirects to the correct page" do
      click_on('Delete')
      expect(current_url).to eq(user_url(@jimbo))
    end

    it "does not show option to delete goal if you are not the goal's author" do
      click_on('Logout')
      visit user_goal_url(@jimbo, @jimbo_goal)
      expect(has_no_button?('Delete')).to eq(true)
    end

    it "should remove the goal" do
      click_on('Delete')

      expect(page).to_not have_content('jumbo')
    end

  end

end