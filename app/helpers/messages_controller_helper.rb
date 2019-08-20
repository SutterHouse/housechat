module MessagesControllerHelper
  def isValidBrowser(headers)
    user_agent = headers["User-Agent"]
    return user_agent.include?("Mozilla") || user_agent.include?("Chrome") || user_agent.include?("iPhone")
  end
  def isValidMessage(message)
    if message.length < 1 || message.length > 500
      return false
    end
    return true
  end
  def isValidHandle(handle)
    return handle.length > 1 && handle.length <= 20
  end
end