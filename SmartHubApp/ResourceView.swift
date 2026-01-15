import SwiftUI

struct ResourceView: View {
    let links = [
        ("SHAPE Portal", "https://www.shape.edu.hk/"),
        ("Moodle", "https://fs.vtc.edu.hk/adfs/ls/?SAMLRequest=lZJbT8MwDIX%2FSpX3Nk27Doi2SWMTYhKXiQ0eeEEhcVlEm5TY5fLv6ToQTAIk3iLH3%2FHxkUeo6qqR05Y27gqeWkCKXuvKoew%2FxqwNTnqFFqVTNaAkLVfT8zOZJalsgievfcW%2BIX8TChECWe9YtJiP2Z0w5VCAHqqDQogCUm3yVBXZoc5EUQwGQh9lZZ6bfDBk0Q0E7Mgx64Q6HLGFhUNSjrpSmg3jVMRisBZC5gcyO7pl0bzbxjpFPbUhalByXmLyTDoB0yabR65MibxCzqLpp7WZd9jWEFYQnq2G66uzL7j23lQQU3B7Il16fLt8FhrFsdm9Y6UxaTbNzxCLlh%2FpHVtnrHv4O7j7XRPK0%2FV6GS8vV2s2GW3HyD6IMPmnwxpIGUVqa3DEvwuNdhdx0VlYzJe%2BsvotOvGhVvS7Q5GIvmJNXPatsnXYgLalBdNFW1X%2BZRZAEYwZhRYYn%2ByG7l%2Fe5B0%3D&RelayState=https%3A%2F%2Fmoodle-trn.vtc.edu.hk%2Fauth%2Fsaml2rpa%2Flogin.php%3Fwants%26idp%3D23a1b87709dc35d458d4ad045a53ad28%26passive%3Doff&SigAlg=http%3A%2F%2Fwww.w3.org%2F2001%2F04%2Fxmldsig-more%23rsa-sha256&Signature=Y%2B6JIq0C6lV2W676okzsEKf62rwXK583KYtH%2F2v4dq6D8soZtTTeIhyHPQnc6cJ0wyvaCHLyDOWv6dpN7%2BqFGcuBlQiicMLBeZHRAUf689vOGJ2bFLCcelFsSjpu1zGLioJPsAUP9LZfe%2BXcf2WaQZs2HvGDXbZPlOqrRXtZTqsuH9QWTrzoRdOeKcfeBktDxtMGE4lpsSge48LOfcMuxJ3wBRF1504TSZymRM9h6XVEeIaKwJ25eOZZRAHCZC%2BsAR4RJHE7LKcwgPddfJPjRiHQmEFECq2NyExpY6nWdJLgGYG89e%2BxcWqp2Xh%2Bg%2FrOkqJaPNXZFiU0lnMy2foUfg%3D%3D"),
        ("Library", "https://library.vtc.edu.hk/"),
        ("Student Email", "https://outlook.office.com/"),
        ("Career Service", "https://www.vtc.edu.hk/admission/")
    ]

    var body: some View {
        NavigationStack {
            List(links, id: \.0) { link in
                if let url = URL(string: link.1) {
                    Link(destination: url) {
                        Label(link.0, systemImage: "link")
                    }
                }
            }
            .navigationTitle("📚 學習資源")
        }
    }
}
