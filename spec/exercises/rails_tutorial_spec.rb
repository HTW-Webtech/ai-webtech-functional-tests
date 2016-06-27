describe 'Rails Tutorial', type: :feature, js: true do
  INDEX_URL = $EXERCISE_BASE_URL
  ARTICLES_URL = "#{INDEX_URL}/articles"

  it 'has a link to the spec file' do
    STDOUT.write "\n"
    STDOUT.write "You can find the original spec file here:\n"
    STDOUT.write "https://github.com/HTW-Webtech/ai-webtech-functional-tests/blob/master/spec/exercises/#{File.basename(__FILE__)}\n\n"
  end

  context '' do
    before do
      basic_auth user: 'admin', password: 'admin'
      visit ARTICLES_URL
    end

    it 'includes the required <meta data-app-slug="app-id">-tag' do
      expect_xpath(tag: 'meta', attr: 'data-app-slug', value: $APP_NAME)
    end

    it 'Destroys all existing articles' do
      destroy_links = all('a').select { |a| a.text.downcase == 'destroy' }
      destroy_links.each { |link| link.click }
    end

    it 'Creates a new article' do
      click_on 'New Article'
      click_on 'Create Article'

      expect(page).to have_content 'Title is too short'

      # Fill out form w/ all necessary attributes
      fill_in 'Title', with: 'Ein Staat organisiert den Weg ins Internet'
      fill_in 'Text', with: <<-TEXT
Genau ein Jahr nach der Ankündigung des Endes der US-Blockadepolitik gegen
Kuba wird immer deutlicher, wie der Inselstaat die Bevölkerung ins Internet bringen will.
Die Voraussetzungen für eine Aufholjagd im IT-Bereich sind gar nicht schlecht.
TEXT
      click_on 'Save Article'

      # Go back to the index page
      visit ARTICLES_URL

      # Expect the title of the just created article
      expect(page).to have_content 'Ein Staat organisiert den Weg ins Internet'

      # Expect 'Edit', and 'Destroy' links
      expect(page).to have_css('a', text: 'Edit')
      expect(page).to have_css('a', text: 'Destroy')
    end

    it 'Destroys all existing articles' do
      destroy_links = all('a').select { |a| a.text.downcase == 'destroy' }
      destroy_links.each { |link| link.click }
    end
  end
end
