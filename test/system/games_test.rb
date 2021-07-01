require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit '/new'
    assert test: "New game"
    assert_selector ".letter", count: 10
  end

  test "get a message that the word is not in the grid." do
    visit '/new'
    fill_in "word", with: "cat"
    click_on 'Play!'
    assert_text "Sorry, cat is out of the grid"
  end

  test "get a message that the word is not a valid English word.." do
    visit '/new'
    fill_in "word", with: "o"
    click_on 'Play!'
    assert_text "Well done! o is a valid English word"
  end

end
