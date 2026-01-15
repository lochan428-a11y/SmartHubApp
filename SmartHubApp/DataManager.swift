import SwiftUI

struct Student: Identifiable, Codable, Equatable {
    var id = UUID()
    var studentID: String
    var name: String
    var className: String
    var phone: String
}

class DataManager: ObservableObject {
    @Published var students: [Student] = [] {
        didSet { save() }
    }

    private let saveKey = "RegisteredStudents"

    init() {
        load()
    }

    func addStudent(_ s: Student) {
        if !students.contains(where: { $0.studentID == s.studentID }) {
            students.append(s)
        }
    }

    func delete(at offsets: IndexSet) {
        students.remove(atOffsets: offsets)
    }

    private func save() {
        if let data = try? JSONEncoder().encode(students) {
            UserDefaults.standard.set(data, forKey: saveKey)
        }
    }

    private func load() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let decoded = try? JSONDecoder().decode([Student].self, from: data) {
            students = decoded
        }
    }
}
