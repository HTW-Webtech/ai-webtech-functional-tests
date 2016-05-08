module FindHelper
  def expect_xpath(tag:, attr: '.', value:)
    if attr == '.'
      expect(page).to have_selector(:xpath, "//#{tag}[contains(#{attr}, '#{value}')]", visible: false), "<#{tag}>#{value}</#{tag}> nicht gefunden."
    else
      expect(page).to have_selector(:xpath, "//#{tag}[contains(@#{attr}, '#{value}')]", visible: false), "<#{tag} #{attr}='#{value}'> nicht gefunden."
    end
  end
end
