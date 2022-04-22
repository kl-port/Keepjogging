//
//  MapViewController.swift
//  Keepjogging
//
//  Created by Uyen Thuc Tran on 4/17/22.
//

import MapKit
import CoreLocation
import UIKit
import Parse

class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    let currentUser = PFUser.current()! as PFObject
    let currentUserId = PFUser.current()?.objectId
    let manager = CLLocationManager()
    var users = [PFObject]()
    var coordinates = [PFGeoPoint]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        manager.desiredAccuracy = kCLLocationAccuracyBest //battery
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager:CLLocationManager, didUpdateLocations locations:[CLLocation]) {
        if let location = locations.first{
            manager.stopUpdatingLocation()
            
            render(location)
        }
    }
    
    func render(_ location: CLLocation) {
        
        //Get current user's location
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
        
        let coordinateDict = PFGeoPoint(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        //Add "coordinate" as a User class's field and save in background
        currentUser["coordinate"] = coordinateDict
        //print("CURRENT COORDINATE",currentUser["coordinate"]!);
        currentUser.saveInBackground {(success, error) in
            if success{
                print("saved!")
            }else{
                print("error!")
            }
        }
  
        //query other user locations
        let query = PFQuery(className: "_User")
        query.findObjectsInBackground() { [self] users, error in
            if users != nil {
                print(users!)
                for user in users! as [PFObject]{
                    let userCoordinate = user["coordinate"] as? PFGeoPoint
                    let userName = user["username"] as? String
                    if (userCoordinate != nil){
                        let annotation = MKPointAnnotation()
                        let title = userName
                        let coor = CLLocationCoordinate2D(latitude: userCoordinate!.latitude,longitude: userCoordinate!.longitude)
                        //print("COOR",coor)
                        //print("next loop")
                        annotation.coordinate = coor
                        annotation.title = title
                        mapView.addAnnotation(annotation)
                        //print("COOR",coor)
    
                        self.coordinates.append(userCoordinate!)
                    }
                    //print("COORDINATE:",self.coordinates)
                
            }
          } else {
              print("Error: \(String(describing: error))")
          }
        }
        //print("COORDINATE:",self.coordinates)
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
