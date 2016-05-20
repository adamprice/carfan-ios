//
//  ViewController.swift
//  Carfan
//
//  Created by Adam Price - myBBC on 19/05/2016.
//  Copyright © 2016 Logic Pie. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework

class ViewController: UIViewController {
    
    @IBOutlet var emailInput: UITextField!
    @IBOutlet var passwordInput: UITextField!
    
    var remoteConfig: FIRRemoteConfig!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = FlatMint()
        
        remoteConfig = FIRRemoteConfig.remoteConfig()
        remoteConfig.setDefaultsFromPlistFileName("RemoteConfigDefaults")
        
        remoteConfig.fetchWithExpirationDuration(10) {
            (status, error) in
            if status == .Success {
                print("Config fetched!")
                self.remoteConfig.activateFetched()
                let test = self.remoteConfig["test_param"].stringValue!
                print(test)
            } else {
                print("Config not fetched")
                print("Error \(error!)")
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login() {
        
        FIRAuth.auth()?.signInWithEmail(emailInput.text!, password: passwordInput.text!) { (user, error) in
            
            if let error = error?.domain {
                print("An error occurred: \(error)")
            } else {
                print("Logged in as \(user?.uid)")
            }
            
        }
        
    }
    
    @IBAction func createUser() {
        
        FIRAuth.auth()?.createUserWithEmail(emailInput.text!, password: passwordInput.text!) { (user, error) in
            
            if let error = error?.domain {
                print("Failed to create user: \(error)")
            } else {
               print("Success");
            }
            
        }
        
    }

}

