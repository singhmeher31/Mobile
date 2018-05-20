//
//  ViewController.swift
//  Project
//
//  Created by Meher Jyoti Singh on 4/15/18.
//  Copyright © 2018 Meher Jyoti Singh. All rights reserved.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController, GIDSignInUIDelegate {

    let signinButton = GIDSignInButton.init(frame: CGRect(x: 0, y: 0, width: 240, height: 120))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently()
        signinButton.center = view.center
        
        view.addSubview(signinButton)
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (GIDSignIn.sharedInstance().hasAuthInKeychain()){
            print("signed in")
            performSegue(withIdentifier: "navscreen", sender: self)
        }
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

