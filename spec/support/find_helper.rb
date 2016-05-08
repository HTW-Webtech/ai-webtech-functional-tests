module FindHelper
  def find_xpath(tag:, attr: '.', value:)
    if attr == '.'
      expect(page).to have_selector(:xpath, "//#{tag}[contains(#{attr}, '#{value}')]"), "<#{tag}>#{value}</#{tag}> nicht gefunden."
    else
      expect(page).to have_selector(:xpath, "//#{tag}[contains(@#{attr}, '#{value}')]"), "<#{tag} #{attr}='#{value}'> nicht gefunden."
    end
  end
end
