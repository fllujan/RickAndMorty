import CoreData

extension CoreDataBase {
    
    func save() {
        do {
            try context.save()
        } catch {
            context.rollback()
        }
    }
    
    func getAll<T: NSManagedObject>() -> [T] {
        do {
            let request = T.fetchRequest()
            let data = try context.fetch(request)
            return (data as? [T]) ?? []
        } catch {
            return []
        }
    }
    
    func findById<T: NSManagedObject>(_ id: Int) -> T? {
        let request = T.fetchRequest()
        request.predicate = NSPredicate(format: "id = %i", id)
        
        do {
            let result = try context.fetch(request)
            return (result.first as? T) ?? nil
        } catch {
            return nil
        }
    }
}
