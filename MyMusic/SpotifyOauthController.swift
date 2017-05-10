//
//  SpotifyOauthViewController.swift
//  MyMusic
//
//  Created by kathy yin on 5/8/17.
//  Copyright © 2017 Yerneni, Naresh. All rights reserved.
//

import UIKit

class SpotifyOauthController: UIViewController {

    @IBOutlet weak var backgroundView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            NotificationCenter.default.addObserver(self, selector: #selector(didConectWithSpotify), name: NSNotification.Name(rawValue: "loginSuccessfull"), object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //self.removeObserver(self, forKeyPath: <#T##String#>)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didConectWithSpotify() {
        self.presentFitbitInterface()
    }
    
    func presentFitbitInterface() {
        let nib = UIStoryboard(name: "Login", bundle: nil)
        let intro = nib.instantiateViewController(withIdentifier: "FitBitOauthController")
        self.present(intro, animated: true, completion: nil)
    }
    
    //User tap auth button
    @IBAction func connectWithSpoitfy(_ sender: Any) {
        //Call the Spotify Oauth function
        if UIApplication.shared.openURL(MusicClient.getLoginURL()) {
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
