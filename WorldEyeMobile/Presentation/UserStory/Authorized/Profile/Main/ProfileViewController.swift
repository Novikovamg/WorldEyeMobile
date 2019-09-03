//
//  ProfileViewController.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 03.09.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import UIKit

protocol ProfileViewControllerDelegate: AnyObject {
    func didLoggedOut()
}

class ProfileViewController: UIViewController {
    
    // MARK: Public
    
    public weak var delegate: ProfileViewControllerDelegate?

    // MARK: Initializer
    
    init(viewModel: ProfileViewModel) {
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
        viewModel.logout()
        delegate?.didLoggedOut()
    }
    
    // MARK: UIKit
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    // MARK: Private
    
    private let viewModel: ProfileViewModel
    
    private func setUp() {
        
    }
    
    private func setUpTabBar() {
        tabBarItem.image = C.Image.TabBar.Friend.disactive
        tabBarItem.selectedImage = C.Image.TabBar.Friend.active
    }

}
