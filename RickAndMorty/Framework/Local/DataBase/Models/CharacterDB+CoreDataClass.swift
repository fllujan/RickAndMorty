import Foundation
import CoreData

@objc(CharacterDB)
public class CharacterDB: NSManagedObject {
    
    @discardableResult
    func setCharacter(character: Character) -> Self {
        id = Int64(character.id)
        name = character.name
        status = character.status
        species = character.species
        type = character.type
        gender = character.gender
        image = character.image
        url = character.url
        created = character.created
        originUrl = character.origin.url
        originName = character.origin.name
        locationUrl = character.location.url
        locationName = character.location.name
        episodeIds = character.episodeIds
        return self
    }
}
