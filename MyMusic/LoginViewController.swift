//
//  ViewController.swift
//  MyMusic
//
//  Created by Yerneni, Naresh on 4/25/17.
//  Copyright © 2017 Yerneni, Naresh. All rights reserved.
//

import UIKit
import Parse
import Spartan

enum entryType: String {
    case userName = "User Name"
    case email = "Email"
    case password = "Password"
}

class LoginViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, LogInEntryCellDelegate,AuthenticationProtocol {
    var email: String?
    var password: String?
    
    var authenticationController: FitbitAuthenticationController?

  //  @IBOutlet weak var fitBitLogin: UIButton!

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    let inputEntry: [entryType] = [.email, .password]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.loginBtn.layer.cornerRadius = 12
        self.tableView.estimatedRowHeight = 45
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        // Do any additional setup after loading the view.
    
        // move this to an appropriate controller used for fitbit
        
//        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "loginSuccessfull"), object: nil, queue: OperationQueue.main) { (Notification) in
//            
//            let playlistStoryBoard = UIStoryboard(name: "PlayList", bundle: nil)
//            let playlistNVC = playlistStoryBoard.instantiateViewController(withIdentifier: "PlaylistNVC") as! UINavigationController
//            
//            self.show(playlistNVC, sender: nil)
//        }
//        
//        authenticationController = FitbitAuthenticationController(delegate: self)
       

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(connectSpotify), name: NSNotification.Name(rawValue: "loginSuccessfull"), object: nil)
    
    }

    func connectSpotify() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTapSignUp(_ sender: Any) {
        let nib = UIStoryboard(name: "Login", bundle: nil)
        let signUp = nib.instantiateViewController(withIdentifier: "SignUpViewController")
        UIView.beginAnimations("animation", context: nil)
        UIView.setAnimationDuration(0.3)
        self.navigationController?.pushViewController(signUp, animated: false)
        UIView.setAnimationTransition(UIViewAnimationTransition.flipFromRight, for: (self.navigationController?.view)! , cache: false)
        UIView.commitAnimations()
    }
    
    @IBAction func onTapLogin(_ sender: Any) {
        if (checkInputEntries()) {
            
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onConnectWithSpotify(_ sender: Any) {
        if UIApplication.shared.openURL(MusicClient.getLoginURL()) {
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inputEntry.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "LoginEntryCell") as? LoginEntryCell
        cell?.entry = inputEntry[indexPath.row]
        cell?.delegate = self
        return cell!
    }
    
    func userDidEnterData(in cell: LoginEntryCell, field: UITextField, type: entryType, data: String) {
        print(" LoginType \(type.rawValue)")
        print(" login: \(data)")
        switch type {
        case .email:
            email = data
            break
        case .password:
            password = data
            break
        default:
            break
        }
    }
    
    func checkInputEntries() -> Bool {
        if (email?.isEmpty ?? true)!  || (self.password?.isEmpty ?? true)!  {
            return false
        } else {
            return true
        }
    }
    
//    @IBAction func fitBitButtonPressed(_ sender: Any) {
//        authenticationController?.login(fromParentViewController: self)
//    }
    
    
    func authorizationDidFinish(_ success: Bool) {
        
        guard let authToken = authenticationController?.authenticationToken else {
            return
        }
        FitbitAPI.sharedInstance.authorize(with: authToken)
        
        
        
        let _ = FitbitAPI.fetchFavActivities() {[weak self] favActivities,error in
            
            print(favActivities)
            
        }
    }
    
    
}
