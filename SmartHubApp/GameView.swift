import SwiftUI

struct QuizQuestion {
    var q: String
    var options: [String]
    var answer: Int
}

struct GameView: View {
    @State private var current = 0
    @State private var score = 0
    @State private var end = false

    let questions = [
        QuizQuestion(q: "SHAPE 校園位於邊個地區？", options: ["沙田", "長沙灣", "屯門"], answer: 0),
        QuizQuestion(q: "SHAPE 的全名是？", options: ["School for Higher and Professional Education", "Student Hub App Portal Education", "Smart Human App Project Education"], answer: 0),
        QuizQuestion(q: "校園最近嘅地鐵站？", options: ["沙田圍站", "大圍站", "旺角站"], answer: 0),
        QuizQuestion(q: "Canteen 有咩推薦？", options: ["咖喱飯", "沙嗲牛麵", "菠蘿包"], answer: 0),
        QuizQuestion(q: "Library 可以做咩？", options: ["借書、上網、溫習", "打波", "食飯"], answer: 0),
        QuizQuestion(q: "邊科係 SHAPE 最受歡迎？", options: ["IT", "Design", "Business"], answer: 0),
        QuizQuestion(q: "學校 Wi-Fi 名叫？", options: ["VTC-Students", "ShapeFreeWiFi", "Campus Net"], answer: 0),
        QuizQuestion(q: "校園景點？", options: ["亞公角山", "獅子山", "太平山"], answer: 0),
        QuizQuestion(q: "運動館用途係？", options: ["籃球／羽毛球", "食堂", "圖書館"], answer: 0),
        QuizQuestion(q: "SHAPE 合作大學？", options: ["英國大學", "美國大學", "日本大學"], answer: 0)
    ].shuffled()

    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
                Text("🎯 SHAPE 校園問答挑戰")
                    .font(.title)
                Text(questions[current].q)
                    .multilineTextAlignment(.center)
                    .padding()

                ForEach(0..<questions[current].options.count, id: \.self) { i in
                    Button(questions[current].options[i]) {
                        selectAnswer(i)
                    }
                    .buttonStyle(.borderedProminent)
                }

                Text("題目 \(current + 1)/\(questions.count)")
                Text("分數：\(score)")
            }
            .alert("完成啦！🥳", isPresented: $end) {
                Button("再玩一次") {
                    score = 0
                    current = 0
                }
            } message: {
                Text("你嘅分數：\(score) / \(questions.count)")
            }
            .navigationTitle("🎮 校園問答")
            .padding()
        }
    }

    func selectAnswer(_ choice: Int) {
        if choice == questions[current].answer {
            score += 1
        }
        if current + 1 == questions.count {
            end = true
        } else {
            current += 1
        }
    }
}
