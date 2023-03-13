import Foundation

struct Episode: Identifiable {
    let id: Int
    let name: String
    let airDate: String
    let episodeNumber: String
}

extension EpisodeDto {
    var toEpisode: Episode {
        Episode(id: self.id, name: self.name, airDate: self.air_date, episodeNumber: self.episode)
    }
}

extension Array where Element == EpisodeDto {
    var toEpisodes: [Episode] {
        self.map { $0.toEpisode }
    }
}
