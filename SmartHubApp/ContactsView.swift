import SwiftUI

struct ContactsView: View {
    @EnvironmentObject var data: DataManager
    @AppStorage("loggedInID") var loggedInID = ""

    var body: some View {
        NavigationStack {
            VStack {
                if data.students.isEmpty {
                    VStack(spacing: 15) {
                        Text("📭 暫時未有學生資料")
                            .foregroundColor(.gray)
                        Text("請登入／登記學生以繼續使用 SmartHub 功能")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding(.bottom, 10)

                        Button("🔑 前往登入／登記頁") {
                            loggedInID = "" // ❗️清除登入資料
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                } else {
                    List {
                        ForEach(data.students) { s in
                            VStack(alignment: .leading, spacing: 4) {
                                Text("🆔 \(s.studentID)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Text(s.name)
                                    .font(.headline)
                                Text("電話：\(s.phone)")
                                    .foregroundColor(.blue)
                                Text("學年：\(s.className)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.vertical, 4)
                        }
                        .onDelete(perform: deleteStudent)
                    }
                }

                Spacer()

                // 🚪 登出按鈕
                Button(role: .destructive) {
                    loggedInID = ""
                } label: {
                    Label("登出 SmartHub", systemImage: "rectangle.portrait.and.arrow.right")
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
                .padding(.bottom, 20)
            }
            .navigationTitle("🎓 學生名單")
        }
    }

    private func deleteStudent(at offsets: IndexSet) {
        data.students.remove(atOffsets: offsets)
    }
}

#Preview {
    ContactsView()
        .environmentObject(DataManager())
}
