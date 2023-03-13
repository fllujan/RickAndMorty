import Foundation
@testable import RickAndMorty

struct MockCharacterDto {
    
    static func anCharacterDto() -> CharacterDto {
        CharacterDto(info: anInfoDto(), results: [anCharacterModel()])
    }
    
    static func anInfoDto() -> InfoModel {
        InfoModel(count: 826, pages: 42, next: "https://rickandmortyapi.com/api/character?page=2", prev: "https://rickandmortyapi.com/api/character?page=1")
    }
    
    static func anCharacterModel() -> CharacterModel {
        CharacterModel(id: 1,
                       name: "Rick Sanchez",
                       status: "Alive",
                       species: "Human",
                       type: "",
                       gender: "Male",
                       origin: anLocationModel(),
                       location: anLocationModel(),
                       image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
                       episode: ["10,11"],
                       url: "",
                       created: ""
        )
    }
    
    static func anLocationModel() -> LocationModel {
        LocationModel(name: "name", url: "url")
    }
    
}
