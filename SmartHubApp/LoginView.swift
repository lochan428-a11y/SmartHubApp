import SwiftUI

struct LoginView: View {
    @EnvironmentObject var data: DataManager
    @AppStorage("loggedInID") var loggedInID = ""

    @State private var newID = ""
    @State private var newName = ""
    @State private var newClass = ""
    @State private var newPhone = ""
    @State private var inputID = ""
    @State private var errorMsg = ""

    @StateObject private var bioModel = BiometricModel()   // 👈 新增

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 25) {
                    Text("📲 SmartHub 登入／登記系統")
                        .font(.title2)
                        .bold()
                        .padding(.top, 30)

                    // 🔑 登入框
                    VStack(spacing: 10) {
                        TextField("輸入學生 ID 登入", text: $inputID)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)

                        Button("登入") { login() }
                            .buttonStyle(.borderedProminent)
                            .tint(.blue)

                        // 👇 新增 Face/Touch ID 登入按鈕
                        Button("🔒 使用 Face ID / Touch ID 登入") {
                            bioModel.evaluatePolicy()
                        }
                        .buttonStyle(.bordered)
                        .tint(.indigo)
                        .padding(.top, 5)
                        .onChange(of: bioModel.isAuthenticated) { success in
                            if success {
                                // 假設之前入過 inputID
                                if !inputID.isEmpty {
                                    loggedInID = inputID
                                }
                            }
                        }

                        if bioModel.isError {
                            Text("⚠️ \(bioModel.errorMessage)")
                                .foregroundColor(.red)
                        }

                        if !errorMsg.isEmpty {
                            Text(errorMsg)
                                .foregroundColor(.red)
                                .font(.subheadline)
                                .padding(.top, 3)
                        }
                    }

                    Divider().padding(.vertical, 10)

                    // 🆕 登記新生
                    VStack(alignment: .leading, spacing: 10) {
                        Text("🆕 新學生登記")
                            .bold()
                            .font(.headline)

                        Group {
                            TextField("學生 ID", text: $newID)
                            TextField("姓名", text: $newName)
                            TextField("班別（例：IT101）", text: $newClass)
                            TextField("電話號碼", text: $newPhone)
                        }
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                        Button("新增並登入") {
                            registerAndLogin()
                        }
                        .buttonStyle(.bordered)
                        .tint(.green)
                        .padding(.top, 5)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.horizontal)

                    // 📋 已登記學生清單
                    VStack(alignment: .leading, spacing: 5) {
                        Text("📋 已登記學生")
                            .bold()
                            .font(.headline)
                            .padding(.leading)

                        if data.students.isEmpty {
                            Text("（暫時未有學生資料）")
                                .foregroundColor(.gray)
                                .padding(.leading)
                        } else {
                            ForEach(data.students) { s in
                                VStack(alignment: .leading, spacing: 3) {
                                    Text("\(s.name)（\(s.studentID)）")
                                        .font(.subheadline)
                                        .bold()
                                    Text("☎️ \(s.phone)   \(s.className)")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                                .background(Color.white.opacity(0.95))
                                .cornerRadius(6)
                            }
                        }
                    }
                    .padding(.bottom, 40)
                }
            }
            .background(Color.gray.opacity(0.08))
            .navigationTitle("SmartHub 登入")
        }
    }

    func login() {
        guard !inputID.isEmpty else {
            errorMsg = "⚠️ 請輸入學生 ID"
            return
        }
        if data.students.contains(where: { $0.studentID == inputID }) {
            loggedInID = inputID
            errorMsg = ""
        } else {
            errorMsg = "❌ 未登記此 ID"
        }
    }

    func registerAndLogin() {
        guard !newID.isEmpty, !newName.isEmpty, !newClass.isEmpty, !newPhone.isEmpty else {
            errorMsg = "⚠️ 請填寫所有欄位"
            return
        }

        let student = Student(studentID: newID, name: newName, className: newClass, phone: newPhone)
        data.addStudent(student)
        loggedInID = newID
        errorMsg = ""
    }
}
