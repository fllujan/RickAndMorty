@testable import RickAndMorty

struct MockInfo {
    
    static func anInfo() -> Info {
        Info(count: 2, pages: 1, next: "https://rickandmortyapi.com/api/character?page=2", prev: "https://rickandmortyapi.com/api/character?page=1")
    }
}
