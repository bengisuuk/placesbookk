//
//  PlacesVC.swift
//  PlacesBook
//
//  Created by Bengisu Karakılınç on 26.12.2020.
//

import UIKit
import Parse

class PlacesVC: UIViewController, UITableViewDelegate, UITableViewDataSource{



    @IBOutlet weak var placesTableView: UITableView!
    var placesNameArray = [String]()
    var placesIdArray = [String]()
    var selectedId = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        placesTableView.delegate = self
        placesTableView.dataSource = self
        getDataParse()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: UIBarButtonItem.Style.plain, target: self, action: #selector(logoutButtonClicked))

       
    }
    
    
    func getDataParse(){
        
        let query =  PFQuery(className: "Places")
        query.findObjectsInBackground { (objects, error) in
            if error != nil {
                self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error!!")
            }else{
                if objects != nil {
                    
                    self.placesIdArray.removeAll(keepingCapacity: false)
                    self.placesNameArray.removeAll(keepingCapacity: false)
                    
                    for object in objects! {
                        if let placeName = object.object(forKey: "name") as? String{
                            if let placeId = object.objectId  {
                                self.placesIdArray.append(placeId)
                                self.placesNameArray.append(placeName)
                            }
                        }
                        
                    }
                    self.placesTableView.reloadData()
                }
            }
        }
        
    }
    
    
    @objc func addButtonClicked() {
        //Segue
        performSegue(withIdentifier: "toDetailVC", sender: nil)
    }
    
    @objc func logoutButtonClicked(){
        
        PFUser.logOutInBackground { (error) in
            if error != nil{
                self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error!!")
            }else{
                self.performSegue(withIdentifier: "toSignUpVC", sender: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        placesIdArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = placesNameArray[indexPath.row]
        return cell
    }
    

    func makeAlert(titleInput:String, messageInput : String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil )
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toChoosenVC"{
            let destinationVC = segue.destination as! ChosenVC
            destinationVC.chosenPlaceId = selectedId
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedId = placesIdArray[indexPath.row]
        performSegue(withIdentifier: "toChoosenVC", sender: nil)
    }

}
