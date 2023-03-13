import Foundation
@testable import RickAndMorty

struct MockEpisode {
    
    static func anEpisode(name: String = "Pilot") -> Episode {
        Episode(id: 1,
                name: name,
                airDate: "December 2, 2013",
                episodeNumber: "S01E01"
        )
    }
}
