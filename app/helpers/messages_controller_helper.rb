module MessagesControllerHelper
  def isValidBrowser(headers)
    return headers["User-Agent"].include?("Chrome")
  end
  def isValidMessage(message)
    if message.length < 1 || message.length > 500
      return false
    end
    filterList = ['dicks are also what I eat', 'I love to eat dick', 'd i c k', 'soggy biscuit', '8=>', 'donger', 'bbc']
    return filterList.none?{|phrase| message.include?(phrase)}
  end
  def isValidHandle(handle)
    return handle.length > 1 && handle.length <= 20
  end
end