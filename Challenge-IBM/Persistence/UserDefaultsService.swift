//
//  Untitled.swift
//  Challenge-IBM
//
//  Created by Yonny on 15/01/25.
//

import Foundation

class UserDefaultsService: PersistenceServiceType {
    
    // MARK: - PersistanceServiceType Protocol
    func save(key: PersistenceKey, value: Any) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    func retrieve(for key: PersistenceKey) -> Any? {
        UserDefaults.standard.object(forKey: key.rawValue)
    }
    
    func remove(for key: PersistenceKey) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
    
}
