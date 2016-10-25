class Page
  include Watirsome
  include Container

  body :body
  h1 :title
  text_field :quick_search, name: 'q'

  def initialize
    super(browser)
  end

  def body
    body_body.text
  end

  def visit(url)
    browser.goto url
  end

  def fill_keyword(keyword)
    self.quick_search = keyword, :enter
    SearchPage.new
  end

  private

  def browser
    Testing.browser
  end
end
