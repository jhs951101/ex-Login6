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
        let username = usernameTbox.text!
        let password = passwordTbox.text!
        
        if(username.isEmpty){
            alertController.alert(title: "Error", message: "아이디를 입력하십시오.")
        }
        else if(password.isEmpty){
            alertController.alert(title: "Error", message: "비밀번호를 입력하십시오.")
        }
        else{
            let response = httpController.post(
                url: "https://tails1101.cafe24.com/test/signin_post_json.php",
                params: ["username": username, "password": password]
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
                    nextView.setUsername(u: username)
                    nextView.setName(n: name)
                    
                    self.navigationController?.pushViewController(nextView, animated: true)
                }
            }
        }
    }
    
    @IBAction func signupBtnClicked(_ sender: Any) {
        alertController.alert(title: "Error", message: "죄송합니다. 아직 준비중입니다.")
    }
}

