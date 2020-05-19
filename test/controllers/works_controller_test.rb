require "test_helper"

describe WorksController do
  it "must get home" do
    get works_home_url
    must_respond_with :success
  end

end
