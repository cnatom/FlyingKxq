//
//  ObservableObject+UpdateUI.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/23.
//

import SwiftUI

extension ObservableObject {
    func updateUI(_ update: @escaping () -> Void) {
        DispatchQueue.main.async {
            update()
        }
    }
}
