import SwiftUI

struct TextTitleView: View {
    
    var title: String
    var value: String
    
    var body: some View {
        VStack(alignment: .center) {
            Text(title)
                .font(.system(.caption, design: .rounded))
                .foregroundColor(Color.gray.opacity(0.7))
                .padding(.top, 2)
            Text(value)
                .font(.system(.body, design: .rounded))
        }
    }
}


#if DEBUG
struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        TextTitleView(title: "Especies", value:  "Male")
    }
}
#endif
