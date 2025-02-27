import Foundation
import HomeUserListUseCase
import SwiftUI

final class UserListViewModel: ObservableObject {
    // MARK: - Types
    enum State {
        case idle
        case loading
        case loaded([User])
        case error(Error)
    }
    
    // MARK: - Properties
    private let getUsersUseCase: HomeGetUsersUseCase
    private var currentPage = 0
    private let perPage = 20
    private var hasMorePages = true
    
    @Published private(set) var state: State = .idle
    @Published private(set) var users: [User] = []
    @Published var isLoading = false
    
    init(getUsersUseCase: HomeGetUsersUseCase) {
        self.getUsersUseCase = getUsersUseCase
    }
    
    // MARK: - Public Methods
    func loadInitialData() async {
        await loadData(page: 0)
    }
    
    func loadMore() async {
        guard !isLoading && hasMorePages else { return }
        await loadData(page: currentPage)
    }
    
    func refresh() async {
        currentPage = 0
        users.removeAll()
        hasMorePages = true
        await loadData(page: 0)
    }
    
    // MARK: - Private Methods
    @MainActor
    private func loadData(page: Int) async {
        isLoading = true
        state = .loading
        
        do {
            let since = page * perPage
            let newUsers = try await getUsersUseCase.fetchUserList(since: since, perPage: perPage)
            users.append(contentsOf: newUsers)
            currentPage += 1
            hasMorePages = newUsers.count == perPage
            state = .loaded(users)
        } catch {
            state = .error(error)
        }
        
        isLoading = false
    }
}
