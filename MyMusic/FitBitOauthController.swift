//
//  fitBitOauthViewController.swift
//  MyMusic
//
//  Created by kathy yin on 5/8/17.
//  Copyright © 2017 Yerneni, Naresh. All rights reserved.
//

import UIKit

class FitBitOauthController: UIViewController , AuthenticationProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()
        authenticationController = FitbitAuthenticationController(delegate: self)
        // Do any additional setup after loading the view.
    }
    var authenticationController: FitbitAuthenticationController?
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //User tap fitbitauth button
    @IBAction func connectWithFitbit(_ sender: UIButton) {
        //Fitbit oauth
         authenticationController?.login(fromParentViewController: self)
    }
    
    func authorizationDidFinish(_ success: Bool) {
        
        guard let authToken = authenticationController?.authenticationToken else {
            return
        }
        FitbitAPI.sharedInstance.authorize(with: authToken)
        // Get Fav Activities
        let _ = FitbitAPI.fetchFavActivities() { favActivities,error in
            print(favActivities)
        }
        //Get Daily Activity
        let day = "/2017-05-07.json"
        let _ = FitbitAPI.fetchDailyActivitySummary(for:day){[weak self] dailyActSummary,error in
            print(dailyActSummary)
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
