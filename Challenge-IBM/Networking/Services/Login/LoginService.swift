//
//  LoginService.swift
//  Challenge-IBM
//
//  Created by Yonny on 15/01/25.
//

import Foundation
import Combine

protocol LoginServiceType {
    
    func login(user: String, password: String) -> AnyPublisher<LoginResponse, ServiceError>
    
}

struct LoginService: LoginServiceType {
    
    func login(user: String, password: String) -> AnyPublisher<LoginResponse, ServiceError> {
        return Future<LoginResponse, ServiceError> { promise in
            if user == "Test" && password == "password" {
                let response = LoginResponse(success: true, message: "Bienvenido")
                promise(.success(response))
            } else {
                let error = ServiceError(message: "Credenciales invalidos", code: 401, success: false)
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
}

