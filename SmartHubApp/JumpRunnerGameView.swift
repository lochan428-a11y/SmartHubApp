import SwiftUI

struct JumpRunnerGameView: View {
    @State private var playerY: CGFloat = 0
    @State private var obstacleX: CGFloat = 300
    @State private var score = 0
    @State private var gameOver = false

    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color.green.opacity(0.2))
                    .ignoresSafeArea()

                VStack {
                    Text("🏃 跳動角色閃避賽")
                        .font(.title2)
                        .bold()
                        .padding()

                    ZStack {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 40, height: 40)
                            .offset(y: playerY)
                        Rectangle()
                            .fill(Color.red)
                            .frame(width: 30, height: 40)
                            .offset(x: obstacleX, y: 20)
                    }
                    .frame(width: 300, height: 150)
                    .border(Color.gray)
                    .onTapGesture { jump() }
                }

                VStack {
                    Spacer()
                    Text("分數：\(score)")
                    Spacer().frame(height: 50)
                }
            }
        }
        .onAppear(perform: startGame)
        .alert("💀 Game Over!", isPresented: $gameOver) {
            Button("再玩一次") { resetGame() }
        } message: {
            Text("你得分 \(score)")
        }
    }

    func jump() {
        guard playerY == 0 else { return }
        withAnimation(.easeOut(duration: 0.3)) { playerY = -60 }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            withAnimation(.easeIn(duration: 0.3)) { playerY = 0 }
        }
    }

    func startGame() {
        Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { t in
            obstacleX -= 4
            if obstacleX < -180 {
                obstacleX = 300
                score += 1
            }
            // 撞擊判斷
            if abs(obstacleX) < 40 && playerY > -20 {
                t.invalidate()
                gameOver = true
            }
        }
    }

    func resetGame() {
        obstacleX = 300
        score = 0
        gameOver = false
        startGame()
    }
}
