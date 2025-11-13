//
//  ViewController.swift
//  TravelBook
//
//  Created by Zeynep Betül Kaya on 13.11.2025.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
    }


}

