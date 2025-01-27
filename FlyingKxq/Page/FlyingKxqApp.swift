//
//  FlyingKxqApp.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/16.
//

import SwiftUI

@main
struct FlyingKxqApp: App {
    @StateObject var appState = AuthManager.shared
    @StateObject var toastViewModel = ToastViewModel()
    @StateObject var toastLoadingViewModel = ToastLoadingViewModel()
    var body: some Scene {
        WindowGroup {
            ZStack(alignment: .center) {
                if appState.isLoggedIn {
                    MainTabView()
                        .transition(.offset(x: 0, y: 40).combined(with: .opacity))
                        .onAppear {
                            Task {
                                await appState.refreshTokenIfNeed()
                            }
                        }

                } else {
                    LoginView()
                        .transition(.offset(x: 0, y: 40).combined(with: .opacity))
                }
            }
            .environmentObject(appState)
            .environmentObject(toastViewModel)
            .environmentObject(toastLoadingViewModel)
            .flyToast(show: $toastViewModel.isShowing, text: toastViewModel.model.text, type: toastViewModel.model.type, duration: DispatchTimeInterval.seconds(1))
            .flyToastLoading(loading: $toastLoadingViewModel.isShowLoading, loadSuccess: toastLoadingViewModel.model.success, successText: toastLoadingViewModel.model.text, errorText: toastLoadingViewModel.model.text)
            .animation(.easeInOut, value: appState.isLoggedIn)
        }
    }
}
