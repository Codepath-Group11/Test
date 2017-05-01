//
//  LoginBackgroundViewController.swift
//  MyMusic
//
//  Created by kathy yin on 4/30/17.
//  Copyright © 2017 Yerneni, Naresh. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class LoginBackgroundViewController: PFLogInViewController {
    var backgroundImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImg = UIImageView(image: UIImage(named: "loginbg"))
        backgroundImg.contentMode = UIViewContentMode.scaleAspectFill
        self.logInView!.insertSubview(backgroundImg, at: 0)
        let logo = UILabel()
        logo.text = "My Music"
        logo.textColor = UIColor.white
        logo.font = UIFont.systemFont(ofSize: 70, weight: UIFontWeightThin)
        logo.shadowColor = UIColor.lightGray
        logo.shadowOffset = CGSize.init(width: 2, height: 2)
        logInView?.logo = logo
        self.signUpController = SignUpBackgroundViewController()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //self.signUpController = SignUpBackgroundViewController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // stretch background image to fill screen
        backgroundImg.frame = CGRect(x: 0, y: 0, width: self.logInView!.frame.width, height: self.logInView!.frame.height)
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
