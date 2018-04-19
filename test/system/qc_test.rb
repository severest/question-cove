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
    find('.select2-input').send_keys("tag with spaces")
    find('.select2-result').click
    click_on 'Create Question'

    assert_selector "h1", text: "This is a question"
    assert_selector ".label", text: "tag with spaces"

    fill_in 'Comment...', with: 'a comment!'
    click_on(class: 'js-test-comment')

    find('.showdown-edit').set('My answer bro')
    click_on 'Create Answer'

    find('.js-test-edit-question').click
    find('.showdown-edit').set("# I changed it")
    find('.select2-input').send_keys("new tag")
    find('.select2-result').click
    click_on 'Update Question'

    assert_selector "h1", text: "I changed it"
    assert_selector ".label", text: "new tag"
  end
end
