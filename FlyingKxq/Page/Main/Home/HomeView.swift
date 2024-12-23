//
//  HomeView.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView {
            ForEach(0...100,id: \.self) { value in
                Text("\(value)")
            }
            .frame(maxWidth: .infinity)
        }
        
    }
}

#Preview {
    HomeView()
}
