struct Episode: Identifiable {
    let id: Int
    let name: String
    let airDate: String
    let episodeNumber: String
}

extension EpisodeDto {
    var toEpisode: Episode {
        Episode(id: self.id ?? 0,
                name: self.name ?? "title_not_available".localized(),
                airDate: self.air_date ?? "date_not_available".localized(),
                episodeNumber: self.episode ?? "number_not_available".localized())
    }
}

extension Array where Element == EpisodeDto {
    var toEpisodes: [Episode] {
        self.map { $0.toEpisode }
    }
}

extension EpisodeDB {
    var toEpisode: Episode {
        Episode(id: Int(self.id),
                name: self.name ?? "title_not_available".localized(),
                airDate: self.airDate ?? "date_not_available".localized(),
                episodeNumber: self.episodeNumber ?? "number_not_available".localized())
    }
}

extension Array where Element == EpisodeDB {
    var toEpisodes: [Episode] {
        self.map { $0.toEpisode }
    }
}
