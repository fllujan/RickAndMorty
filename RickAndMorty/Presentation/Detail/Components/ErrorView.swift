import SwiftUI

struct ErrorView: View {
    
    var error: Failure
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.red)
            .overlay(
                Text(getMessageError())
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
            )
            .frame(maxHeight: 60)
            .padding()
    }
    
    private func getMessageError() -> String {
        error == .noFound ? "character_not_found".localized() : error.localizedDescription
    }
}

#if DEBUG
struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: .dbError)
    }
}
#endif
