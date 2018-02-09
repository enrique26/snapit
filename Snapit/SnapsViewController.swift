//
//  SnapsViewController.swift
//  Snapit
//
//  Created by Enrique Gachuz on 08/02/18.
//  Copyright © 2018 Enrique Gachuz. All rights reserved.
//

import UIKit
import FirebaseAuth

class SnapsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutTapp(_ sender: Any) {

        let firebaseAuth=Auth.auth();
        do{
            try firebaseAuth.signOut()
            dismiss(animated: true, completion: nil)
        }catch let signOutError as NSError{
            print("@Error signin out : %@", signOutError)
            dismiss(animated: true, completion: nil)
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
