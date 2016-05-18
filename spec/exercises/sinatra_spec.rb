shared_examples 'all pages and' do

  it 'has the required meta-tag with data-app-id="app-slug"' do
    expect_xpath(tag: 'meta', attr: 'data-app-slug', value: $APP_NAME)
  end

  it 'has the required meta-tags for `author` and `keywords`' do
    expect_xpath(tag: 'meta', attr: 'name', value: 'author')
    expect_xpath(tag: 'meta', attr: 'name', value: 'keywords')
  end

  it 'links to "index.html"' do
    expect_xpath(tag: 'a', attr: 'href', value: 'index.html')
  end

  it 'links to "contact.html"' do
    expect_xpath(tag: 'a', attr: 'href', value: 'contact.html')
  end

  it 'links to "imprint.html"' do
    expect_xpath(tag: 'a', attr: 'href', value: 'imprint.html')
  end

  it 'links to "admin.html"' do
    expect_xpath(tag: 'a', attr: 'href', value: 'admin.html')
  end
end

describe 'Sinatra Exercise:', type: :feature do
  INDEX_URL   = $EXERCISE_BASE_URL
  CONTACT_URL = "#{INDEX_URL}/contact.html"
  IMPRINT_URL = "#{INDEX_URL}/imprint.html"
  ADMIN_URL   = "#{INDEX_URL}/admin.html"

  context 'index.html' do
    before { visit INDEX_URL }
    it_behaves_like 'all pages and'
  end

  context 'imprint.html' do
    before { visit IMPRINT_URL }
    it_behaves_like 'all pages and'
  end

  context 'contact.html' do
    before { visit CONTACT_URL }
    it_behaves_like 'all pages and'

    it 'zeigt alle Formular-Felder wieder an, nachdem das Formular abgesendet wurde' do
      name = 'Hans Wurst'
      email = "foo-#{(rand*100).ceil}@example.com"
      message = "Na" * (rand*50).ceil + " Batman!"

      fill_in 'name',    with: name
      fill_in 'email',   with: email
      fill_in 'message', with: message
      click_button 'Absenden'

      expect(page).to have_content "Vielen Dank für Ihre Anfrage"
      expect(page).to have_content(name)
      expect(page).to have_content(email)
      expect(page).to have_content(message)
    end
  end

  context 'admin.html' do
    before do
      basic_auth user: 'admin', password: 'admin'
      visit ADMIN_URL
    end

    it_behaves_like 'all pages and'
  end

  context 'admin.html' do
    it 'schützt den Zugriff via Basic Auth und gibt den Response Code 401 zurück' do
      visit ADMIN_URL
      expect(page.status_code).to eq(401), "Auf #{page.current_url}"
    end

    it 'erlaubt den Zugriff mit dem geheimen Nutzer/Passwort' do
      basic_auth user: 'admin', password: 'admin'
      visit ADMIN_URL
      expect(page.status_code).to eq(200), "Auf #{page.current_url}"
    end
  end

  context 'index.html zählt jeden Seitenaufruf mit.' do
    it 'Zeigt Text "n. Seitenaufruf" aus (n={1,2,3,4,5}).' do
      1.upto(5).each do |count|
        visit INDEX_URL
        expect(page.body).to have_content("#{count}. Seitenaufruf"), "Auf #{page.current_url}"
      end
    end
  end

end
