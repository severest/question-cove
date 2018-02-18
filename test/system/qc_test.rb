require "application_system_test_case"

class QuestionCoveTest < ApplicationSystemTestCase
  def teardown
    errors = page.driver.browser.manage.logs.get(:browser)
    if errors.present?
      message = errors.map(&:message).join("\n")
      puts message
    end
    assert !errors.present?
  end

  test "visiting the index" do
    visit '/auth/google'

    fill_in "Search for...", with: "a test"
    click_on(class: 'js-test-search')

    click_on 'New Question'
    find('.showdown-edit').set("# This is a question\n\nHowdy ho")
    click_on 'Create Question'

    fill_in 'Comment...', with: 'a comment!'
    click_on(class: 'js-test-comment')

    find('.showdown-edit').set('My answer bro')
    click_on 'Create Answer'
  end
end
