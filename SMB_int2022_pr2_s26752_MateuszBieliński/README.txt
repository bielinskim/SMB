Miałem trudności ze znalezieniem odpowiedników potrzebnych komponentów w iOSie, więc przygotowałem aplikacje na Androida.

Jako, że poprzednie zadanie wykonałem na iOSa, stworzyłem aplikację z listą produktów z dodawaniem, edytowaniem i usuwaniem na Androida.

W tej aplikacji (ShoppingList) w ramach obecnego zadania:
- w pliku ProductFormActivity.kt po dodaniu nowego produktu jest tworzony Intent z akcją "com.example.shoppinglist.ADD_PRODUCT", 
	następnie są dodawane do niego dane o dodanym produkcie 
	oraz zostaje wywołany sendBroadcast z utworzonym intentem oraz nazwą potrzebnego, customowego uprawnienia.
- w pliku AndroidManifest.xml zostało zdefiniowane wymagane uprawnienie do odbioru intencji przez aplikację z receiver'em,
	a w intent-filter dla aktywności z formularzem edycji została dodana akcja pozwalajaca na uruchomienie aktywności z notyfikacji

Druga aplikacja(ShoppingListNotification):
- MainActivity.kt - zostaje tutaj powiązana usługa do tworzenia notyfikacji i zarejestrowany BroadcastReceiver przechwytujący intencje z pierwszej aplikacji,
	po przechwyceniu intencji nastepuje zlecenie utworzenia notyfikacji usłudze
- NotificationService.tk - znajduje się tutaj kod usługi, metoda kliencka przygotowuje intent z danymi i tworzy notyfikacje; 
	notyfikacja zawiera dane o dodanym produkcie, a po kliknięciu przekierowuje do formularza edycji w pierwszej aplikacji 
- w pliku AndroidManifest.xml zostało zdefiniowane wymagane uprawnienie do odbioru intencji