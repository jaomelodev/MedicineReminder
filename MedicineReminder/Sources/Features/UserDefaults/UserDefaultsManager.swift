//
//  UserDefaultsManager.swift
//  MedicineReminder
//
//  Created by João Melo on 15/02/25.
//

import Foundation

class UserDefaultsManager {
    private static let userKey = "userKey"
    private static let userNameKey = "userNameKey"
    private static let userImageKey = "userImageKey"

    static func saveUser(user: User) {
        let encoder = JSONEncoder()

        if let encoded = try? encoder.encode(user) {
            UserDefaults.standard.set(encoded, forKey: userKey)
            UserDefaults.standard.synchronize()
        }
    }

    static func saveUserName(_ name: String) {
        UserDefaults.standard.set(name, forKey: userNameKey)
        UserDefaults.standard.synchronize()
    }

    static func saveUserImage(_ image: Data) {
        UserDefaults.standard.set(image, forKey: userImageKey)
        UserDefaults.standard.synchronize()
    }

    static func loadUser() -> User? {
        if let userData = UserDefaults.standard.data(forKey: userKey) {
            let decoder = JSONDecoder()
            return try? decoder.decode(User.self, from: userData)
        }

        return nil
    }

    static func loadUserName() -> String? {
        UserDefaults.standard.string(forKey: userNameKey)
    }

    static func loadUserImage() -> Data? {
        UserDefaults.standard.data(forKey: userImageKey)
    }

    static func removeUser() {
        UserDefaults.standard.removeObject(forKey: userKey)
        UserDefaults.standard.removeObject(forKey: userNameKey)
        UserDefaults.standard.removeObject(forKey: userImageKey)
        UserDefaults.standard.synchronize()
    }
}
