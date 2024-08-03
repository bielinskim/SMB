Zadanie zostało wykonane w języku Swift na platformę iOS. 
W ramach zadania została stworzona lista produktów z oznaczeniami czy dany produkt został kupiony. Aplikacja umożliwia dodawanie, edytowanie i usuwanie produktów.
Ponadto został utworzony widok Ustawienia, który pozwala na zmianę koloru i rozmiaru czcionki na liście produktów.

Dołączam również film przedstawiający działanie aplikacji.

Do implementacji aplikacji wykorzystałem bibliotekę SwiftUI - widoki zostały stworzone za pomocą protokołu View, a do nawigacji wykorzystałem elementy: NavigationView i NavigationLink.

MainActivity -> ShoppingListApp
ProductListActivity -> ShoppingList
OptionsActivity -> PreferencesForm

Do przechowywania listy produktów wykorzystałem dostępną na iOS bazę danych Core Data.
Do zapisu preferencji użytkownika użyłem UserDefaults.