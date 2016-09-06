Given(/^I go to github site$/) do
  @page.visit 'https://github.com/'
  @page = HomePage.new
end

When(/^I fill keyword "([^"]+)" in quick search field$/) do |keyword|
  @page = @page.fill_keyword(keyword)
end

When(/^I search in "([^"]+)"$/) do |type|
  @page = @page.search_in(type.capitalize)
end

When(/^I navigate to (.+) page in paging$/) do |number|
  @page = @page.go_to_page(number)
end

When(/^I click on (\d+(?:st|nd|rd|th)|last) (repository|code|issue|user) link$/) do |number, type|
  number = number == 'last' ? -1 : number.to_i - 1
  case type
  when 'repository'
    @content = @page.result_items[number][:name]
    @page = @page.open_repository(number)
  when 'code'
    @content = @page.result_items[number][:code]
    @page = @page.open_code(number)
  when 'issue'
    @content = @page.result_items[number][:title]
    @page = @page.open_issue(number)
  when 'user'
    @content = @page.result_items[number][:login]
    @page = @page.open_user(number)
  end
end

Then(/^I should see "([^"]+)" text$/) do |text|
  expect(@page.body).to include(text)
end

Then(/^I should be on "([^"]+)" form$/) do |title|
  expect(@page.title).to eq(title)
end

Then(/^I should see "([^"]+)" in all results$/) do |keyword|
  expect(@page.result_items).to include_keyword(keyword)
end

Then(/^I should see (\d+) search results on page$/) do |number|
  expect(@page.result_array).to have(number).items
end

Then(/^"([^"]+)" item should be (disabled|enabled) in paging$/) do |item, state|
  method = "navigation_to_#{item}_page_enabled?"
  expect(@page.send(method)).to eq(state == 'disabled' ? false : true)
end

Then(/^current page in paging should be "(\d+)"$/) do |number|
  expect(@page.current_item_in_paging).to eq(number)
end

Then(/^I should see (\d+) paging items$/) do |number|
  expect(@page.last_item_in_paging).to eq(number)
end

Then(/^(?:repository|code|issue|user) should correspond with search result$/) do
  expect(@page.content).to eq(@content)
end
