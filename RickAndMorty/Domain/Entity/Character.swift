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
    let episodeIds: String
    let url: String
    let created: String
}

extension CharacterModel {
    var toCharacter: Character {
        Character(
            id: self.id ?? 0,
            name: self.name ?? "title_not_available".localized(),
            status: self.status ?? "status_not_available".localized(),
            species: self.species ?? "species_not_available".localized(),
            type: self.type ?? "type_not_available".localized(),
            gender: self.gender ?? "gender_not_available".localized(),
            origin: Location(name: self.origin?.name ?? "title_not_available".localized(), url: self.origin?.url ?? ""),
            location: Location(name: self.location?.name ?? "title_not_available".localized(), url: self.location?.url ?? ""),
            image: self.image ?? "",
            episodeIds: self.episode != nil ? self.episode!.formatEpisodes() : "",
            url: self.url ?? "",
            created: self.created ?? ""
        )
    }
}

extension CharacterDto {
    var toCharacterAndInfo: CharacterAndInfo {
        CharacterAndInfo(characters: self.results.map { $0.toCharacter }, info: self.info.toInfo)
    }
}

extension CharacterDB {
    var toCharacter: Character {
        return Character(
            id: Int(self.id),
            name: self.name ?? "title_not_available".localized(),
            status: self.status ?? "status_not_available".localized(),
            species: self.species ?? "species_not_available".localized(),
            type: self.type ?? "type_not_available".localized(),
            gender: self.gender ?? "gender_not_available".localized(),
            origin: Location(name: self.originName ?? "title_not_available".localized(), url: self.originUrl ?? ""),
            location: Location(name: self.locationName ?? "title_not_available".localized(), url: self.locationUrl ?? ""),
            image: self.image ?? "",
            episodeIds: self.episodeIds ?? "",
            url: self.url ?? "",
            created: self.created ?? ""
        )
    }
}

extension Array where Element == CharacterDB {
    var toCharacterAndInfo: CharacterAndInfo {
        CharacterAndInfo(characters: self.map { $0.toCharacter }, Info(count: 0, pages: 0, next: nil, prev: nil))
    }
}
