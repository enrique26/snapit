//
//  ViewSnapViewController.swift
//  Snapit
//
//  Created by Enrique Gachuz on 07/03/18.
//  Copyright © 2018 Enrique Gachuz. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase

class ViewSnapViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelPrev: UILabel!
    
    var snap = Snap()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        labelPrev.text=snap.descript
        imageView.sd_setShowActivityIndicatorView(true)
        imageView.sd_setIndicatorStyle(.gray)
        imageView.sd_setImage(with: URL(string:snap.imageUrl), completed: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!).child("snaps").child(snap.key).removeValue()
        
        Storage.storage().reference().child("images").child("\(snap.uuid).jpg").delete { (error) in
            print("@Pick Deleted")
        }
    }


}
