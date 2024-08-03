Po próbie wykonania zadania na system iOS i problemie z interaktywnością Widgetów w tym systemie tym razem zadanie wykonałem na system Android.

Na górze Widgetu znajduję się przycisk "Otwórz stronę", który po kliknięciu otwiera strone www.wp.pl w przeglądarce.
Odpowiedzialny kod znajduję sie w całości w metodzie updateAppWidget w klasie Widget.

Poniżej znajduje się obrazek i dwa przyciski Poprzedni/Następny pozwalające na zmianę obrazku.
Kod znajduje się w klasie Widget (metody updateAppWidget/onReceive) oraz klasie Utils (metody setOnClickPendingIntent, setImage).

Jeszcze niżej znajduje się TextView z nazwą aktualnego utworu oraz przyciski (Start, Pauza, Koniec, Poprzedni, Następny) do sterowania odtwarzaczem.
Kod znajduje się w klasie Widget (metody updateAppWidget/onReceive), klasie WidgetPlayer oraz Utils (metoda setOnClickPendingIntent).