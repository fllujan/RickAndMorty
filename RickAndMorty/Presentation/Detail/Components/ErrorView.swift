import SwiftUI

struct ErrorView: View {
    
    var type: Failure
    
    var body: some View {
        switch type {
        case .dbError:
            showError(message: "Sorry, something went wrong. Please try again later or contact support.")
        case .generic:
            showError(message: "Sorry, something went wrong. Please try again later or contact support.")
        case .httpResponseError:
            showError(message: "Sorry, something went wrong. Please try again later or contact support.")
        default:
            showError(message: "Sorry, something went wrong. Please try again later or contact support.")
        }
    }
    
    func showError(message: String) -> some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.red)
            .overlay(
                Text(message)
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
            )
            .frame(maxHeight: 60)
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(type: .dbError)
    }
}
