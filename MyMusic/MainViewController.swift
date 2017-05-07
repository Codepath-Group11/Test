//
//  MainViewController.swift
//  MyMusic
//
//  Created by kathy yin on 5/7/17.
//  Copyright © 2017 Yerneni, Naresh. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "loginSuccessfull"), object: nil, queue: OperationQueue.main) { (Notification) in
            
            let playlistStoryBoard = UIStoryboard(name: "PlayList", bundle: nil)
            let playlistNVC = playlistStoryBoard.instantiateViewController(withIdentifier: "PlaylistNVC") as! UINavigationController
            
            self.show(playlistNVC, sender: nil)
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let loginNib = UIStoryboard(name: "Login", bundle: nil)
        let loginNVC = loginNib.instantiateViewController(withIdentifier: "loginNavigationViewController") as! UINavigationController
        self.present(loginNVC, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
