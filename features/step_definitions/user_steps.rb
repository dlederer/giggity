World(Rack::Test::Methods)

### UTILITY METHODS ###

def create_visitor
  @visitor ||= { :username => "Testy McUserton", :email => "example@example.com",
    :password => "changeme", :password_confirmation => "changeme" }
end

def find_user
  @user ||= User.where(:email => @visitor[:email]).first
end

def create_unconfirmed_user
  create_visitor
  delete_user
  sign_up
  sign_out
end

def create_user
  create_visitor
  delete_user
  @user = FactoryGirl.create(:user, @visitor)
end

def create_booker
  create_visitor
  delete_user
  @user = FactoryGirl.create(:booker, @visitor)
end

def create_performer
  create_visitor
  delete_user
  @user = FactoryGirl.create(:performer, @visitor)
end

def delete_user
  @user ||= User.where(:username => @visitor[:username]).first
  @user.destroy unless @user.nil?
end

def sign_up
  delete_user
  visit new_user_registration_path
  fill_in "user_username", :with => @visitor[:username]
  fill_in "user_email", :with => @visitor[:email]
  fill_in "user_password", :with => @visitor[:password]
  fill_in "user_password_confirmation", :with => @visitor[:password_confirmation]
  click_button "Sign up"
  find_user
end

def sign_in
  visit new_user_session_path
  fill_in "user_username", :with => @visitor[:username]
  fill_in "user_password", :with => @visitor[:password]
  click_button "Sign in"
end

def sign_out
  Capybara.current_session.driver.delete destroy_user_session_path
end

### GIVEN ###
Given /^I am not logged in$/ do
  sign_out
end

Given /^I am logged in$/ do
  create_performer
  sign_in
end

Given /^I exist as a user$/ do
  create_user
end

Given /^I do not exist as a user$/ do
  create_visitor
  delete_user
end

Given /^I exist as an unconfirmed user$/ do
  create_unconfirmed_user
end

### WHEN ###
When /^I sign in with valid credentials$/ do
  create_visitor
  sign_in
end

When /^I sign out$/ do
  sign_out
end

When /^I sign up with valid user data$/ do
  create_visitor
  sign_up
end

When /^I sign up with an invalid username$/ do
  create_visitor
  delete_user
  @user = FactoryGirl.create(:user, @visitor)
  create_visitor
  sign_up
end

When /^I sign up without a password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "")
  sign_up
end

When /^I sign up without a password$/ do
  create_visitor
  @visitor = @visitor.merge(:password => "")
  sign_up
end

When /^I sign up with a mismatched password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "changeme123")
  sign_up
end

When /^I return to the site$/ do
  visit '/'
end

When /^I sign in with a wrong username$/ do
  @visitor = @visitor.merge(:username => "wronguser")
  sign_in
end

When /^I sign in with a wrong password$/ do
  @visitor = @visitor.merge(:password => "wrongpass")
  sign_in
end

When /^I edit my account details$/ do
  
  all("Update Profile")[0].click
  fill_in "user_email", :with => "newname@example.com"
  click_button "Update profile"
end

When /^I look at the list of users$/ do
  visit '/'
end

### THEN ###
Then /^I should be signed in$/ do
  page.should have_content "Logout"
  page.should_not have_content "Sign up"
  page.should_not have_content "Login"
end

Then /^I should be signed out$/ do
  page.should have_content "Sign up"
  page.should have_content "Sign in"
  page.should_not have_content "Logout"
end

Then /^I see an unconfirmed account message$/ do
  page.should have_content "You have to confirm your account before continuing."
end

Then /^I see a successful sign in message$/ do
  page.should have_content "Signed in successfully."
end

Then /^I should see a successful sign up message$/ do
  page.should have_content "Welcome! You have signed up successfully."
end

Then /^I should see a required confirmation message$/ do
  page.should have_content "A message with a confirmation link has been sent to your email address."
end


Then /^I should see an invalid username message$/ do
  page.should have_content "Username is invalid"
end

Then /^I should see a missing password message$/ do
  page.should have_content "Password can't be blank"
end

Then /^I should see a missing password confirmation message$/ do
  page.should have_content "Password doesn't match confirmation"
end

Then /^I should see a mismatched password message$/ do
  page.should have_content "Password doesn't match confirmation"
end

Then /^I should see a signed out message$/ do
  page.should have_content "Signed out successfully."
end

Then /^I see an invalid login message$/ do
  page.should have_content "Invalid username or password."
end

Then /^I should see an account edited message$/ do
  page.should have_content "You updated your account successfully."
end

Then /^I should see my name$/ do
  create_user
  page.should have_content @user[:display_name]
end
