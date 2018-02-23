# RSPEC - MODELS - category_spec.rb

require "rails_helper"

describe Category do
  context "ActiveRecord" do
    it { should validate_presence_of(:name) }
  end
  
  # slugging
  it_behaves_like "sluggable" do
    let(:item_type_sym) { :category }
    let(:item_attr) { :name }
  end
end
