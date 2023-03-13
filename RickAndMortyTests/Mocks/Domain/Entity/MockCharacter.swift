import Foundation
@testable import RickAndMorty

struct MockCharacter {
    
    static func anCharacter() -> Character {
        Character(id: 1,
                  name: "Rick Sanche",
                  status: "Alive",
                  species: "Human",
                  type: "",
                  gender: "Male",
                  origin: Location(name: "Locatio", url: "name"),
                  location: Location(name: "name", url: "url"),
                  image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
                  episodeId:[ "10,11"], url: "", created: ""
        )
    }
}
