class UserPage < Page
  element :content, class: 'vcard-username'

  def content
    content_element.text
  end
end
