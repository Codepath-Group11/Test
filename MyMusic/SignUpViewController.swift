//
//  SignUpViewController.swift
//  MyMusic
//
//  Copyright © 2017 Yerneni, Naresh. All rights reserved.
//
import UIKit
import Parse

class SignUpViewController: UIViewController, UITableViewDataSource, UITableViewDelegate , SignUpEntryCellDelegate {
    var userName: String!
    var password: String!
    var email: String!
    
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    let inputEntry: [entryType] = [.userName, .email, .password]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpBtn.layer.cornerRadius = 12
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 45
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTapLogin(_ sender: Any) {
        let nib = UIStoryboard(name: "Login", bundle: nil)
        let login = nib.instantiateViewController(withIdentifier: "LoginViewController")
        UIView.beginAnimations("animation", context: nil)
        UIView.setAnimationDuration(0.3)
        self.navigationController?.pushViewController(login, animated: true)
        UIView.setAnimationTransition(UIViewAnimationTransition.flipFromLeft, for: (self.navigationController?.view)!, cache: false)
        UIView.commitAnimations()
    }
    
    @IBAction func onTapSignUp(_ sender: Any) {
        if (checkInputEntries()) {
            let user = PFUser()
            user.email = self.email
            user.password = self.password
            user.username = self.userName
            user.signUpInBackground(block: { (didSignUp, error) in
                if didSignUp {
                    print("sign up success")
                    "next step guide the user to sign up with spotify"
                    
                } else {
                    let alert = UIAlertController(title: "Sign Up", message: "failed to sign up, please try again later", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                    print ("error \(error?.localizedDescription)")
                }
            })
            
        }
        //self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SignUpEntryCell") as? SignUpEntryCell
        cell?.entry = inputEntry[indexPath.row]
        cell?.delegate = self
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inputEntry.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func userDidEnterData(in cell: SignUpEntryCell, field: UITextField, type: entryType, data: String) {
        print(" signUpEntryType \(type.rawValue)")
        print(" signUp: \(data)")
        switch type {
        case .email:
            email = data
            break
        case .password:
            password = data
            break
        case .userName:
            userName = data
            break
        }
    }
    
    func checkInputEntries() -> Bool {
        if email.isEmpty  || self.password.isEmpty || self.userName.isEmpty  {
            return false
        } else {
            return true
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}

