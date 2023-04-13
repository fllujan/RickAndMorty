import UIKit

extension UIFont {
    
    func rounded(textStyle: UIFont.TextStyle = .title3, symbolicTraits: UIFontDescriptor.SymbolicTraits = .traitBold) -> Self {
        let descriptor = UIFontDescriptor
            .preferredFontDescriptor(withTextStyle: textStyle)
            .withSymbolicTraits(symbolicTraits)?
            .withDesign(.rounded)
        
        return descriptor != nil ? Self(descriptor: descriptor!, size: 0) : Self()
    }
}
