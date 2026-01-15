import SwiftUI

struct GameMenuView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
                Text("🎮 SmartHub 小遊戲中心")
                    .font(.title)
                    .bold()
                    .padding()

                NavigationLink("🧠 MC 問答挑戰", destination: QuizGameView())
                    .buttonStyle(.borderedProminent)

                NavigationLink("🗺️ SHAPE 地圖猜題遊戲", destination: MapGuessGameView())
                    .buttonStyle(.bordered)

                NavigationLink("🧩 記憶配對遊戲", destination: MemoryMatchGameView())
                    .buttonStyle(.bordered)

                NavigationLink("🏃 跳動角色閃避賽", destination: JumpRunnerGameView())
                    .buttonStyle(.bordered)

                Spacer()

                Text("選擇一款遊戲開始挑戰！")
                    .foregroundColor(.gray)
                    .padding(.bottom, 40)
            }
            .navigationTitle("遊戲中心")
        }
    }
}
