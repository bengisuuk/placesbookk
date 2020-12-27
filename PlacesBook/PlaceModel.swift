//
//  PlaceModel.swift
//  PlacesBook
//
//  Created by Bengisu Karakılınç on 27.12.2020.
//

import Foundation
import UIKit
//sadece benim belirttiğim obje oluşabiliyor.
//Singleton
class PlaceModel{
    static let sharedInstance = PlaceModel()
    
    var placeName = ""
    var placeType = ""
    var placeComment = ""
    var placeImage = UIImage()
    var placeLatitude = ""
    var placeLongitude = ""
    
    private init(){
        
    }
}
