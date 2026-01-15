// 🗞️ Added announcement and useful resource links
import SwiftUI

struct Announcement: Identifiable {
    let id = UUID()
    var title: String
    var date: String
    var content: String
}

struct AnnouncementView: View {
    let announcements = [
        Announcement(title: "🎓 新生迎新日", date: "2026-01-20", content: "新生可於禮堂參加導覽活動。"),
        Announcement(title: "📚 Moodle 登入提示", date: "2026-01-21", content: "請使用 VTC 帳號登入 Moodle。"),
        Announcement(title: "🏫 校園安全週", date: "2026-01-23", content: "留意消防演習及安全指示。"),
        Announcement(title: "💻 IT 學系研討會", date: "2026-01-25", content: "CyberSecurity 講座，請同學報名參加。"),
        Announcement(title: "🏆 比賽報名", date: "2026-02-02", content: "SHAPE Hackathon 截止報名日期：2月8日。"),
        Announcement(title: "📆 公假通知", date: "2026-02-10", content: "農曆新年假期由2月15日至19日。"),
        Announcement(title: "🎤 Talent Show", date: "2026-03-01", content: "接受學生報名表演項目。"),
        Announcement(title: "📑 學期測驗", date: "2026-03-10", content: "請查看 Moodle 公告的測驗時間表。"),
        Announcement(title: "🧾 繳費提醒", date: "2026-03-15", content: "第二學期學費繳交截止日3月20日。"),
        Announcement(title: "🌱 校園清潔日", date: "2026-03-28", content: "鼓勵學生參加環保淨化校園活動。")
    ]

    var body: some View {
        NavigationStack {
            List(announcements) { a in
                VStack(alignment: .leading, spacing: 6) {
                    Text(a.title).font(.headline)
                    Text(a.date).font(.caption).foregroundColor(.gray)
                    Text(a.content).font(.body)
                }
                .padding(.vertical, 4)
            }
            .navigationTitle("📢 校園通告")
        }
    }
}
