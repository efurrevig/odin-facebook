require "test_helper"

class LikesControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

    setup do 
      @user1 = users(:two)
      @post = posts(:one)
      @post2 = posts(:two)
      @like2 = likes(:two)
      @like3 = likes(:three)
      #comment likes
      @like4 = likes(:four)
      @like5 = likes(:five)

      @comment = comments(:one)
      @comment2 = comments(:two)
      sign_in @user1
    end


end
