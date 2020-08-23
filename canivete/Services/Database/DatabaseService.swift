//
//  DatabaseService.swift
//  canivete
//
//  Created by Luiz Fernando dos Santos on 16/08/20.
//  Copyright © 2020 Luiz Fernando dos Santos. All rights reserved.
//

import Foundation

final class DatabaseService {
    public static let shared: DatabaseService = DatabaseService()
    private let userDefault: UserDefaults = UserDefaults.standard
    
    private init() { }
    
    func getUser() -> User? {
        guard let data = userDefault.data(forKey: UserDefaultsKeys.user.rawValue) else {
            return nil
        }
        
        let decoder = JSONDecoder()
        guard let object = try? decoder.decode(User.self, from: data) else { return nil }
        
        return object
    }
    
    func setUser(user: User) {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(user) else { return }
        self.userDefault.set(data, forKey: UserDefaultsKeys.user.rawValue)
        print(getUser())
    }
}

private extension DatabaseService {
    enum UserDefaultsKeys: String {
        case user
    }
}
