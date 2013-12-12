[![Build Status](https://travis-ci.org/itedd/itedd.png?branch=master)](https://travis-ci.org/itedd/itedd)
[![Code Climate](https://codeclimate.com/github/itedd/itedd.png)](https://codeclimate.com/github/itedd/itedd)

IT-Events Dresden
=================

In Dresden arbeiten viele engagierte Leute in UserGroups mit. Sie organisieren Events und opfern dafür Freizeit und oft auch Geld. Um so ärgerlicher, wenn es zu Terminkonflikten mit anderen UserGroups kommt und man sich so gegenseitig das Publikum "wegnimmt".

Wie wäre es, wenn die Organisatoren auf einen Blick sehen können, wann bereits Veranstaltungen anderer UserGroups geplant sind? Wie wäre es, wenn sie für die Pflege dieser Daten _keinen_ (oder zumindest _keinen nennenswerten_) zusätzlichen, manuellen Aufwand hätten?

Wäre es nicht auch für die Teilnehmer aller Veranstaltungen sinnvoll, wenn Sie einen Überblick zu anderen Veranstaltungen in der Region bekommen können?


Ein Kalender für alle
---------------------

Die Events aller UserGroups müssen in einen, gemeinsamen Kalender, das ist offensichtlich. Aber wo sollen die Termine denn herkommen?

Viele UserGroups nutzen unter anderem Twitter, um auf Ihre Veranstaltungen hinzuweisen. Twitter ist gut automatisiert auswertbar und eignet sich deshalb sehr gut als Informationsquelle. Beispiel:

@webmontagdd: Der nächste Webmontag Dresden ist am 13.1.2014 in der @cofabdd. Am besten gleich anmelden und teilen https://plus.google.com/events/c3hpt206lq0obfgevis6fcg2mec … #dd #web #event

* Am Hashtag #event erkennt man, dass man sich diesen Tweet also genauer ansehen muss.
* Der Autor ist erkennbar und läßt sich einer UserGroup zuordnen: WebMontag Dresden
* Ein Datum ist auch enthalten: 13.01.2014
* Ein Link zu weiteren Informationen liefert die Details: https://plus.google.com/events/c3hpt206lq0obfgevis6fcg2mec

Indem der komplette Inhalt des Tweets, hinterlegt mit dem ersten Link auf das erkannte Datum gelegt wird, läßt sich ein Kalender für alle realisieren. Ohne Mehraufwand für die Organisatoren!

Natürlich muss es die Möglichkeit geben, Termine nachzubearbeiten, falls man sich mal geirrt hat oder ein Termin abgesagt werden muss.

Mehrere UserGroups kann man vielleicht mit eigenen Farben voneinander unterscheiden.

Indem der Kalender einfach in andere Seiten (z.B. die Webseiten der UserGroups) integriert werden kann, informiert man die Leser auch über andere IT Events, die bisher nicht auf ihrem Radar waren.

Neben einer Monatsübersicht ist auch eine Listendarstellung denkbar. Damit eine UserGroup vielleicht ausschlisslich diesen Kalender verwendet, ist eine gesonderte Darstellung nur einer UserGroup sinnvoll (dann natürlich mit der Möglichkeit, alle anderen Termine auch einzublenden).

Perspektivisch sind auch andere Informationsquellen denkbar, aber das rudimentäre Format (#event, Datum, Link und Beschreibung) bleibt:
* RSS-Feed
* Email
* ...

Es gibt viel zu tun.

Wie kam es zu diesem Projekt und wo stehen wir?
-----------------------------------------------

Die Ruby-UserGroup hatte den Wunsch, etwas gemeinsam zu programmieren. Das Projekt sollte aber auch einen echten Nutzen haben. Bei ein Stammtisch-Meeting wurde die Idee zu ITEDD geboren. Die Organisatoren haben andere UserGroups angesprochen und das Interesse war deutlich. Die JUG wollte das Problem übrigens auch angehen, war aber noch nicht sehr weit.

So hat also die JUG Anforderungen für dieses System gesammelt, beim WebMontag wurde ein Designer gesucht und die Ruby-Usergroup programmiert. Alle haben etwas davon, alle steuern etwas bei. So geht das mit OpenSource.

Ziel
----

Unser Ziel ist, die Abstimmung und Vernetzung der UserGroups in Dresden zu verbessern. Ohne Mehraufwand für die Organisatoren und zum Nutzen von Organisatoren und Teilnehmern aller IT-Events.

Die entstehende Software wird hier veröffentlicht und steht auch anderen Regionen zur Verfügung.

Wie kann meine UserGroup mit aufgenommen werden?
------------------------------------------------

UserGroups aus Dresden können sich bei uns melden, wenn sie mit aufgenommen werden wollen. Die Registrierung ist moderiert, um das System vor Missbrauch zu schützen.


## Beitragen

1. Projekt forken
2. Änderungen durchführen. Tests nicht vergessen.
3. Pull-Request stellen. Dieser wird auf Travis-CI getestet.

Erste Schritte:

```ruby
bundle
cp config/database.yml.example config/database.yml
# Database.yml an eigenes System anpassen
rake db:create
rake db:migrate
rake test
```
