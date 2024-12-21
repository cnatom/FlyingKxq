//
//  FlyingKxqApp.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/16.
//

import SwiftUI

@main
struct FlyingKxqApp: App {
    @StateObject var appState = AppStateViewModel()
    
    var body: some Scene {
        WindowGroup {
            if appState.isLoggedIn {
                MainTabView()
                    .environmentObject(appState)
                    .onAppear {
                        appState.checkLoginStatus()
                    }
            } else {
                LoginView()
                    .environmentObject(appState)
            }
        }
    }
}

