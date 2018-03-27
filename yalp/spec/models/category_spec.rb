# RSPEC - MODELS - category_spec.rb

require "rails_helper"

describe Category do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to have_many(:businesses) }
  
  it_behaves_like "sluggable" do
    let(:item_type_sym) { :category }
    let(:item_attr) { :name }
  end
end
