import SwiftUI
import MapKit

struct MapQuestion: Identifiable {          // ✅ 加 Identifiable
    let id = UUID()                         // ✅ 每個地點有自己 ID
    let placeName: String
    let question: String
    let options: [String]
    let correct: Int
    let coordinate: CLLocationCoordinate2D
}

struct MapGuessGameView: View {
    @State private var current = 0
    @State private var score = 0
    @State private var showResult = false
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 22.384, longitude: 114.189),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )

    let questions = [
        MapQuestion(
            placeName: "Library",
            question: "📚 SHAPE Library 喺邊個位置？",
            options: ["Canteen 附近", "Sports Hall 隔離", "校園入口對面"],
            correct: 1,
            coordinate: CLLocationCoordinate2D(latitude: 22.3837, longitude: 114.1894)
        ),
        MapQuestion(
            placeName: "SHAPE Office",
            question: "🏢 SHAPE Office 喺邊度？",
            options: ["Library 隔離", "IVE 大樓 2 樓", "Bus Stop 對面"],
            correct: 0,
            coordinate: CLLocationCoordinate2D(latitude: 22.3833, longitude: 114.1888)
        ),
        MapQuestion(
            placeName: "Sports Hall",
            question: "🏀 邊個係 Sports Hall？",
            options: ["AVE 停車場旁邊", "Canteen 對面", "Library 樓上"],
            correct: 0,
            coordinate: CLLocationCoordinate2D(latitude: 22.3839, longitude: 114.1879)
        )
    ]

    var body: some View {
        NavigationStack {
            VStack {
                Map(
                    coordinateRegion: $region,
                    interactionModes: .all,
                    showsUserLocation: false,
                    annotationItems: [questions[current]]
                ) { q in
                    MapAnnotation(coordinate: q.coordinate) {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.red)
                            .font(.title)
                    }
                }
                .frame(height: 300)
                .cornerRadius(12)
                .padding()

                Text(questions[current].question)
                    .font(.headline)
                    .padding(.bottom, 10)

                ForEach(0..<questions[current].options.count, id: \.self) { i in
                    Button(questions[current].options[i]) {
                        checkAnswer(i)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(4)
                }

                Text("分數：\(score)")
                    .padding(.top)
            }
            .alert("✅ 完成！", isPresented: $showResult) {
                Button("再玩一次") {
                    current = 0
                    score = 0
                }
            } message: {
                Text("你答對 \(score) / \(questions.count) 題！")
            }
            .navigationTitle("🗺️ 地圖猜題遊戲")
        }
    }

    func checkAnswer(_ choice: Int) {
        if choice == questions[current].correct {
            score += 1
        }
        if current + 1 == questions.count {
            showResult = true
        } else {
            current += 1
        }
    }
}
