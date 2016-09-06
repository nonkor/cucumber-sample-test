class SearchPage < Page

  #silence_warnings { ATTRIBUTES = %i[name desc code title login user_name] }
  ATTRIBUTES = %i[name desc code title login user_name]

  h3 :result_count
  nav :search_type, class: 'menu'
  a :current_type, -> { search_type_nav.a(class: 'selected') }
  div :results, class: 'codesearch-results'
  div :pagination, class: 'pagination'

  module Repositories
    include Watirsome
    include Container

    lis :result_array, class: 'repo-list-item'
    container_for :result_array_lis do |item|
      description_element = item.p(class: 'repo-list-description')
      {
        name: item.h3(class: 'repo-list-name').text,
        desc: description_element.present? ? description_element.text : '',
        link: item.h3(class: 'repo-list-name').a
      }
    end
  end

  module Code
    include Watirsome
    include Container

    divs :result_array, class: 'code-list-item'
    container_for :result_array_divs do |item|
      {
        code: item.td(class: 'blob-code').text,
        link: item.td(class: 'blob-num').a
      }
    end
  end

  module Issues
    include Watirsome
    include Container

    divs :result_array, class: 'issue-list-item'
    container_for :result_array_divs do |item|
      {
        title: item.p(class: 'title').text,
        desc: item.p(class: 'description').text,
        link: item.p(class: 'title').a
      }
    end
  end

  module Users
    include Watirsome
    include Container

    divs :result_array, class: 'user-list-info'
    container_for :result_array_divs do |item|
      user = Nokogiri::HTML(item.html).at_css(:a).next
      user = user.next if user.next.name == 'em'
      login = item.as.first
      {
        login: login.text,
        user_name: user.text.strip,
        link: login
      }
    end
  end

  def initialize_page
    results_div.when_present.wait_until_dom_changed

    case current_type
    when /Repositories/
      extend Repositories
    when /Code/
      extend Code
    when /Issues/
      extend Issues
    when /Users/
      extend Users
    else
      fail "Unknown type of search page: #{current_type}"
    end
  end

  def current_type
    current_type_a.text
  end

  def search_in(type)
    search_type_nav.a(text: /#{type}/).click
    SearchPage.new
  end

  def go_to_page(number)
    paging_item(number.capitalize).click
    SearchPage.new
  end

  def current_item_in_paging
    pagination_div.em(class: 'current').text
  end

  def last_item_in_paging
    last_item.text
  end

  def navigation_to_previous_page_enabled?
    paging_item('Previous').present?
  end

  def navigation_to_next_page_enabled?
    paging_item('Next').present?
  end

  def result_items
    result_array.map do |item|
      item.select { |k,_| ATTRIBUTES.include?(k) }
    end
  end

  def open_repository(number)
    open_content_by_index(number)
    RepositoryPage.new
  end

  def open_code(number)
    open_content_by_index(number)
    CodePage.new
  end

  def open_issue(number)
    open_content_by_index(number)
    IssuePage.new
  end

  def open_user(number)
    open_content_by_index(number)
    UserPage.new
  end

  private

  def paging_item(text)
    text == 'Last' ? last_item : pagination_div.a(text: text)
  end

  def last_item
    pagination_div.as(class: /^(?!next_page)/)[-1]
  end

  def open_content_by_index(number)
    result_array[number][:link].click
  end

end
