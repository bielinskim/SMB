Do wykonania zadania wykorzystałem projekt 1 napisany w języku Swift.

Do przechowywania danych zastosowałem bazę danych Cloud Firestore.

Kod odpowiedzialny za komunikację z usługami Firestore i Authentication znajduje odpowiednio się w plikach DataManager.swift oraz AuthService.swift.

Ścieżka 'products' daje dostęp do wspólnej kolekcji.
Kolekcje użytkowników znajdują się pod ścieżkami 'users/{userId}/products'.

Żeby korzystać z aplikacji użytkownik musi zarejestrować się i zalogować za pomocą adresu email i hasła.

Zostały utworzone odpowiednie reguły ograniczające dostęp - do wspólnej listy zalogowanym użytkownikom i do danej listy odpowiedniemu użytkownikowi.

Na widoku listy użytkownik może przełączać między wspólną i własną listą.

Dołączam również film przedstawiający działanie aplikacji.

