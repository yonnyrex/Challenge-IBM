//
//  Stinsen+Extensions.swift
//  Challenge-IBM
//
//  Created by Yonny on 15/01/25.
//

import Foundation
import Stinsen

extension NavigationRouter where T: NavigationCoordinatable {
    func popMany(times: Int = 2) {
        for _ in 0..<times {
            self.pop()
        }
    }
}

extension NavigationCoordinatable {
    
    func eraseToNavigationCoordinator() -> NavigationViewCoordinator<Self> {
        return NavigationViewCoordinator(self)
    }
    
}
