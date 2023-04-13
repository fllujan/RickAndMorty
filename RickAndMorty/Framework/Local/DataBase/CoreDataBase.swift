import CoreData
import Combine

struct CoreDataBase: DataBaseManager {
    
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func create(characters: [Character]) {
        characters.forEach { character in
            let dto: CharacterDB = findById(character.id) ?? CharacterDB(context: context)
            dto.setCharacter(character: character)
        }
        
        save()
    }
    
    func create(episodes: [Episode], character: Character) {
        let characterDB: CharacterDB = findById(character.id) ?? CharacterDB(context: context).setCharacter(character: character)
        
        episodes.forEach { episode in
            let dto: EpisodeDB = findById(episode.id) ?? EpisodeDB(context: context)
            dto.setEpisode(characterDB: characterDB, episode: episode)
        }
        
        save()
    }
    
    func read<T: NSManagedObject>() -> Future<[T], Failure> {
        return Future<[T], Failure> { promesa in
            promesa(.success(getAll()))
        }
    }
    
    func read(character: Character) -> Future<[EpisodeDB], Failure> {
        return Future<[EpisodeDB], Failure> { promesa in
            guard let characterDB: CharacterDB = findById(character.id) else { return promesa(.success([])) }
            promesa(.success(characterDB.episodesArray))
        }
    }
}




