import SwiftUI

protocol CoordinatorProtocol: ObservableObject {
    associatedtype Route
    var path: NavigationPath { get set }
    func push(_ route: Route)
    func pop()
    func popToRoot()
    
    @ViewBuilder
    func view(for route: Route) -> AnyView
}

class BaseCoordinator<T: Route>: CoordinatorProtocol {
    @Published var path = NavigationPath()
    
    func push(_ route: T) {
        path.append(route)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    @ViewBuilder
    func view(for route: T) -> AnyView {
        AnyView(EmptyView())
    }
}
