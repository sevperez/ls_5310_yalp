# RSPEC - MODELS - user_spec.rb

require "rails_helper"

describe User do
  context "ActiveRecord" do
    it { should validate_presence_of(:full_name).with_message("Full name is required.") }
    it { should validate_presence_of(:email).with_message("A valid email is required.") }
    it { should validate_uniqueness_of(:email).with_message("Sorry, that email is unavailable.") }
    it { should validate_length_of(:motto).with_message("Motto must be less than 250 characters.") }
    it { should have_secure_password }
    it { should have_many(:businesses) }
    it { should have_many(:reviews) }
    it { should have_many(:reviewed_businesses) }
  end
  
  # slugging
  it_behaves_like "sluggable" do
    let(:item_type_sym) { :user }
    let(:item_attr) { :full_name }
  end
end