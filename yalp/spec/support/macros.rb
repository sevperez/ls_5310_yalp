# RSPEC - SUPPORT - macros.rb

def set_test_user
  test_user = Fabricate(:user)
  session[:user_id] = test_user.id
end

def test_user
  User.find(session[:user_id])
end

def clear_test_user
  session[:user_id] = nil
end

def feature_sign_in_user(email, password)
  visit root_path
  click_link "Sign In"
  
  within("#sign_in_form") do
    fill_in "Email", with: email
    fill_in "Password", with: password
  end
  
  click_button "Submit"
end