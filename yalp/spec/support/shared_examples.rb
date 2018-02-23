# RSPEC - SUPPORT - shared_examples.rb

shared_examples "sluggable" do
  # depends on an item type symbol
  let(:test_item) do
    Fabricate(item_type_sym, item_attr => "Test Item")
  end
    
  it "should set a slug on creation" do
    expect(test_item.slug).not_to be_nil
  end
  
  it "should have a properly formatted slug based on the name" do
    expect(test_item.slug).to eq("test-item")
  end
end

shared_examples "success_message" do
  it "sets flash[:success]" do
    expect(flash[:success]).not_to be_nil
  end
end

shared_examples "danger_message" do
  it "sets flash[:danger]" do
    expect(flash[:danger]).not_to be_nil
  end
end

shared_examples "root_redirect" do
  it "redirects to root_path" do
    expect(response).to redirect_to(root_path)
  end
end