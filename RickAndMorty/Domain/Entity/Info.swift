import Foundation

struct Info {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

extension InfoModel {
    var toInfo: Info {
        Info(count: self.count, pages: self.pages, next: self.next, prev: self.prev)
    }
}
