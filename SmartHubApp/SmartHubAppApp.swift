import SwiftUI

@main
struct SmartHubApp: App {
    @StateObject var data = DataManager()
    @AppStorage("loggedInID") var loggedInID = ""
    @State private var isReady = false

    var body: some Scene {
        WindowGroup {
            Group {
                if !isReady {
                    // 🕐 Loading 畫面
                    VStack {
                        ProgressView("載入中…")
                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                            .padding()
                        Text("SmartHub 啟動中…")
                            .foregroundColor(.gray)
                            .font(.callout)
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            isReady = true
                        }
                    }
                } else {
                    // 🎯 登入流程控制
                    if loggedInID.isEmpty || !data.students.contains(where: { $0.studentID == loggedInID }) {
                        LoginView()
                            .environmentObject(data)
                    } else {
                        MainTabView()
                            .environmentObject(data)
                    }
                }
            }
        }
    }
}
