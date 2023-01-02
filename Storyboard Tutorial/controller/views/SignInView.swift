import UIKit

class SignInView: UIViewController {
    
    @IBOutlet weak var usernameTbox: UITextField!
    @IBOutlet weak var passwordTbox: UITextField!
    
    private var httpController: HttpController!
    private var alertController: AlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        httpController = HttpController()
        alertController = AlertController(v: self)!
    }

    @IBAction func signinBtnClicked(_ sender: Any) {
        if(usernameTbox.text!.isEmpty){
            alertController.alert(title: "Error", message: "아이디를 입력하십시오.")
        }
        else if(passwordTbox.text!.isEmpty){
            alertController.alert(title: "Error", message: "비밀번호를 입력하십시오.")
        }
        else{
            let response = httpController.get(
                url: "https://tails1101.cafe24.com/test/signin_get.php",
                params: ["username": usernameTbox.text!, "password": passwordTbox.text!]
            )
            
            if(response == nil){
                alertController.alert(title: "Error", message: "통신 중 오류가 발생하였습니다.")
            }
            else{
                if( !(response!["success"] as! Bool) ){
                    alertController.alert(title: "Error", message: "아이디 또는 비밀번호가 일치하지 않습니다.")
                }
                else {
                    let name = response!["name"] as! String
                    
                    let nextView = self.storyboard?.instantiateViewController(withIdentifier: "SignedView") as! SignedView
                    nextView.setName(n: name)
                    self.navigationController?.pushViewController(nextView, animated: true)
                }
            }
        }
    }
}

