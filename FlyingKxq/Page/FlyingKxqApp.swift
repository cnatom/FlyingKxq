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
            .flyToast(show: $toastViewModel.isShowing, text: toastViewModel.model.text, type: toastViewModel.model.type, duration: DispatchTimeInterval.seconds(1))
            .flyToastLoading(loading: $toastViewModel.isShowLoading, loadSuccess: toastViewModel.loadingModel.success, successText: toastViewModel.loadingModel.text, errorText: toastViewModel.loadingModel.text)
            .animation(.easeInOut, value: appState.isLoggedIn)
        }
    }
}
