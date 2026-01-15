import Foundation

class AIManager {
    private let apiKey = Bundle.main.object(forInfoDictionaryKey: "DEEPSEEK_API_KEY") as? String ?? ""

    func askDeepSeek(message: String, completion: @escaping (String) -> Void) {

        guard !apiKey.isEmpty else {
            DispatchQueue.main.async {
                completion("❌ 找不到 DEEPSEEK_API_KEY，請到 Info.plist 新增。")
            }
            print("⚠️ DEEPSEEK_API_KEY is missing in Info.plist")
            return
        }

        let urlString = "https://api.deepseek.com/v1/chat/completions"

        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async { completion("❌ API URL 錯誤") }
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = 30
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        let body: [String: Any] = [
            "model": "deepseek-chat",
            "messages": [
                ["role": "system", "content": "你係 SHAPE SmartHub 校園 AI 助手，負責回答關於校園問題。"],
                ["role": "user", "content": message]
            ]
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        } catch {
            print("⚠️ JSON 格式錯誤：\(error)")
            DispatchQueue.main.async { completion("⚠️ Request 格式錯誤。") }
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in

            if let error = error as NSError? {
                print("❌ Request 錯誤：\(error), code=\(error.code)")
                DispatchQueue.main.async {
                    completion("❌ 無法連接伺服器：\(error.localizedDescription)")
                }
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async { completion("⚠️ 未獲得伺服器回應。") }
                return
            }

            print("🌍 API 回應狀態：\(httpResponse.statusCode)")

            // 非 2xx：把 body 打出嚟（通常會有錯誤原因）
            guard (200...299).contains(httpResponse.statusCode) else {
                let bodyText = data.flatMap { String(data: $0, encoding: .utf8) } ?? "(no body)"
                print("⚠️ 非 2xx body: \(bodyText)")
                DispatchQueue.main.async {
                    completion("⚠️ 伺服器回應錯誤：\(httpResponse.statusCode)")
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async { completion("⚠️ 伺服器冇回傳資料。") }
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let choices = json["choices"] as? [[String: Any]],
                   let msg = choices.first?["message"] as? [String: Any],
                   let reply = msg["content"] as? String {
                    DispatchQueue.main.async {
                        completion(reply.trimmingCharacters(in: .whitespacesAndNewlines))
                    }
                } else {
                    print("⚠️ JSON 回應格式不符：\(String(data: data, encoding: .utf8) ?? "")")
                    DispatchQueue.main.async { completion("⚠️ AI 沒有回應。") }
                }
            } catch {
                print("⚠️ JSON 解析錯誤：\(error)")
                DispatchQueue.main.async { completion("⚠️ 讀取回應資料錯誤。") }
            }

        }.resume()
    }
}
