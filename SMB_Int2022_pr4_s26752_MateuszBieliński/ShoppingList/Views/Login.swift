//
//  Login.swift
//  ShoppingList
//
//  Created by Mateusz Bieliński on 10/12/2022.
//

import SwiftUI
import Firebase

struct Login: View {
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
            
            
            Button("Zaloguj się") {
                login()
            }
            
            NavigationLink {
                Register()
            } label: {
                Text("Rejestracja")
                .font(.system(size: 14))
                .foregroundColor(Color.gray)
            }
        }
        .navigationBarTitle("Logowanie")
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
    
    func login() {
        if(validate()) {
            AuthService.shared.login(email: email, password: password) { result, error in
                if (error != nil) {
                    print(error!.localizedDescription)
                    validation = error!.localizedDescription
                }
                
                if(result != nil) {
                    info = "Zalogowano"
                }
            }
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
