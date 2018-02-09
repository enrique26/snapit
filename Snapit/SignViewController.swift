//
//  SignViewController.swift
//  Snapit
//
//  Created by Enrique Gachuz on 08/02/18.
//  Copyright © 2018 Enrique Gachuz. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignViewController: UIViewController {

    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func turnUpTapp(_ sender: Any) {
        
        Auth.auth().signIn(withEmail:emailTextField.text!, password: passTextField.text!) { (user, error) in
            if (error != nil){
                print("@info tried to sign in and have an error \(String(describing: error))");
                Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passTextField.text!, completion: { (user, errorIn) in
                    if(errorIn != nil){
                        print("@error tried to sign in and have an error \(String(describing: errorIn))");
                    }else{
                        print("@create user create instantly!!");
                        self.performSegue(withIdentifier: "signinsegue", sender: nil);
                    }
                })
            }else{
                print("@success sign in successfull!!");
                self.performSegue(withIdentifier: "signinsegue", sender: nil);
            }
        }
    }
    
}

