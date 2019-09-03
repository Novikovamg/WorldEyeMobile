//
//  MapPostViewController.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 14.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import UIKit

class MapPostViewController: UIViewController {
    
    // MARK: Initializer
    
    init(viewModel: MapPostViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setUpTabBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UIKit
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    // MARK: Private
    
    private var viewModel: MapPostViewModel
    
    private func setUp() {
    }
    
    private func setUpTabBar() {
        tabBarItem.image = C.Image.TabBar.MapPost.disactive
        tabBarItem.selectedImage = C.Image.TabBar.MapPost.active
    }
}
