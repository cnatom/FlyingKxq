//
//  FlyNavigationBar.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/23.
//

import SwiftUI

struct FlyNavigationBar: View {
    @Binding var selectedItem: Int
    let leftItems: [String]
    let rightItems: [String]
    let addAction: (() -> Void)
    var body: some View {
        HStack(alignment:.center,spacing: 0) {
            ForEach(0 ..< leftItems.count, id: \.self) { index in
                textItem(leftItems[index], selected: selectedItem == index)
                    .frame(maxWidth: .infinity,maxHeight: 40)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedItem = index
                    }
            }
            Button {
                addAction()
            } label: {
                ZStack(alignment: .center) {
                    RoundedRectangle(cornerRadius: 10, style: .circular)
                        .frame(width: 41, height: 30)
                        .foregroundStyle(Color.accent)
                    Image(systemName: "plus")
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.plain)


            ForEach(0 ..< rightItems.count, id: \.self) { index in
                textItem(rightItems[index], selected: selectedItem == leftItems.count + index)
                    .frame(maxWidth: .infinity,maxHeight: 40)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedItem = index + leftItems.count
                    }
            }
        }
        .animation(.easeInOut, value: selectedItem)
        .padding(.horizontal, 16)
        .padding(.bottom,self.safeAreaInsets.bottom)
        .background{
            FlyBlurView(effect: .systemChromeMaterial)
        }
    }

    private func textItem(_ text: String, selected: Bool) -> some View {
        Text(text)
            .font(.system(size: selected ? 18 : 16, weight: .medium))
            .foregroundStyle(selected ? Color.flyText : Color.flyTextGray)
    }
}

struct FlyNavigationBarPreview: View {
    @State var curItem: Int = 0
    var body: some View {
        ZStack {
            Text("Helloawdasda")
                .font(.system(size: 40))
            FlyNavigationBar(
                selectedItem: $curItem,
                leftItems: ["首页", "资讯"],
                rightItems: ["圈圈", "我的"],
                addAction: {
                    
                }
            )

        }
    }
}


#Preview {
    FlyNavigationBarPreview()
}
