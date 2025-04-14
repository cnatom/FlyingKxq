import SwiftUI

struct EmptyChatView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "bubble.left.and.bubble.right")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            Text("开始新的对话")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("在这里输入您的问题，我会尽力为您解答")
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}

#Preview {
    EmptyChatView()
} 