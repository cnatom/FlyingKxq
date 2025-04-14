import SwiftUI

struct MessageInputView: View {
    @Binding var message: String
    var isLoading: Bool
    var onSend: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            TextField("输入消息...", text: $message, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .lineLimit(1...5)
                .textContentType(.none)
                .autocorrectionDisabled(true)
            
            Button(action: onSend) {
                Image(systemName: "arrow.up.circle.fill")
                    .font(.system(size: 30))
                    .foregroundColor(message.isEmpty ? .gray : .blue)
            }
            .disabled(message.isEmpty || isLoading)
        }
        .padding()
        .background(Color(.systemBackground))
    }
}

#Preview {
    MessageInputView(
        message: .constant(""),
        isLoading: false,
        onSend: {}
    )
} 
