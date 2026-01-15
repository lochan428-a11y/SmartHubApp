import Testing
@testable import SmartHubApp

struct SmartHubAppTests {

    @Test func testAddStudent() async throws {
        let manager = DataManager()
        let student = Student(studentID: "12345", name: "Peter", className: "IT101", phone: "91234567")
        manager.addStudent(student)
        #expect(manager.students.contains(where: { $0.studentID == "12345" }))
    }
}
