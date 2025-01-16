//
//  Untitled.swift
//  Challenge-IBM
//
//  Created by Yonny on 15/01/25.
//

import Foundation

enum PersistenceKey: String, CaseIterable {
    
    case isLogin
    
}

protocol PersistenceServiceType {
    
    func save(key: PersistenceKey, value: Any)
    func retrieve(for key: PersistenceKey) -> Any?
    func remove(for key: PersistenceKey)
    
}
