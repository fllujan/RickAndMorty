import Foundation
import CoreData

extension CharacterDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CharacterDB> {
        return NSFetchRequest<CharacterDB>(entityName: "CharacterDB")
    }

    @NSManaged public var created: String?
    @NSManaged public var gender: String?
    @NSManaged public var id: Int64
    @NSManaged public var image: String?
    @NSManaged public var locationName: String?
    @NSManaged public var locationUrl: String?
    @NSManaged public var name: String?
    @NSManaged public var originName: String?
    @NSManaged public var originUrl: String?
    @NSManaged public var species: String?
    @NSManaged public var status: String?
    @NSManaged public var type: String?
    @NSManaged public var url: String?
    @NSManaged public var episodeIds: String?
    @NSManaged public var episodes: NSSet?
    
    public var episodesArray: [EpisodeDB] {
        let set = episodes as? Set<EpisodeDB> ?? []
        return Array(set)
    }

}

// MARK: Generated accessors for episodes
extension CharacterDB {

    @objc(addEpisodesObject:)
    @NSManaged public func addToEpisodes(_ value: EpisodeDB)

    @objc(removeEpisodesObject:)
    @NSManaged public func removeFromEpisodes(_ value: EpisodeDB)

    @objc(addEpisodes:)
    @NSManaged public func addToEpisodes(_ values: NSSet)

    @objc(removeEpisodes:)
    @NSManaged public func removeFromEpisodes(_ values: NSSet)

}
