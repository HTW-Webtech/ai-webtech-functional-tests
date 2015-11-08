require 'open-uri'

describe 'Exercise 2: CSS Layouts', type: :feature, js: true do
  INDEX_URL = $EXERCISE_BASE_URL

  context 'on the index.html' do
    before { visit INDEX_URL }

    it 'includes a link-tag with rel="stylesheet"' do
      page.find(:xpath, "//head/link[contains(@rel, 'stylesheet')]", visible: false)
    end

    it 'includes a link-tag referencing an external style.css file' do
      page.find(:xpath, "//head/link[contains(@href, 'style.css')]", visible: false)
    end

    context 'the style.css' do
      let(:style_node) { page.find(:xpath, "//head/link[contains(@href, 'style.css')]", visible: false) }
      let(:style) { open(style_node['href']).read }

      %w[background border border-radius color display content cursor font-family
      font-size font-weight margin padding transition transform].each do |expected_property|
        it "includes the css property #{expected_property}" do
          expected = "#{expected_property}:"
          expect(style.include?(expected)).to eq(true), "Your style.css does not include: '#{expected}'"
        end
      end
    end
  end
end
