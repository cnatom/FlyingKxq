//
//  ScrollView+Intro.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/28.
//
@_spi(Advanced) import SwiftUIIntrospect
import SwiftUI
import UIKit

extension ScrollView {
    func intro(customize: @escaping (UIScrollView) -> Void) -> some View {
        self
            .introspect(.scrollView, on: .iOS(.v15...), customize: customize)
    }
}

extension TabView {
    func intro(customize: @escaping (UITabBarController) -> Void) -> some View {
        self
            .introspect(.tabView, on: .iOS(.v15...), customize: customize)
    }
}
