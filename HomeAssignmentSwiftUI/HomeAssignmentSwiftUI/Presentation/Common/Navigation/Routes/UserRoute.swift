import Foundation

enum UserRoute: Route {
    case list
    case detail(userId: Int)
}

enum AuthRoute: Route {
    case login
    case register
}
