shared_examples 'all pages' do |url|
  let(:url) { url }

  it 'includes the product-logo' do
    page.find(:xpath, "//img[contains(@src, 'bazinga-logo.png')]")
  end

  it 'has the correct headline' do
    page.find(:xpath, "//h1[contains(., 'Bazinga!')]")
  end

  it 'links to "contact.html"' do
    page.find(:xpath, "//a[contains(@href, 'contact.html')]")
  end

  it 'links to "imprint.html"' do
    page.find(:xpath, "//a[contains(@href, 'imprint.html')]")
  end

  it 'conforms to the Nu Html Checker' do
    expect(page_markup_valid?(url)).to eq true
  end
end

describe 'Exercise 1', type: :feature do
  INDEX_URL   = $EXERCISE_BASE_URL
  CONTACT_URL = "#{INDEX_URL}/contact.html"
  IMPRINT_URL = "#{INDEX_URL}/imprint.html"

  context 'the index.html' do
    it_behaves_like 'all pages', INDEX_URL
    before { visit INDEX_URL }

    it 'has a p-tag with the Bazinga product description text "Lorem Ipsum"' do
      page.find(:xpath, "//p[contains(., 'Lorem Ipsum')]")
    end
  end

  context 'the contact.html' do
    it_behaves_like 'all pages', CONTACT_URL
    before { visit CONTACT_URL }

    it 'has a form with action="/submit", and post-method' do
      page.find(:xpath, "//form")
      page.find(:xpath, "//form[contains(@method, 'post')]")
    end
  end

  context 'the imprint.html' do
    it_behaves_like 'all pages', IMPRINT_URL
    before { visit IMPRINT_URL }

    it 'includes the telephon-number as anchor' do
      page.find(:xpath, "//a[contains(@href, 'tel:03050190')]")
    end

    it 'includes the address in a proper <address>-Tag' do
      page.find(:xpath, "//address[contains(., 'Wilhelminenhofstraße 75A')]")
    end
  end
end
