Zadanie wykonałem w języku Swift na platforme iOS.

Mapa: do wyświetlenia mapy skorzystałem z biblioteki MapKit (klasa Map), a do wyznaczenia sklepów na mapie klasy MapPin. Kod znajduję się w pliku ShopMap.swift.

Lista ze sklepami: pozwoliłem utworzyć sobie dwa osobne widoki dla listy i formularza. Formularz zawiera pola nazwa, promień oraz opis. Przy dodaniu sklepu do bazy Firestore dołączana jest aktualna lokalizacja użytkownika jako lokalizacja sklepu.
Każdy wiersz na liście zawiera nazwę, promień, współrzędne, opis i ikonkę do usunięcia sklepu.

Do określania aktualnej lokalizacji użytkownika i wyświetlania jej na mapie rozszerzyłem klasę CLLocationManagerDelegate implementując funkcje locationManager(didUpdateLocations).

Do obserwacji czy użytkownik wkroczył lub opuścił promień sklepu użyłem funkcji startMonitoring i również rozszerzyłem klasę CLLocationManagerDelegate i zaimplementowałem funkcje locationManager(didEnterRegion) i locationManager(didExitRegion).

Powyższy kod znajduje się w pliku UserLocation.swift.

Do tworzenia notyfikacji wykorzystałem klasę UNMutableNotificationContent. Kod znajduje się w pliku Notification.swift. 

Dodatkowo aplikacja prosi użytkownika o wymagane uprawnienia (lokalizacja użytkownika, notyfikacje) w przypadku ich braku.

Dołączam również film przedstawiający działanie aplikacji.
