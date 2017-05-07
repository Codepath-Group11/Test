//
//  ViewController.swift
//  MyMusic
//
//  Created by Yerneni, Naresh on 4/25/17.
//  Copyright © 2017 Yerneni, Naresh. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController,AuthenticationProtocol{

    @IBOutlet weak var loginButton: UIButton!
 
    @IBOutlet weak var fitBitLogin: UIButton!
    
    var authenticationController: FitbitAuthenticationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "loginSuccessfull"), object: nil, queue: OperationQueue.main) { (Notification) in
            
            let playlistStoryBoard = UIStoryboard(name: "PlayList", bundle: nil)
            let playlistNVC = playlistStoryBoard.instantiateViewController(withIdentifier: "PlaylistNVC") as! UINavigationController
            
            self.show(playlistNVC, sender: nil)
        }
       
        authenticationController = FitbitAuthenticationController(delegate: self)

        
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        if UIApplication.shared.openURL(MusicClient.getLoginURL()) {
            
            if MusicClient.authorization().canHandle(MusicClient.authorization().redirectURL) {
                // To do - build in error handling
            }
        }
    }
    
    @IBAction func fitBitButtonPressed(_ sender: Any) {
        authenticationController?.login(fromParentViewController: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func authorizationDidFinish(_ success: Bool) {
      
        guard let authToken = authenticationController?.authenticationToken else {
            return
        }
        FitbitAPI.sharedInstance.authorize(with: authToken)
       

        
        let _ = FitbitAPI.fetchFavActivities() {[weak self] favActivities,error in
         

   
        }
    }
    
}
