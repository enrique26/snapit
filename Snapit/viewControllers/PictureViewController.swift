//
//  PictureViewController.swift
//  Snapit
//
//  Created by Enrique Gachuz on 11/02/18.
//  Copyright © 2018 Enrique Gachuz. All rights reserved.
//

import UIKit
import Firebase

class PictureViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var textDescriptionFiled: UITextField!
    
    var uuid=NSUUID().uuidString
    var imagePicker=UIImagePickerController();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.isEnabled=false
        imagePicker.delegate=self
        // Do any additional setup after loading the view.
    }
    
    //esconder teclado al tocar la pantalla
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image=info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imageView.image=image
        imageView.backgroundColor = UIColor.clear
        nextButton.isEnabled=true
        imagePicker.dismiss(animated: true, completion: nil)
    }

    @IBAction func cameraTapp(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func nextTapp(_ sender: Any) {
        nextButton.isEnabled=false
        let imagesFolfer = Storage.storage().reference().child("images")
        //let imageData = UIImagePNGRepresentation(imageView.image!)!
        //comprimiendo la imagen
        let imageData = UIImageJPEGRepresentation(imageView.image!, 0.1)!
        
        
        imagesFolfer.child("\(uuid).jpg").putData(imageData, metadata: nil) { (metadata, error) in
            if error != nil {
                print("@have an error \(String(describing: error))")
            }else {
                print(metadata?.downloadURL()! ?? "default");
                self.performSegue(withIdentifier: "selectUserSegue", sender:metadata?.downloadURL()?.absoluteString )
            }
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! SelectUserViewController
        nextVC.imageUrl=sender as! String
        nextVC.descript=textDescriptionFiled.text!
        nextVC.uuid=uuid
        
    }
}
