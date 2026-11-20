require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ]

  # Avoid Chrome 158's unsupported wildcard storage reset.
  Capybara::Selenium::Driver::ChromeDriver.prepend(Module.new do
    def reset!
      quit
    end
  end)
end
