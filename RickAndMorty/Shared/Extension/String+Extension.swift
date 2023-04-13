import Foundation

extension String {
    
    func trim(using characterSet: CharacterSet = .whitespaces) -> String {
        self.components(separatedBy: characterSet).joined()
    }
    
    func toFirstElement() -> Self {
        self.components(separatedBy: " ").first ?? "unknown"
    }
}

extension [String] {
    
    func formatEpisodes() -> String {
        self.compactMap { $0.components(separatedBy: "/").last }.joined(separator: ",") + ","
    }
}
