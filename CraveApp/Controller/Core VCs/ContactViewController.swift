//
//  ContactViewController.swift
//  CraveApp
//
//  Created by Alex Cole on 10/28/20.
//

import UIKit
import MapKit
import CoreLocation

class ContactViewController: UIViewController {
    
    //MARK: - UI Elements
    
    private let mapView: MKMapView = {
        let view = MKMapView()
        let center = CLLocationCoordinate2D(latitude: 38.1690, longitude: -122.2543)
        view.region = view.regionThatFits(MKCoordinateRegion(center: center,
                                                             latitudinalMeters: 400,
                                                             longitudinalMeters: 400))
        view.layer.cornerRadius = 30
        return view
    }()
    
    private let mapContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 30
        view.layer.borderWidth = 10
        view.layer.borderColor = UIColor(named: "craveTeal")?.cgColor
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.8
        return view
    }()
    
    private let directionsBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Get Directions", for: .normal)
        btn.backgroundColor = UIColor(named: "craveTeal")
        btn.layer.cornerRadius = 30
        btn.layer.shadowOffset = CGSize(width: 2, height: 2)
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowRadius = 3
        btn.layer.shadowOpacity = 0.8
        return btn
    }()
    
    private let callBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("(707)642-7283", for: .normal)
        btn.backgroundColor = UIColor(named: "craveTeal")
        btn.layer.cornerRadius = 30
        btn.layer.shadowOffset = CGSize(width: 2, height: 2)
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowRadius = 3
        btn.layer.shadowOpacity = 0.8
        return btn
    }()
    
    private let emailBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("info@ilovecrave.com", for: .normal)
        btn.backgroundColor = UIColor(named: "craveTeal")
        btn.layer.cornerRadius = 30
        btn.layer.shadowOffset = CGSize(width: 2, height: 2)
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowRadius = 3
        btn.layer.shadowOpacity = 0.8
        return btn
    }()
    
    //MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Contact"
        view.backgroundColor = .systemBackground
        
        view.addSubview(mapContainer)
        view.addSubview(mapView)
        view.addSubview(directionsBtn)
        view.addSubview(callBtn)
        view.addSubview(emailBtn)
        
        directionsBtn.addTarget(self, action: #selector(directionsTapped), for: .touchUpInside)
        callBtn.addTarget(self, action: #selector(callTapped), for: .touchUpInside)
        emailBtn.addTarget(self, action: #selector(emailTapped), for: .touchUpInside)
        
        addAnnotation()
    }
    
    override func viewWillLayoutSubviews() {
        let offset: CGFloat = 40
        
        mapView.autoPinEdge(toSuperviewSafeArea: .top, withInset: offset)
        mapView.autoPinEdge(toSuperviewSafeArea: .left, withInset: offset)
        mapView.autoPinEdge(toSuperviewSafeArea: .right, withInset: offset)
        mapView.autoSetDimension(.height, toSize: view.bounds.height / 3)
        
        mapContainer.autoPinEdge(toSuperviewSafeArea: .top, withInset: offset)
        mapContainer.autoPinEdge(toSuperviewSafeArea: .left, withInset: offset)
        mapContainer.autoPinEdge(toSuperviewSafeArea: .right, withInset: offset)
        mapContainer.autoSetDimension(.height, toSize: view.bounds.height / 3)
        
        directionsBtn.autoPinEdge(toSuperviewEdge: .left, withInset: offset)
        directionsBtn.autoPinEdge(toSuperviewEdge: .right, withInset: offset)
        directionsBtn.autoPinEdge(.top, to: .bottom, of: mapContainer, withOffset: 20)
        directionsBtn.autoSetDimension(.height, toSize: 52)
        
        callBtn.autoPinEdge(toSuperviewEdge: .left, withInset: offset)
        callBtn.autoPinEdge(toSuperviewEdge: .right, withInset: offset)
        callBtn.autoPinEdge(.top, to: .bottom, of: directionsBtn, withOffset: 20)
        callBtn.autoSetDimension(.height, toSize: 52)
        
        emailBtn.autoPinEdge(toSuperviewEdge: .left, withInset: offset)
        emailBtn.autoPinEdge(toSuperviewEdge: .right, withInset: offset)
        emailBtn.autoPinEdge(.top, to: .bottom, of: callBtn, withOffset: 20)
        emailBtn.autoSetDimension(.height, toSize: 52)
    }
    
    //MARK: - Helper Functions
    
    func addAnnotation() {
        let anno = MKPointAnnotation()
        anno.title = "Crave Cafe & Catering"
        anno.coordinate = CLLocationCoordinate2D(latitude: 38.1690, longitude: -122.2543)
        anno.subtitle = "3419 Broadway Street, Suite H-12\nAmerican Canyon, CA 94503"
        mapView.addAnnotation(anno)
    }

    //MARK: - Button Tap Handlers
    
    @objc func directionsTapped() {
        let regionSpan = MKCoordinateRegion(center: mapView.centerCoordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: mapView.centerCoordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Crave Cafe & Catering"
        mapItem.openInMaps(launchOptions: options)
    }
    
    @objc func callTapped() {
        if let url = URL(string: "tel://7076427283"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @objc func emailTapped() {
        if let url = URL(string: "mailto:info@ilovecrave.com"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
