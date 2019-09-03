//
//  PostCluster.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 15.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import CoreLocation
import Foundation

class ShopCluster: NSObject, GMUClusterItem {
    
    public var position: CLLocationCoordinate2D
    public var post: Post
    
    init(post: Post) {
        position = CLLocationCoordinate2D(latitude: post.latitude,
                                          longitude: post.longitude)
        self.post = post
    }
}
