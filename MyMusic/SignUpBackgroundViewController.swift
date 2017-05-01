//
//  SignUpBgViewController.swift
//  MyMusic
//
//  Created by kathy yin on 4/30/17.
//  Copyright © 2017 Yerneni, Naresh. All rights reserved.
//

import UIKit
import Parse
import ParseUI


class SignUpBackgroundViewController: PFSignUpViewController {
    var backgroundImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImg = UIImageView(image: UIImage(named: "signupbg"))
        backgroundImg.contentMode = UIViewContentMode.scaleAspectFill
        self.signUpView!.insertSubview(backgroundImg, at: 0)
        
        let logo = UILabel()
        logo.text = "My Music"
        logo.textColor = UIColor.white
        logo.font = UIFont.systemFont(ofSize: 70, weight: UIFontWeightThin)
        logo.shadowColor = UIColor.lightGray
        logo.shadowOffset = CGSize.init(width: 2, height: 2)
        self.signUpView?.logo = logo
        self.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        signUpView?.dismissButton!.setTitle("Already signed up?, back to login", for: .normal)
        signUpView?.dismissButton!.setImage(nil, for: .normal)
      
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // stretch background image to fill screen
        backgroundImg.frame = CGRect(x: 0, y: 0, width: signUpView!.frame.width, height: signUpView!.frame.height)
        
        // position logo at top with larger frame
        signUpView!.logo!.sizeToFit()
        
        let logoFrame = signUpView!.logo!.frame
        signUpView!.logo!.frame = CGRect(x: logoFrame.origin.x, y: signUpView!.usernameField!.frame.origin.y - logoFrame.height - 16, width: signUpView!.frame.width, height: logoFrame.height)
        
        let dismissBtnFrame = signUpView!.dismissButton!.frame
        signUpView?.dismissButton!.frame = CGRect(x: 0, y: signUpView!.signUpButton!.frame.origin.y + signUpView!.signUpButton!.frame.height + 16.0, width: signUpView!.frame.width, height: dismissBtnFrame.height)
      
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
