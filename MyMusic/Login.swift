//
//  Login.swift
//  MyMusic
//
//  Created by kathy yin on 4/30/17.
//  Copyright © 2017 Yerneni, Naresh. All rights reserved.
//

import Foundation
import UIKit
import FacebookCore
import FacebookLogin
import GoogleSignIn
import Parse
import ParseUI

class Login :NSObject, PFLogInViewControllerDelegate ,PFSignUpViewControllerDelegate {
    weak var delegate: UIViewController!
    
    func checkLogin(vc: UIViewController) {
        self.delegate = vc
        if (PFUser.current() == nil) {
            let loginViewController = LoginBackgroundViewController()
            loginViewController.delegate = self
            loginViewController.emailAsUsername = true
            loginViewController.signUpController?.emailAsUsername = true
            loginViewController.signUpController?.delegate = self
            loginViewController.fields =  PFLogInFields(rawValue: PFLogInFields.usernameAndPassword.rawValue | PFLogInFields.logInButton.rawValue | PFLogInFields.signUpButton.rawValue | PFLogInFields.facebook.rawValue | PFLogInFields.twitter.rawValue)
            
            self.delegate?.present(loginViewController, animated: false, completion: nil)
        } else {
            self.presentLoggedInAlert()
        }
    
    }
    
    func log(_ logInController: PFLogInViewController, didLogIn user: PFUser) {
        logInController.dismiss(animated: true, completion: nil)
        presentLoggedInAlert()
    }
    
    func signUpViewController(_ signUpController: PFSignUpViewController, didSignUp user: PFUser) {
        signUpController.dismiss(animated: true, completion: nil)
    }
    
    func presentLoggedInAlert() {
        let alertController = UIAlertController(title: "You're logged in", message: "My Muisc", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.delegate.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(OKAction)
        self.delegate.present(alertController, animated: true, completion: nil)
    }

}
