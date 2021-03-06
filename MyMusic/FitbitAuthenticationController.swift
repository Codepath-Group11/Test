//
//  FitbitAuthenticationController.swift
//  MyMusic
//
//  Created by Yerneni, Naresh on 5/6/17.
//  Copyright © 2017 Yerneni, Naresh. All rights reserved.
//

import SafariServices
import Foundation

protocol AuthenticationProtocol {
    func authorizationDidFinish(_ success :Bool)
}

class FitbitAuthenticationController: NSObject, SFSafariViewControllerDelegate
{
    let clientID = "228B98"
    let clientSecret = "fa45e772b7807251ffe50f3d4b48b263"
    let baseURL = URL(string: "https://www.fitbit.com/oauth2/authorize")
    static let redirectURI = "MyMusicDemoFitbit://"
    let defaultScope = "sleep+settings+nutrition+activity+social+heartrate+profile+weight+location"
    
    var authorizationVC: SFSafariViewController?
    var delegate: AuthenticationProtocol?
    var authenticationToken: String?
    
    init(delegate: AuthenticationProtocol?) {
        self.delegate = delegate
        super.init()
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "FitBitLaunchNotification"), object: nil, queue: nil, using: { [weak self] (notification: Notification) in
            // Parse and extract token
            let success: Bool
            if let token = FitbitAuthenticationController.extractToken(notification, key: "#access_token") {
                self?.authenticationToken = token
                let userDefaults = UserDefaults.standard
                userDefaults.set(token, forKey: "FitbitToken")
                userDefaults.synchronize()
                NSLog("You have successfully authorized")
                success = true
            } else {
                print("There was an error extracting the access token from the authentication response.")
                success = false
            }
            
            self?.authorizationVC?.dismiss(animated: true, completion: {
                self?.delegate?.authorizationDidFinish(success)
            })
        })
        
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
   
    
    public func login(fromParentViewController viewController: UIViewController) {
        guard let url = URL(string: "https://www.fitbit.com/oauth2/authorize?response_type=token&client_id="+clientID+"&redirect_uri="+FitbitAuthenticationController.redirectURI+"&scope="+defaultScope+"&expires_in=604800") else {
            NSLog("Unable to create authentication URL")
            return
        }
        
        let authorizationViewController = SFSafariViewController(url: url)
        authorizationViewController.delegate = self
        authorizationVC = authorizationViewController
        viewController.present(authorizationViewController, animated: true, completion: nil)
    }
    
    public static func logout() {
        
    }
    
    private static func extractToken(_ notification: Notification, key: String) -> String? {
        var newKey = " "
        guard let url = notification.userInfo?[UIApplicationLaunchOptionsKey.url] as? URL else {
            NSLog("notification did not contain launch options key with URL")
            return nil
        }
        var lowercaseRedirectURI = redirectURI
        
        lowercaseRedirectURI = lowercaseRedirectURI.lowercased()
        
        newKey = lowercaseRedirectURI + key
        
        // Extract the access token from the URL
        let strippedURL = url.absoluteString.replacingOccurrences(of: FitbitAuthenticationController.redirectURI, with: "")
        return self.parametersFromQueryString(strippedURL)[newKey]
    }
    
   
    private static func parametersFromQueryString(_ queryString: String?) -> [String: String] {
        var parameters = [String: String]()
        if (queryString != nil) {
            let parameterScanner: Scanner = Scanner(string: queryString!)
            var name:NSString? = nil
            var value:NSString? = nil
            while (parameterScanner.isAtEnd != true) {
                name = nil;
                parameterScanner.scanUpTo("=", into: &name)
                parameterScanner.scanString("=", into:nil)
                value = nil
                parameterScanner.scanUpTo("&", into:&value)
                parameterScanner.scanString("&", into:nil)
                if (name != nil && value != nil) {
                    parameters[name!.removingPercentEncoding!]
                        = value!.removingPercentEncoding!
                }
            }
        }
        return parameters
    }
    
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        delegate?.authorizationDidFinish(false)
    }
}


