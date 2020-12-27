//
//  ChosenVC.swift
//  PlacesBook
//
//  Created by Bengisu Karakılınç on 26.12.2020.
//

import UIKit
import  MapKit
import Parse

class ChosenVC: UIViewController,MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var placeImageView: UIImageView!
    
    @IBOutlet weak var mapKit: MKMapView!
    @IBOutlet weak var placeTypeLabel: UILabel!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeCommentLabel: UILabel!
    
    var chosenPlaceId = ""
    var choosenLatitude = Double()
    var choosenLongitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapKit.delegate = self
        
        getDataFromParse()
        
        
        

        // Do any additional setup after loading the view.
    }
    
    func getDataFromParse(){
        let query = PFQuery(className: "Places")
        query.whereKey("objectId", equalTo: chosenPlaceId)
        query.findObjectsInBackground { (objects, error) in
            if error != nil {
                self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error!!")
            }else{
                
                if objects != nil {
                        let choosenPlaceObject = objects![0]
                        
                        if let placeName =  choosenPlaceObject.object(forKey: "name") as? String{
                            self.placeNameLabel.text = placeName
                            
                        }
                    if let placeType =  choosenPlaceObject.object(forKey: "type") as? String{
                        self.placeTypeLabel.text = placeType
                        
                    }
                    if let placeComment =  choosenPlaceObject.object(forKey: "comment") as? String{
                        self.placeCommentLabel.text = placeComment
                    }
                    if let placeLatitude =  choosenPlaceObject.object(forKey: "latitude") as? String{
                        if let placeLatitudeDouble = Double(placeLatitude) {
                        self.choosenLatitude  = placeLatitudeDouble
                        }
                    }
                    if let placeLongitude =  choosenPlaceObject.object(forKey: "longitude") as? String{
                        if let placeLongitudeDouble = Double(placeLongitude){
                        self.choosenLongitude = placeLongitudeDouble
                        }
                    }
                    
                    if let imageData = choosenPlaceObject.object(forKey: "image") as? PFFileObject{
                        imageData.getDataInBackground { (data, error) in
                            if error != nil{
                                self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error!!")
                            }else{
                                self.placeImageView.image = UIImage(data : data!)
                            }

                        }
                    }
                    
                    
                    let location = CLLocationCoordinate2D(latitude: self.choosenLatitude, longitude: self.choosenLongitude)
                    let span = MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035)
                    let region = MKCoordinateRegion(center: location, span: span)
                    self.mapKit.setRegion(region, animated: true)
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = location
                    self.mapKit.addAnnotation(annotation)
                    
                    }
                
            }
        }
        
        
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = true
            let button = UIButton(type: .detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
        }else{
            pinView?.annotation = annotation
        }
        return pinView
    }
    
    

    
    func makeAlert(titleInput:String, messageInput : String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil )
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
