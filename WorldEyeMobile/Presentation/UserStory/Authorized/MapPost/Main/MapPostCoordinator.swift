//
//  MapPostCoordinator.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 14.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import UIKit

final class MapPostCoordinator: Coordinator {
    
    func start() -> UIViewController {
        mapPostViewModel = assembly.resolve(MapPostViewModel.self)
        mapPostViewController = MapPostViewController(viewModel: mapPostViewModel)
        return mapPostViewController
    }
    
    private var mapPostViewModel: MapPostViewModel!
    private var mapPostViewController: MapPostViewController!
}
