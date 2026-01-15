// 🤖 Connected to DeepSeek API for AI chat response
import SwiftUI

struct Message: Identifiable {
    let id = UUID()
    let text: String
    let isUser: Bool
}

struct AIChatView: View {
    @State private var messages: [Message] = [
        Message(text: "你好，我係 SmartHub AI 助手～ 😊", isUser: false)
    ]
    @State private var inputText: String = ""

    var body: some View {
        VStack {
            // 聊天內容區
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(messages) { msg in
                            HStack {
                                if msg.isUser { Spacer() }
                                Text(msg.text)
                                    .padding(10)
                                    .background(msg.isUser ? Color.blue.opacity(0.8) : Color.gray.opacity(0.3))
                                    .foregroundColor(msg.isUser ? .white : .black)
                                    .cornerRadius(12)
                                    .frame(maxWidth: 250, alignment: msg.isUser ? .trailing : .leading)
                                if !msg.isUser { Spacer() }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                }
                .onChange(of: messages.count) { _ in
                    if let lastID = messages.last?.id {
                        withAnimation {
                            proxy.scrollTo(lastID, anchor: .bottom)
                        }
                    }
                }
            }

            // 下方輸入欄
            HStack {
                TextField("輸入訊息…", text: $inputText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(minHeight: 40)

                Button {
                    sendMessage()
                } label: {
                    Image(systemName: "paperplane.fill")
                        .font(.title2)
                        .foregroundColor(.blue)
                }
                .padding(.horizontal, 8)
            }
            .padding()
        }
        .navigationTitle("AI 助手")
    }

    private func sendMessage() {
        guard !inputText.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        let userMsg = Message(text: inputText, isUser: true)
        messages.append(userMsg)
        let question = inputText
        inputText = ""

        let ai = AIManager()
        ai.askDeepSeek(message: question) { reply in
            DispatchQueue.main.async {
                messages.append(Message(text: reply, isUser: false))
            }
        }
    }
}   // 👈 這個大括號記得一定要有！
