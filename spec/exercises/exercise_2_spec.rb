require 'open-uri'

describe 'Exercise 2:', type: :feature, js: true do
  INDEX_URL = $EXERCISE_BASE_URL

  context 'The index.html' do
    before { visit INDEX_URL }

    it 'has valid markup' do
      expect(page).to have_valid_html
    end

    it 'includes a link-tag with rel="stylesheet"' do
      page.find_all(:xpath, "//head/link[contains(@rel, 'stylesheet')]", visible: false)
    end

    it 'includes a link-tag referencing an external style.css file' do
      page.find_all(:xpath, "//head/link[contains(@href, 'style.css')]", visible: false)
    end

    # PROBLEM: Limiting students to use only 1 css file
    context 'includes a style.css' do
      let(:style_nodes) { page.find_all(:xpath, "//head/link[contains(@rel, 'stylesheet')]", visible: false) }
      let(:style_urls) do
        style_nodes.map do |node|
          href = node['href']
          if !href.start_with? "http"
            href = "#{INDEX_URL}/#{href}"
          end
          href
        end
      end
      let(:style) do
        style_urls.map do |url|
          open(url).read
        end.join("\n")
      end

      %w[background border border-radius color display content font-family
      font-size font-weight margin padding transition transform].each do |expected_property|
        it "which contains the css property #{expected_property}" do
          expected = "#{expected_property}:"
          expect(style.include?(expected)).to eq(true), "Your style.css does not include the css-property '#{expected_property}'"
        end
      end
    end
  end
end
