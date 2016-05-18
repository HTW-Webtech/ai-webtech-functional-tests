module FindHelper
  def expect_xpath(tag:, attr: '.', value:)
    if attr == '.'
      expect(page).to have_selector(:xpath, "//#{tag}[contains(#{attr}, '#{value}')]", visible: false, wait: 0.1), "<#{tag}>#{value}</#{tag}> nicht gefunden auf #{page.current_url}."
    else
      expect(page).to have_selector(:xpath, "//#{tag}[contains(@#{attr}, '#{value}')]", visible: false, wait: 0.1), "<#{tag} #{attr}='#{value}'> nicht gefunden auf #{page.current_url}"
    end
  end

  def expect_content_match(string)
    expect(page).to have_content(/#{string}.downcase/i), "Auf der Seite: #{page.current_url}"
  end
end
