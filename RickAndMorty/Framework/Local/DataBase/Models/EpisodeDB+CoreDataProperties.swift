import Foundation
import CoreData

extension EpisodeDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EpisodeDB> {
        return NSFetchRequest<EpisodeDB>(entityName: "EpisodeDB")
    }

    @NSManaged public var airDate: String?
    @NSManaged public var episodeNumber: String?
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var characters: NSSet

}

// MARK: Generated accessors for characters
extension EpisodeDB {

    @objc(addCharactersObject:)
    @NSManaged public func addToCharacters(_ value: CharacterDB)

    @objc(removeCharactersObject:)
    @NSManaged public func removeFromCharacters(_ value: CharacterDB)

    @objc(addCharacters:)
    @NSManaged public func addToCharacters(_ values: NSSet)

    @objc(removeCharacters:)
    @NSManaged public func removeFromCharacters(_ values: NSSet)

}
