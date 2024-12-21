//
//  AppStateViewModel.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/23.
//

import SwiftUI

class AppStateViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    
    func checkLoginStatus() {
        self.isLoggedIn = true
    }
    
    func logout() {
        isLoggedIn = false
    }
}
