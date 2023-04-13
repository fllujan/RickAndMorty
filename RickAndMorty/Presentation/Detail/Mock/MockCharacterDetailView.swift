struct MockCharacterDetailView {
    
    static func mockCharacter() -> Character {
        Character(id: 1,
                  name: "Rick Sanche",
                  status: "Alive",
                  species: "Human",
                  type: "",
                  gender: "Male",
                  origin: Location(name: "Locatio", url: "name"),
                  location: Location(name: "name", url: "url"),
                  image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
                  episodeIds: "10,11", url: "", created: ""
        )
    }
    
    static func mockEpisode(name: String = "Pilos") -> Episode {
        Episode(id: 1,
                name: name,
                airDate: "December 2, 2012",
                episodeNumber: "S01E01"
        )
    }
}
