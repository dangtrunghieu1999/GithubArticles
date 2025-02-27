//
//  ContentView.swift
//  HomeAssignmentSwiftUI
//
//  Created by Kai on 26/2/25.
//

import SwiftUI
import NetworkService
import HomeUserListUseCase
import HomeUerListRepository

struct ContentView: View {
    @StateObject private var coordinator: UserCoordinator
    
    init() {
        // Register dependencies
        let container = DIContainer.shared
        let repository = HomeUserListRepositoryImpl(networkService: URLSessionNetworkService())
        
        container.register(HomeGetUsersUseCase.self, instance: HomeGetUsersUseCaseImpl(repository: repository))
        
        // Initialize coordinator
        _coordinator = StateObject(
            wrappedValue: UserCoordinator(container: container)
        )
    }
    
    var body: some View {
        coordinator.view(for: .list)
            .withNavigationStack(coordinator: coordinator)
    }
}
