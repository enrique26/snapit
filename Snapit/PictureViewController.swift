//
//  PictureViewController.swift
//  Snapit
//
//  Created by Enrique Gachuz on 11/02/18.
//  Copyright © 2018 Enrique Gachuz. All rights reserved.
//

import UIKit
import Firebase

class PictureViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    var imagePicker=UIImagePickerController();
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    //esconder teclado al dar click en el boton return del teclado
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
        
        
        imagesFolfer.child("\(NSUUID().uuidString).jpg").putData(imageData, metadata: nil) { (metadata, error) in
            if error != nil {
                print("@have an error \(String(describing: error))")
            }else {
                print(metadata?.downloadURL()! ?? "default");
                self.performSegue(withIdentifier: "selectUserSegue", sender: nil)
            }
        }
        
        
    }
}
