//
//  ProfileAddTagButton.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/25.
//

import SwiftUI

struct ProfileAddTagButton: View {
    let showText: Bool
    let action: () -> Void
    init(showText: Bool, action: @escaping () -> Void) {
        self.showText = showText
        self.action = action
    }
    var body: some View {
        Button{
            action()
        }label: {
            Group {
                if showText {
                    HStack(alignment: .center,spacing: 7) {
                        addIcon
                        Text("状态")
                            .font(.system(size: 12,weight: .regular))
                            .foregroundStyle(Color.flyGray)
                    }
                    .padding(.horizontal,16)
                } else {
                    addIcon
                }
            }
            .frame(width: showText ? nil : 26,height: 26)
            .background {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.flyLightGray)
                    .foregroundStyle(Color.clear)
            }
        }
    }
    
    var addIcon: some View {
        Image(systemName: "plus")
            .resizable()
            .foregroundStyle(Color.flyGray)
            .scaledToFit()
            .frame(width: 10)
    }
}

#Preview {
    HStack {
        Spacer()

        ProfileAddTagButton(showText: true) {
            
        }
        ProfileAddTagButton(showText: false){
            
        }

    }
}
