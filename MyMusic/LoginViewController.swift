//
//  ViewController.swift
//  MyMusic
//
//  Created by Yerneni, Naresh on 4/25/17.
//  Copyright © 2017 Yerneni, Naresh. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController{

    @IBOutlet weak var loginButton: UIButton!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "loginSuccessfull"), object: nil, queue: OperationQueue.main) { (Notification) in
            
            let playlistStoryBoard = UIStoryboard(name: "PlayList", bundle: nil)
            let playlistNVC = playlistStoryBoard.instantiateViewController(withIdentifier: "PlaylistNVC") as! UINavigationController
            
            self.show(playlistNVC, sender: nil)
        }
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        if UIApplication.shared.openURL(MusicClient.getLoginURL()) {
            
            if MusicClient.authorization().canHandle(MusicClient.authorization().redirectURL) {
                // To do - build in error handling
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
