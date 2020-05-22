require "test_helper"

describe UsersController do
  it "must get index" do
    get user_index_url
    must_respond_with :success
  end

  it "must get show" do
    get user_show_url
    must_respond_with :success
  end

end
