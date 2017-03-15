//
//  mainFeedVC.swift
//  projectRocketa
//
//  Created by Michael Ballard on 3/14/17.
//  Copyright © 2017 Michael Ballard. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class mainFeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signOutLoaded(_ sender: Any) {
        
        try! FIRAuth.auth()?.signOut()
    
        performSegue(withIdentifier: "goToSignIn", sender: nil)
    }
    

}
