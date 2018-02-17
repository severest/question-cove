require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  if !ENV['LOCAL_TESTING'].nil?
    driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
  else
    driven_by :selenium_chrome_headless
  end
end
