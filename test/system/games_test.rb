require 'application_system_test_case'

class GamesTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit games_url
  #
  #   assert_selector "h1", text: "Games"
  # end

  test 'Going to /new gives us a new random grid to play with' do
    visit new_url
    assert_text 'New game'
    assert_selector 'li', count: 10
  end

  test 'Writing a random word and getting an error' do
    visit new_url
    fill_in 'word', with: ((0..9).map { |_| ('A'..'Z').to_a[rand(26)] }).join
    click_on 'Go'
    assert_text 'Sorry but'
    assert_text "can't be built out of "
  end

  test 'Writing a non english word from grid and getting an error' do
    visit new_url
    letters = find(:xpath, "//input[@name='letters']", :visible => false).value
    fill_in 'word', with: letters
    click_on 'Go'
    assert_text 'Sorry but'
    assert_text "does not seem to be a valid English word..."
  end

  test 'Writing a non english word from grid and getting an error' do
    visit new_url
    letters = find(:xpath, "//input[@name='letters']", :visible => false).value
    fill_in 'word', with: letters
    click_on 'Go'
    assert_text 'Sorry but'
    assert_text "does not seem to be a valid English word..."
  end
end
