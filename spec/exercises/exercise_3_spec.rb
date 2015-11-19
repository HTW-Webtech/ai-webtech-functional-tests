shared_examples 'jede Seite' do
  context 'und hat ein nav-tag' do
    it 'mit einem link "Start" zur "index.html"'
    it 'mit einem link "Verwalten" zur "manage.html"'
    it 'mit einem link "Lernen" zur "learn.html"'
  end
end

describe '', type: :feature, js: true do
  INDEX_URL = $EXERCISE_BASE_URL

  context 'Start (index.html)' do
    before :all do
      # visit INDEX_URL
      # clear_local_storage
    end

    it_behaves_like 'jede Seite'
    it 'zeigt Text "Karten: 0"'
    it 'zeigt Text "Richtig beantwortet: 0"'
    it 'zeigt Text "Falsch beantwortet: 0"'
  end

  context 'Auf der "Verwalten" Seite (manage.html)' do
    before :all do
      # visit INDEX_URL
      # click_on 'Verwalten'
    end

    describe 'kann ich eine neue Karte anlegen.' do
      it 'Mit Klick auf "Hinzufügen" erscheint ein Formular'
      it 'Ich trage das Wort "Badezimmer" in <input name="front" …> ein'
      it 'Ich trage das Wort "bathroom" in <input name="back" …> ein'
      it 'Ich klicke auf "Speichern"'
      it 'Ich sehe die Begriffe "Badezimmer" und "bathroom" in der Kartenübersicht'
      it 'Ich klicke auf "Ja"'
      it 'Ich "Gut gemacht!"'
      it 'Ich gehe auf die Startseite und sehe "Karten: 1"'
      it 'Außerdem sehe ich "Richtig beantwortet: 1"'
      it 'Und "Falsch beantwortet: 0"'
    end
  end
end
