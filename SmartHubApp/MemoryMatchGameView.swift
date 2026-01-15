import SwiftUI

struct Card: Identifiable {
    let id = UUID()
    var emoji: String
    var isFlipped: Bool = false
    var isMatched: Bool = false
}

struct MemoryMatchGameView: View {
    @State private var cards: [Card] = []
    @State private var flippedIndexes: [Int] = []
    @State private var score = 0

    var body: some View {
        VStack {
            Text("🧩 記憶配對遊戲")
                .font(.title2)
                .bold()
                .padding()

            LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]) {
                ForEach(0..<cards.count, id: \.self) { i in
                    ZStack {
                        if cards[i].isFlipped || cards[i].isMatched {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.green.opacity(0.3))
                            Text(cards[i].emoji).font(.largeTitle)
                        } else {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.blue.opacity(0.7))
                        }
                    }
                    .frame(width: 70, height: 80)
                    .onTapGesture {
                        flipCard(i)
                    }
                }
            }
            .padding()

            Text("得分：\(score)").padding()

            Button("重新開始 🔁") {
                resetGame()
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .onAppear(perform: resetGame)
    }

    func flipCard(_ index: Int) {
        guard !cards[index].isFlipped, flippedIndexes.count < 2 else { return }
        cards[index].isFlipped = true
        flippedIndexes.append(index)

        if flippedIndexes.count == 2 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                let first = flippedIndexes[0]
                let second = flippedIndexes[1]
                if cards[first].emoji == cards[second].emoji {
                    cards[first].isMatched = true
                    cards[second].isMatched = true
                    score += 1
                } else {
                    cards[first].isFlipped = false
                    cards[second].isFlipped = false
                }
                flippedIndexes.removeAll()
            }
        }
    }

    func resetGame() {
        let emojis = ["🐶","🐱","🐭","🐹","🐰","🐸"]
        let paired = (emojis + emojis).shuffled()
        cards = paired.map { Card(emoji: $0) }
        score = 0
    }
}
