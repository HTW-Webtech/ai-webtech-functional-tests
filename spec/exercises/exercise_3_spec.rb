# shared_examples 'jede Seite' do
#   context 'und hat ein nav-tag' do
#     it 'mit einem link "Start" zur "index.html"'
#     it 'mit einem link "Verwalten" zur "manage.html"'
#     it 'mit einem link "Lernen" zur "learn.html"'
#   end
# end

describe '', type: :feature, js: true do
  INDEX_URL = $EXERCISE_BASE_URL

  context 'Start (index.html)' do
    before :all do
      # clear_local_storage
    end

    before :each do
      visit INDEX_URL
    end

    # it_behaves_like 'jede Seite'

    it 'zeigt Text "Karten: 0"' do
      expect(page.body).to have_content 'Karten: 0'
    end

    it 'zeigt Text "Richtig beantwortet: 0"' do
      expect(page.body).to have_content 'Richtig beantwortet: 0'
    end
    it 'zeigt Text "Falsch beantwortet: 0"' do
      expect(page.body).to have_content 'Falsch beantwortet: 0'
    end
  end

  context 'Auf der "Verwalten" Seite (manage.html)' do
    before :all do
      # clear_local_storage
    end

    before :each do
      visit INDEX_URL
      click_on 'Verwalten'
    end

    describe 'kann eine neue Karte angelegt werden.' do
      it 'Mit Klick auf "Hinzufügen" erscheint ein Formular (<form>)' do
        click_on 'Hinzufügen'
        expect(page.body).to have_css 'form'
      end

      it 'Ich trage das Wort "Badezimmer" in <input name="front" …> ein' do
        fill_in 'front', with: 'Badezimmer'
      end

      it 'Ich trage das Wort "bathroom" in <input name="back" …> ein' do
        fill_in 'back', with: 'bathroom'
      end

      it 'Ich klicke auf "Speichern"' do
        click_on 'Speichern'
      end

      it 'Ich sehe die Begriffe "Badezimmer" und "bathroom" in der Kartenübersicht' do
        expect(page.body).to have_content 'Badezimmer'
        expect(page.body).to have_content 'bathroom'
      end
    end

    describe 'Demo-Daten laden' do
      it 'hat einen Knopf die Demo-Daten lädt (siehe Übungsbeschreibung)' do
        click_on 'Demodaten laden'
        click_on 'Start'
        expect(page.body).to have_content 'Karten: 3'
      end

      it 'hat einen Knopf die Demo-Daten lädt (siehe Übungsbeschreibung)' do
        # click_on 'Hinzufügen'
        # fill_in 'front', with: 'Badezimmer'
        # fill_in 'back', with: 'bathroom'
        # click_on 'Speichern'

        click_on 'Demodaten laden'
        click_on 'Start'
        expect(page.body).to have_content 'Karten: 3'
        click_on 'Verwalten'
        click_on 'Karten löschen'
        click_on 'Start'
        expect(page.body).to have_content 'Karten: 0'
      end
    end
  end

  context 'auf der Lernen-Seite (learn.html)' do
    before :all do
      # clear_local_storage
    end

    before :each do
      visit INDEX_URL
      click_on 'Lernen'
    end

    describe 'Eine Lernrunde durchführen' do
      it 'Ich gehe auf die Verwalten-Seite, lade die Demo-Daten und gehe auf die Lernen-Seite' do
        click_on 'Verwalten'
        click_on 'Demodaten laden'
        click_on 'Lernen'
      end

      it 'Ich sehe die Vorderseite der 1. Karte "Speiseeis"' do
        expect(page.body).to have_content 'Speiseeis'
      end

      it 'Ich klicke auf "Umdrehen" um auf der Rückseite das Wort "Icecream" zu sehen' do
        click_on 'Umdrehen'
        expect(page.body).to have_content 'Icecream'
      end

      it 'Ich klicke auf "Ja" und sehe die 2. Karte "Schachbrett"' do
        click_on 'Ja'
        expect(page.body).to have_content 'Schachbrett'
      end

      it 'Ich klicke auf "Nein"' do
        click_on 'Nein'
      end

      it 'Ich klicke auf "Start" und gehe auf die Startseite (index.html)' do
        click_on 'Start'
      end

      it 'Ich sehe nun "Richtig beantwortet: 1"' do
        expect(page.body).to have_content "Richtig beantwortet: 1"
      end

      it 'Und "Falsch beantwortet: 0"' do
        expect(page.body).to have_content "Falsch beantwortet: 1"
      end
    end

  end
end
