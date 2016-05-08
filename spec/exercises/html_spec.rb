shared_examples 'all pages and' do |url|
  before { visit url }

  it 'includes the product-logo' do
    expect_xpath(tag: 'img', attr: 'src', value: 'bazinga-logo.png')
  end

  it 'has the correct headline' do
    expect_xpath(tag: 'h1', value: 'Bazinga!')
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

  it 'has the required meta-tags for `author` and `keywords`' do
    expect_xpath(tag: 'meta', attr: 'name', value: 'author')
    expect_xpath(tag: 'meta', attr: 'name', value: 'keywords')
  end

  # FIXME: Does not accept meta tag for utf8 charset
  # it 'is valid html according to html-tidy' do
  #   expect(page).to have_valid_html
  # end
end

describe 'HTML Übung:', type: :feature do
  INDEX_URL   = $EXERCISE_BASE_URL
  CONTACT_URL = "#{INDEX_URL}/contact.html"
  IMPRINT_URL = "#{INDEX_URL}/imprint.html"

  context 'index.html' do
    it_behaves_like 'all pages and', INDEX_URL
    before { visit INDEX_URL }

    it 'has a p-tag containing the Bazinga product message' do
      expect_xpath(tag: 'p', value: 'Bazinga! Focus on getting your software')
    end
  end

  context 'contact.html' do
    it_behaves_like 'all pages and'
    before { visit CONTACT_URL }

    it 'has a form with action="/contact", and method="/post"' do
      expect_xpath(tag: 'form', attr: 'method', value: 'post')
      expect_xpath(tag: 'form', attr: 'action', value: '/contact')
    end
  end

  context 'imprint.html' do
    it_behaves_like 'all pages and'
    before { visit IMPRINT_URL }

    it 'includes the telephon-number as anchor' do
      expect_xpath(tag: 'a', attr: 'href', value: 'tel:03050190')
    end

    it 'includes the address in a proper <address>-Tag' do
      expect_xpath(tag: 'address', value: 'Wilhelminenhofstraße 75A')
    end
  end
end
