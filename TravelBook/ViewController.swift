//
//  ViewController.swift
//  TravelBook
//
//  Created by Zeynep Betül Kaya on 13.11.2025.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    var locationManager = CLLocationManager()
    var chosenLatitude = Double()
    var chosenLongitude = Double()
    var selectedTitle = ""
    var selectedTitleID: UUID?
    
    var annotationTitle = ""
    var annotationSubTitle = ""
    var annotationLatitude = Double()
    var annotationLongitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if selectedTitle != "" {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
            let idString = selectedTitleID!.uuidString
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString)
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(fetchRequest)
                for result in results as! [NSManagedObject] {
                    if let title = result.value(forKey: "title") as? String {
                        annotationTitle = title
                    }
                    if let subtitle = result.value(forKey: "subtitle") as? String {
                        annotationSubTitle = subtitle
                    }
                    if let latitude = result.value(forKey: "latitude") as? Double {
                        annotationLatitude = latitude
                    }
                    if let longitude = result.value(forKey: "longitude") as? Double {
                        annotationLongitude = longitude
                    }
                    let annotation = MKPointAnnotation()
                    annotation.title = annotationTitle
                    annotation.subtitle = annotationSubTitle
                    let coordinate = CLLocationCoordinate2D(latitude: annotationLatitude, longitude: annotationLongitude)
                    annotation.coordinate = coordinate
                    mapView.addAnnotation(annotation)
                    nameTextField.text = annotationTitle
                    commentTextField.text = annotationSubTitle
                    
                    locationManager.stopUpdatingLocation()
                    let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                    let region = MKCoordinateRegion(center: coordinate, span: span)
                    mapView.setRegion(region, animated: true)
                }
                
            } catch {
                
            }
        }
        
        mapView.delegate = self
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))
        gestureRecognizer.minimumPressDuration = 3
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if selectedTitle == "" {
            let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region = MKCoordinateRegion(center: location, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
    
    @objc func chooseLocation(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            let touchedPoint = gestureRecognizer.location(in: self.mapView)
            let touchedCoordinates = self.mapView.convert(touchedPoint, toCoordinateFrom: self.mapView)
            
            chosenLatitude = touchedCoordinates.latitude
            chosenLongitude = touchedCoordinates.longitude
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchedCoordinates
            annotation.title = nameTextField.text
            annotation.subtitle = commentTextField.text
            self.mapView.addAnnotation(annotation)
        }
    }
    @IBAction func saveClicked(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newPlace = NSEntityDescription.insertNewObject(forEntityName: "Places", into: context)
        newPlace.setValue(nameTextField.text, forKey: "title")
        newPlace.setValue(commentTextField.text, forKey: "subtitle")
        newPlace.setValue(chosenLatitude, forKey: "latitude")
        newPlace.setValue(chosenLongitude, forKey: "longitude")
        newPlace.setValue(UUID(), forKey: "id")
        
        do {
            try context.save()
        } catch {
        }
        
    }
    

}

