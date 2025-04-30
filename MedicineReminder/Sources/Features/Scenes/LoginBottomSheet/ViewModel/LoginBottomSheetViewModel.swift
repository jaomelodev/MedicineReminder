//
//  LoginBottomSheetViewModel.swift
//  MedicineReminder
//
//  Created by João Melo on 10/02/25.
//

import Foundation
import Firebase

class LoginBottomSheetViewModel {
    var successResult: ((String) -> Void)?
    var errorResult: ((String) -> Void)?

    func doAuth(usernameLogin: String, password: String) {
        Auth.auth().signIn(withEmail: usernameLogin, password: password) { [weak self] _, error in
            if error != nil {
                self?.errorResult?("Erro ao realizar login, verifique as credenciais digitadas")
            } else {
                self?.successResult?(usernameLogin)
            }
        }
    }
}
