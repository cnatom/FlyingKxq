//
//  AppStateViewModel.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/23.
//

import SwiftUI

actor TokenManager {
    static let shared = TokenManager()
    private var needRefresh = true

    func shouldRefreshToken() -> Bool {
        if needRefresh {
            needRefresh = false
            return true
        }
        return false
    }

    func resetRefreshFlag() {
        needRefresh = true
    }
}

class AuthManager: ObservableObject {
    static let shared = AuthManager()
    private init() {
        isLoggedIn = store.get(.isLoggedIn) ?? false
    }

    let store = FlyUserDefaults.shared
    let keyChain = FlyKeyChain.shared

    @Published var isLoggedIn: Bool {
        didSet {
            store.set(isLoggedIn, for: .isLoggedIn)
        }
    }

    func refreshTokenIfNeed() async {
        guard await TokenManager.shared.shouldRefreshToken() else { return }
        var api = RefreshTokenAPI()
        api.injectToken = true
        if let refreshToken = keyChain.read(key: .refreshToken) {
            api.parameters["refreshToken"] = refreshToken
        } else {
            updateUI { self.isLoggedIn = false }
            return
        }
        do {
            let response = try await NetworkManager.shared.request(api: api)
            if response.code == 200 {
                keyChain.saveToken(
                    accessToken: response.data?.accessToken,
                    refreshToken: response.data?.refreshToken
                )
                updateUI { self.isLoggedIn = true }
            } else {
                updateUI { self.isLoggedIn = false }
            }
        } catch {
            print(error.localizedDescription)
            updateUI { self.isLoggedIn = false }
        }
    }

    func logout() {
        isLoggedIn = false
        store.remove(.isLoggedIn)
    }
}
