//
//  AuthorizationViewController.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 13.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import UIKit

class AuthorizationViewController: UIViewController {
    
    // MARK: Initialization
    
    init(viewModel: AuthorizationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: IBOutlet
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: IBAction
    
    @IBAction func login(_ sender: Any) {
        if let username = loginTextField.text,
           let password = passwordTextField.text
        {
            viewModel.login(username: username, password: password)
        }
    }
    
    @IBAction func registration(_ sender: Any) {
    }
    
    // MARK: UIKit
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Private

    private let viewModel: AuthorizationViewModel
}
