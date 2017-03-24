module WelcomeHelper
  def func_post_cmt(userID,requestID,paraContent)
    #using post comment
    @newObject = Comment.new
    @newObject.user_id = userID
    @newObject.request_id = requestID
    @newObject.content = paraContent
    @newObject.save!
  end
end
