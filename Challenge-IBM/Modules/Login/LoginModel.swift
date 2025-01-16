//
//  LoginModel.swift
//  Challenge-IBM
//
//  Created by Yonny on 15/01/25.
//

import Foundation

enum LoginConstants {
    
    static let invalidUserErrorMessage = "El usuario es incorrecto"
    static let invalidPasswordErrorMessage = "La contraseña es incorrecta"
    static let errorTitle = "Ocurrió un error"
    
}

enum LoginError: LocalizedError {
    
    case invalidUser
    case invalidPassword
    case error(message: String)
    
}

extension LoginError {
    
    var errorDescription: String? {
        switch self {
        case .invalidUser, .invalidPassword, .error:
            LoginConstants.errorTitle
        }
    }
    
    var failureReason: String? {
        switch self {
        case .invalidUser:
            LoginConstants.invalidUserErrorMessage
        case .invalidPassword:
            LoginConstants.invalidPasswordErrorMessage
        case .error(let message):
            message
        }
    }
    
}

struct LoginResponse: Codable {
    
    let success: Bool
    let message: String
    
}
