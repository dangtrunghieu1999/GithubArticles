import Foundation

protocol DIContainerProtocol {
    func register<T>(_ type: T.Type, instance: T)
    func resolve<T>() -> T
}

final class DIContainer: DIContainerProtocol {
    private var containers: [String: Any] = [:]
    
    static let shared = DIContainer()
    
    private init() {}
    
    func register<T>(_ type: T.Type, instance: T) {
        let key = String(describing: type)
        containers[key] = instance
    }
    
    func resolve<T>() -> T {
        let key = String(describing: T.self)
        guard let instance = containers[key] as? T else {
            fatalError("No instance for type \(T.self) was registered")
        }
        return instance
    }
} 
