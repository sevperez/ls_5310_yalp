# RSPEC - MODELS - user_spec.rb

require "rails_helper"

describe User do
  it { is_expected.to validate_presence_of(:full_name).with_message("Full name is required.") }
  it { is_expected.to validate_presence_of(:email).with_message("A valid email is required.") }
  it { is_expected.to validate_uniqueness_of(:email).with_message("Sorry, that email is unavailable.") }
  it { is_expected.to validate_length_of(:motto).with_message("Motto must be less than 250 characters.") }
  it { is_expected.to have_secure_password }
  it { is_expected.to have_many(:businesses) }
  it { is_expected.to have_many(:reviews) }
  it { is_expected.to have_many(:reviewed_businesses) }
  
  it_behaves_like "sluggable" do
    let(:item_type_sym) { :user }
    let(:item_attr) { :full_name }
  end
end