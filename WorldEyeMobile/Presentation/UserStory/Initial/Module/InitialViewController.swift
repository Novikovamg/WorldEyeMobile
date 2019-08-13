//
//  InitialViewController.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 13.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import UIKit

protocol InitialViewControllerDelegate: AnyObject {
    func logedIn()
    func logedOut()
}

class InitialViewController: UIViewController {
    
    public weak var delegate: InitialViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate?.logedOut()
    }
}
