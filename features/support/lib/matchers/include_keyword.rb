RSpec::Matchers.define :include_keyword do |keyword|
  match do |items|
    @not_found = items.select do |item|
      !item.find { |_, value| value.downcase.include? keyword.downcase }
    end
    @not_found.empty?
  end

  failure_message do |_items|
    <<-EOS
      Expected all search results to include keyword "#{keyword}" in title/description/code
      But next items do not have this keyword:
        #{@not_found}
    EOS
  end
end
