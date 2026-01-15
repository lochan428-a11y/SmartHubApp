import Foundation
import LocalAuthentication

class BiometricModel: ObservableObject {
    let context = LAContext()

    @Published var isError = false
    @Published var errorMessage = ""
    @Published var isAuthenticated = false

    func evaluatePolicy() {
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: "請使用 Face ID 或 Touch ID 登入 SmartHub") { success, error in
                DispatchQueue.main.async {
                    if success {
                        self.isAuthenticated = true
                        self.isError = false
                    } else {
                        self.isError = true
                        self.errorMessage = error?.localizedDescription ?? "認證失敗"
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                self.isError = true
                self.errorMessage = error?.localizedDescription ?? "未能啟用生物認證"
            }
        }
    }
}
