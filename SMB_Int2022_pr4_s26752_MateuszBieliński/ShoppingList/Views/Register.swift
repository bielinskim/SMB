//
//  Register.swift
//  ShoppingList
//
//  Created by Mateusz Bieliński on 10/12/2022.
//

import SwiftUI
import Firebase

struct Register: View {
    @State var email: String = ""
    @State var password: String = ""
    
    @State var validation: String = ""
    @State var info: String = ""
    
    var body: some View {
        VStack(spacing: 30) {
            Text(validation)
                .foregroundColor(.red)
            Text(info)
                .foregroundColor(.green)

            TextField("Email", text: $email)
            .textFieldStyle(RoundedBorderTextFieldStyle())

            SecureField("Hasło", text: $password)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Zarejestruj się") {
                register()
            }
            
            NavigationLink {
                Login()
            } label: {
                Text("Logowanie")
                .font(.system(size: 14))
                .foregroundColor(Color.gray)
            }
        }
        .navigationBarTitle("Rejestracja")
    }
    
    func validate() -> Bool {
        if(email.isEmpty) {
            validation = "Uzupełnij email"
            return false;
        }
        
        if(password.isEmpty) {
            validation = "Uzupełnij hasło"
            return false;
        }
        
        return true;
    }
    
    func register() {
        if(validate()) {
            AuthService.shared.register(email: email, password: password) { result, error in
                if (error != nil) {
                    validation = "Błąd podczas rejestracji"
                }
                
                if(result != nil) {
                    info = "Zarejestrowano"
                }
            }
        }
    }
}

struct Register_Previews: PreviewProvider {
    static var previews: some View {
        Register()
    }
}
