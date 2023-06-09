@testable import RickAndMorty

struct MockEpisodeDto {
    
    static func anEpisodeDto() -> EpisodeDto {
        EpisodeDto(id: 28,
                   name: "The Ricklantis Mixup",
                   air_date: "September 10, 2017",
                   episode: "S03E07",
                   characters: [
                    "https://rickandmortyapi.com/api/character/1",
                    "https://rickandmortyapi.com/api/character/2","https://rickandmortyapi.com/api/character/4"
                   ],
                   url: "https://rickandmortyapi.com/api/episode/28",
                   created: "2017-11-10T12:56:36.618Z"
        )
    }
}
