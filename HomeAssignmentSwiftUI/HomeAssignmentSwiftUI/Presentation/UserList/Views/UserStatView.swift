import SwiftUI
import NetworkService

struct UserStatView: View {
    let title: String
    let value: Int
    
    var body: some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.system(size: 14))
                .foregroundColor(.gray)
            
            Text("\(value)")
                .font(.system(size: 20, weight: .bold))
        }
    }
}
