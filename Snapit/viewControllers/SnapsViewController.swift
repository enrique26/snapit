//
//  SnapsViewController.swift
//  Snapit
//
//  Created by Enrique Gachuz on 08/02/18.
//  Copyright © 2018 Enrique Gachuz. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SnapsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var snaps : [Snap] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource=self
        tableView.delegate=self
        Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!).child("snaps").observe(DataEventType.childAdded) { (snapshot) in
            print("@ \(snapshot)")
            let snapVal = snapshot.value as? NSDictionary
            let snap=Snap()
            snap.imageUrl=snapVal?["imageUrl"] as! String
            snap.from=snapVal?["from"] as! String
            snap.descript=snapVal?["descripction"] as! String
            snap.key=snapshot.key
            snap.uuid=snapVal?["uuid"] as! String
            self.snaps.append(snap)
            
            self.tableView.reloadData() 
        }
        
        Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!).child("snaps").observe(DataEventType.childRemoved) { (snapshot) in
            print("@ \(snapshot)")
            
            var index=0
            for snap in self.snaps{
                if snap.key == snapshot.key{
                    self.snaps.remove(at: index)
                }
                index += 1
            }
            self.tableView.reloadData()
        }
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(snaps.count == 0){
            return 1;
        }else{
            return snaps.count;
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if(snaps.count == 0){
            cell.textLabel?.text="There is no picks to show to you"
        }else{
            let snap = snaps[indexPath.row]
            cell.textLabel?.text=snap.from
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(snaps.count > 0){
            let snap=snaps[indexPath.row]
            performSegue(withIdentifier: "snapSegueF", sender: snap)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier=="snapSegueF"){
            let nextVC=segue.destination as! ViewSnapViewController
            nextVC.snap = sender as! Snap
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
