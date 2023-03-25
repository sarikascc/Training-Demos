//
//  MapVC.swift
//  MapWebSplitPageViewDemo
//
//  Created by Sarika on 02/06/22.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController , CLLocationManagerDelegate , MKMapViewDelegate{

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    var currentLocation : CLLocation!
    let reuseIdentifier = "MyIdentifier"

    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.requestWhenInUseAuthorization()
        mapView.delegate = self
        
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
        
    }
    
    //MARK: Location manager delegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        currentLocation = locations.last!
        print("latitude:",currentLocation.coordinate.latitude)
        print("longitude:",currentLocation.coordinate.longitude)
        
        locationManager.stopUpdatingLocation()
        
        addPinOnMap(location: currentLocation.coordinate)
     
        CLGeocoder().reverseGeocodeLocation(currentLocation, completionHandler: {(placemarks, error)->Void in

            if (error != nil) {
                print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                return
            }

            if (placemarks?.count)! > 0 {

                print("placemarks",placemarks!)
                let pm = placemarks?[0]
                print("LocationDetails:",pm ?? nil)
                self.displayLocationInfo(pm)

            }
            else
            {
                print("Problem with the data received from geocoder")
            }
        })
    }
    
    func displayLocationInfo(_ placemark: CLPlacemark?) {
        
       
        if let containsPlacemark = placemark {
            
            //stop updating location to save battery life
            
            var address = ""
            
          
            if let thoroughfare = containsPlacemark.thoroughfare {
            
                address += thoroughfare + ", "
            }
            
            if let subThoroughfare = containsPlacemark.subThoroughfare {
            
                address += subThoroughfare + ", "
            }
            
           
            if let subLocality = containsPlacemark.subLocality {
            
                address += subLocality + ", "
            }
            
            
            if let locality = containsPlacemark.locality {
            
                address += locality + ", "
            }
            
            
            if let postalCode = containsPlacemark.postalCode {
            
                address += postalCode + ", "
            }
            
            if let subAdministrativeArea = containsPlacemark.subAdministrativeArea {
            
                address += subAdministrativeArea + ", "
            }
            
            
            if let administrativeArea = containsPlacemark.administrativeArea {
            
                address += administrativeArea + ", "
            }
            
            if let country = containsPlacemark.country {
            
                address += country
            }
            
            
            print("address:",address)
            
            self.getLatLongFromAddress(address: address)
            
        }
        
    }
    
    func getLatLongFromAddress(address:String){
        
        let address = "1 Infinite Loop, Cupertino, CA 95014"
       
        CLGeocoder().geocodeAddressString(address) { (placemarks, error) in
            if
                let placemarks = placemarks,
                let location = placemarks.first?.location {
                
                print("address_location:",location.coordinate)
                self.addPinOnMap(location: location.coordinate)
            }
            else
            {
                // handle no location found
                return
            }
            
            // Use your location
        }
    }
    
    func addPinOnMap(location:CLLocationCoordinate2D){
        
        let mapPin = MKPointAnnotation()
        mapPin.title = "current location"
        mapPin.coordinate = location
        mapView.addAnnotation(mapPin)
        
    }
    
    //MARK: mapview delegate methods
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }

        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
//            annotationView?.image = UIImage(systemName: "trash") // use for set custom image for pin
            annotationView?.canShowCallout = true  // for show information view  on pin tap
         
        }
        else
        {
            annotationView?.annotation = annotation
        }

        return annotationView
    }

    
}
