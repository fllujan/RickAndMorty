import Foundation

extension String {
    
    func localized(forClass: AnyClass = CharacaterDetailViewUITests.self, tableName: String = "Localizable") -> String {
        NSLocalizedString(self, tableName: tableName, bundle: Bundle(for: forClass), value: "**\(self)**", comment: "")
    }
}
