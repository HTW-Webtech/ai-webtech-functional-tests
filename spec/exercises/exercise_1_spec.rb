describe 'Second thing', type: :feature do
  it 'opens github and searches for ajax!' do
    visit ENV['EXERCISE_BASE_URL']
    page.find(:xpath, '//h1[contains(., "Bazinga")]')
  end
end
