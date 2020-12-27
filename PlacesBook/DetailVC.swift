//
//  DetailVC.swift
//  PlacesBook
//
//  Created by Bengisu Karakılınç on 26.12.2020.
//

import UIKit

class DetailVC: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate{

    @IBOutlet weak var placeNameText: UITextField!
    @IBOutlet weak var placesTypeText: UITextField!
    @IBOutlet weak var placesCommentText: UITextField!
    
    @IBOutlet weak var placeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        placeImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(getImage))
        placeImageView.addGestureRecognizer(gestureRecognizer)
        
    }
    
    @objc func getImage(){
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        placeImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        
       let placeModel = PlaceModel.sharedInstance
        if placeNameText.text != "" && placesTypeText.text != "" && placesCommentText.text != ""{
            if let chosenImage = placeImageView.image{
                placeModel.placeName = placeNameText.text!
                placeModel.placeType = placesTypeText.text!
                placeModel.placeComment = placesCommentText.text!
                placeModel.placeImage = chosenImage
            }
            performSegue(withIdentifier: "toMapVC", sender: nil)

        }else {
            print("Error")
        }
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
