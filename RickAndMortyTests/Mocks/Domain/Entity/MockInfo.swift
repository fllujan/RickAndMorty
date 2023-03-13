import Foundation
@testable import RickAndMorty

struct MockInfo {
    
    static func anInfo() -> Info {
        Info(count: 826, pages: 42, next: "https://rickandmortyapi.com/api/character?page=2", prev: "https://rickandmortyapi.com/api/character?page=1")
    }
}
