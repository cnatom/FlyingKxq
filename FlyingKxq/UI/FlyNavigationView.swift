//
//  FlyNavigationView.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/7.
//

import SwiftUI

struct FlyNavigationView<Content: View>: View {
    let content: Content
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        NavigationView {
            content
        }
        .navigationViewStyle(.stack)
    }
}
