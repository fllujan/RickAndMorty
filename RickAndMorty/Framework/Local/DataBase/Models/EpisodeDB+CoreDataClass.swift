import Foundation
import CoreData

@objc(EpisodeDB)
public class EpisodeDB: NSManagedObject {

    func setEpisode(characterDB: CharacterDB, episode: Episode) {
        id = Int64(episode.id)
        name = episode.name
        airDate = episode.airDate
        episodeNumber = episode.episodeNumber
        addToCharacters(characterDB)
    }
}
