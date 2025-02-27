import SwiftUI

struct NavigationStackModifier<T: Route>: ViewModifier {
    @ObservedObject var coordinator: BaseCoordinator<T>
    
    func body(content: Content) -> some View {
        NavigationStack(path: $coordinator.path) {
            content
                .navigationDestination(for: T.self) { route in
                    coordinator.view(for: route)
                }
        }
        .environmentObject(coordinator)
    }
}

extension View {
    func withNavigationStack<T: Route>(coordinator: BaseCoordinator<T>) -> some View {
        modifier(NavigationStackModifier(coordinator: coordinator))
    }
} 
