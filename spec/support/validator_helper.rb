module ValidatorHelper
  def page_markup_valid?(url)
    visit url
    markup = page.body
    visit 'https://validator.w3.org/#validate_by_input'
    fill_in 'fragment', with: markup
    click_on 'Check'
    !!page.body.match(/Document checking completed. No errors or warnings to show./)
  end
end
