//
//  SelectUserViewController.swift
//  Snapit
//
//  Created by Enrique Gachuz on 11/02/18.
//  Copyright © 2018 Enrique Gachuz. All rights reserved.
//

import UIKit
import Firebase

class SelectUserViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    var users:[User]=[]
    var imageUrl=""
    var descript=""
    var uuid=""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource=self
        tableView.delegate=self
        Database.database().reference().child("users").observe(DataEventType.childAdded) { (snapshot) in
            print(snapshot)
            
            
            let snap = snapshot.value as? NSDictionary
            let user=User()
            user.email=snap?["email"] as! String
            user.uid=snapshot.key
            
            self.users.append(user)
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let user=users[indexPath.row]
        cell.textLabel?.text=user.email
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user=users[indexPath.row]
        
        let snap=["from":Auth.auth().currentUser?.email,"descripction":descript,"imageUrl":imageUrl,"uuid":uuid]
        
        Database.database().reference().child("users").child(user.uid).child("snaps").childByAutoId().setValue(snap)
        
        navigationController!.popToRootViewController(animated: true)
    }
    

}
