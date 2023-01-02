import UIKit

class AlertController {
    
    private var view: UIViewController
    
    public init?(v: UIViewController) {
        view = v
    }

    public func alert(title: String, message: String){
        let dialog = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action) in
        }
        dialog.addAction(okAction)
        
        view.present(dialog, animated: true, completion: nil)
    }
}
