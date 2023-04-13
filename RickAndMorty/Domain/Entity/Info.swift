struct Info {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

extension InfoModel {
    var toInfo: Info {
        Info(count: self.count ?? 0, pages: self.pages ?? 0, next: self.next, prev: self.prev)
    }
}
