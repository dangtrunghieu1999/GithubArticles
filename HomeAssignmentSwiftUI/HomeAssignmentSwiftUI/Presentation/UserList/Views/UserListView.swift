import SwiftUI
import NetworkService

struct UserListView: View {
    @StateObject var viewModel: UserListViewModel
    @EnvironmentObject var coordinator: UserCoordinator
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                ForEach(viewModel.users) { user in
                    UserRowView(user: user)
                        .onTapGesture {
                            coordinator.push(.detail(userId: user.id))
                        }
                }
            }
            .navigationTitle("Github Users")
            .task {
                await viewModel.loadInitialData()
            }
        }
    }
}
