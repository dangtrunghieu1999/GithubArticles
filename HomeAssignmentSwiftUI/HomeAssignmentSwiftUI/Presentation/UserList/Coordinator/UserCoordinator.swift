import SwiftUI      

final class UserCoordinator: BaseCoordinator<UserRoute> {
    private let container: DIContainerProtocol
    
    init(container: DIContainerProtocol) {
        self.container = container
        super.init()
    }
    
    @ViewBuilder
    override func view(for route: UserRoute) -> AnyView {
        AnyView(
            Group {
                switch route {
                case .list:
                    UserListView(
                        viewModel: UserListViewModel(
                            getUsersUseCase: self.container.resolve()
                        )
                    )
                case .detail(let userId):
                    Text("Details for user \(userId)")
                }
            }
        )
    }
} 
