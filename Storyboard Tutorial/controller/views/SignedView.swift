import UIKit

class SignedView: UIViewController {
    
    @IBOutlet weak var welcomeLbl: UILabel!
    
    private var username: String!
    private var name: String!
    
    override func viewDidLoad() {
        // 뷰를 새로 생성할 때만 실행. 뒤로가기를 눌러서 보면 실행X.
        super.viewDidLoad()
        
        welcomeLbl?.text = String(format: "%@(%@)님 환영합니다!", name, username)
        //welcomeLbl?.text = "\(name!)(\(username!))님 환영합니다!"
    }
    
    /*
    override func viewWillAppear(_ animated: Bool) {
        // 뷰를 볼 때마다 항상 실행. 뒤로가기를 눌러서 봐도 실행.
        super.viewWillAppear(animated)
    }
    */
    
    @IBAction func signoutBtnClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    public func setUsername(u: String){
        username = u
    }
    
    public func setName(n: String){
        name = n
    }
}
