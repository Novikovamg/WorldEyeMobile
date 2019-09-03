//
//  Map.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 14.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import UIKit
import GoogleMaps

class Map: View {
    
    var viewModel: MapModel? {
        didSet {
            setUpViewModel()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.frame = view.bounds
        view.addSubview(mapView)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }
    
    private func setUpViewModel() {
        guard let viewModel = viewModel else { return }
        
    }
}
