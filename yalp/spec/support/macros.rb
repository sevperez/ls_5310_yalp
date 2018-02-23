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
