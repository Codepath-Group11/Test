//
//  SignUpViewController.swift
//  MyMusic
//
//  Copyright © 2017 Yerneni, Naresh. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITableViewDataSource, UITableViewDelegate , SignUpEntryCellDelegate {

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
        self.dismiss(animated: true, completion: nil)
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
