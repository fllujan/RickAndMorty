import Foundation

struct Env {
    enum EnvVariable: String {
        case baseURL = "BASE_URL"
    }
    
    static func variable(_ key: EnvVariable) -> String {
        Bundle.main.infoDictionary![key.rawValue] as! String
    }
}
