// 🧭 Linked core views: Contacts, Map, AI, Game, Resource
import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            ContactsView()
                .tabItem {
                    Label("Contacts", systemImage: "person.3.fill")
                }

            LocationMainView()
                .tabItem {
                    Label("Map", systemImage: "map.fill")
                }

            AIChatView()
                .tabItem {
                    Label("AI", systemImage: "brain.head.profile")
                }

            GameMenuView() // ✅ 改返呢個位置，唔好再係 QuizGameView
                .tabItem {
                    Label("Game", systemImage: "gamecontroller.fill")
                }

            ResourceView()
                .tabItem {
                    Label("Resources", systemImage: "book.fill")
                }
        }
    }
}
