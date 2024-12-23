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
            ZStack(alignment: .center) {
                if appState.isLoggedIn {
                    MainTabView()
                        .environmentObject(appState)
                        .transition(.offset(x: 0, y: 40).combined(with: .opacity))
                        .onAppear {
                            appState.checkLoginStatus()
                        }

                } else {
                    LoginView()
                        .environmentObject(appState)
                        .transition(.offset(x: 0, y: 40).combined(with: .opacity))
                }
            }
            .animation(.easeInOut, value: appState.isLoggedIn)
        }
    }
}
