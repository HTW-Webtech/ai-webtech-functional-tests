describe '', type: :feature, js: true do
  INDEX_URL = $EXERCISE_BASE_URL

  context 'Start (index.html)' do
    before do
      visit INDEX_URL
      clear_storage
      click_on 'Start'
    end

    it 'Zeigt die richtigen Zahlen zu Beginn an' do
      clear_storage
      click_on 'Start'
      expect(page.body).to have_content 'Karten: 0'
      expect(page.body).to have_content 'Richtig beantwortet: 0'
      expect(page.body).to have_content 'Falsch beantwortet: 0'
    end
  end

  context 'Auf der "Verwalten" Seite (manage.html)' do
    before do
      visit INDEX_URL
      clear_storage
      click_on 'Verwalten'
    end

    it 'Kann ich eine neue Karte hinzufügen: Vorderseite: Badezimmer, Rückseite: bathroom' do
      click_on 'Hinzufügen'
      fill_in 'front', with: 'Badezimmer'
      fill_in 'back', with: 'bathroom'
      click_on 'Speichern'
      expect(page.body).to have_content 'Badezimmer'
      expect(page.body).to have_content 'bathroom'
    end

    it 'Der Knopf "Demodaten laden" lädt die 3 Demo-Karten (siehe Übungsbeschreibung)' do
      click_on 'Demodaten laden'
      click_on 'Start'
      expect(page.body).to have_content 'Karten: 3'
      expect(page.body).to have_content 'Richtig beantwortet: 0'
      expect(page.body).to have_content 'Falsch beantwortet: 0'
    end

    it 'Der Knopf "Karten löschen" löscht alle Karten' do
      click_on 'Demodaten laden'
      click_on 'Daten löschen'
      click_on 'Start'
      expect(page.body).to have_content 'Karten: 0'
      expect(page.body).to have_content 'Richtig beantwortet: 0'
      expect(page.body).to have_content 'Falsch beantwortet: 0'
    end
  end

  context 'auf der Lernen-Seite (learn.html)' do
    before do
      visit INDEX_URL
      click_on 'Lernen'
      clear_storage
    end

    it 'Ich kann die Demo-Daten laden und eine Runde durchspielen' do
      click_on 'Verwalten'
      click_on 'Demodaten laden'

      click_on 'Lernen'
      click_on 'Beginn'
      expect(page.body).to have_content 'Karte: 1/3'

      expect(page.body).to have_content 'Kindergarten'
      click_on 'Umdrehen'
      expect(page.body).to have_content 'kindergarten'
      click_on 'Ja'

      expect(page.body).to have_content 'Karte: 2/3'
      expect(page.body).to have_content 'Schachbrett'
      click_on 'Nein'

      expect(page.body).to have_content 'Karte: 3/3'
      expect(page.body).to have_content 'Badezimmer'
      click_on 'Nein'

      click_on 'Start'
      expect(page.body).to have_content "Karten: 3"
      expect(page.body).to have_content "Richtig beantwortet: 1"
      expect(page.body).to have_content "Falsch beantwortet: 2"
    end
  end
end
