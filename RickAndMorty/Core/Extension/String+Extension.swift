import Foundation

extension String {
    func toFirstElement() -> Self {
        self.components(separatedBy: " ").first ?? "unknown"
    }
}
