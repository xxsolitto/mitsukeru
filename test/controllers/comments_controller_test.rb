require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get comments_create_url
    assert_response :success
  end

  test "should get comment_params" do
    get comments_comment_params_url
    assert_response :success
  end

end
