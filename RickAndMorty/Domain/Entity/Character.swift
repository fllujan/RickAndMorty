import Foundation

typealias CharacterAndInfo = (characters: [Character], info: Info)

struct Character {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Location
    let location: Location
    let image: String
    let episodeId: [String]
    let url: String
    let created: String
}


extension CharacterModel {
    var toCharacter: Character {
        Character(
            id: self.id,
            name: self.name,
            status: self.status,
            species: self.species,
            type: self.type,
            gender: self.gender,
            origin: Location(name: self.origin.name, url: self.origin.url),
            location: Location(name: self.location.name, url: self.location.url),
            image: self.image,
            episodeId: self.episode,
            url: self.url,
            created: self.created
        )
    }
}

extension CharacterDto {
    var toCharacterAndInfo: CharacterAndInfo {
        CharacterAndInfo(characters: self.results.map { $0.toCharacter }, info: self.info.toInfo)
    }
}
