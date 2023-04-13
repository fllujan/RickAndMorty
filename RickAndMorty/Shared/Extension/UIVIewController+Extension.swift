import UIKit

extension UIViewController {
    func showAlertError(_ error: Failure) {
        if error == .noFound { return }
        
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
}
