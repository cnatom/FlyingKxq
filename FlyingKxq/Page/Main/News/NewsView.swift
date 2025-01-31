//
//  NewsView.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/23.
//

import SwiftUI

struct NewsView: View {
    @State var index1: CGFloat = 1
    @State var index2: CGFloat = 0
    @StateObject var viewModel = NewsViewModel()
    var body: some View {
        FlyScaffold {
            VStack(spacing: 0) {
                HStack {
                    FlyTabBar(selectedIndex: $index1, spaceAround: false, spacing: 16, type: .news, items: viewModel.tab1List)
                    Spacer()
                    Image(systemName: "magnifyingglass")
                }
                .padding(.horizontal, 18)
                .padding(.bottom, 10)
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing:0) {
                        
                        ForEach(1..<3){index in
                            VStack {
                                tabBar2
                                Spacer()
                                Text("\(index)")
                                    .frame(width: self.screenSize.width)
                                Spacer()
                            }
                        }
                        .onFrameChange { proxy in
                            let minX = proxy.minX
                            index2 = -minX / screenSize.width
                        }
                    }
                    .frame(maxHeight: .infinity)
                }
                .intro { scroll in
                    scroll.isPagingEnabled = true
                }
            }
        }
    }
    
    var tabBar2: some View {
        FlyTabBar(selectedIndex: $index2, spaceAround: false, spacing: 16, type: .chip, items: viewModel.tab2List)
    }
    
    var testPage: some View {
        Text("Hello")
            .frame(width: self.screenSize.width)
    }
}

#Preview {
    NewsView()
}
