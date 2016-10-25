AfterStep do |_|
  sleep Testing.timeout
end

Before do
  @page = Page.new
end

After do |scenario|
  if Testing.browser
    if scenario.failed?
      screenshot = "report/screenshot-#{Time.new.to_i}.png"
      Testing.browser.screenshot.save screenshot
      embed screenshot, 'image/png'
    end
  else
    puts "Screenshot can't be created because browser isn't run"
  end
end
