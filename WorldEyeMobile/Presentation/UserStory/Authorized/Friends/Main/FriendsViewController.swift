//
//  FriendsViewController.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 03.09.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController {
    
    // MARK: Initializer
    
    init(viewModel: FriendsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setUpTabBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: IBOutlet
    
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: IBAction
    
    @IBAction func logout(_ sender: Any) {
    }
    
    // MARK: UIKit
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    // MARK: Private
    
    private let viewModel: FriendsViewModel
    
    private func setUp() {
        
    }
    
    private func setUpTabBar() {
        tabBarItem.image = C.Image.TabBar.Friend.disactive
        tabBarItem.selectedImage = C.Image.TabBar.Friend.active
    }
}
