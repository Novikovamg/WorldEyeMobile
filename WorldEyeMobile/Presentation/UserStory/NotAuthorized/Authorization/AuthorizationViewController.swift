//
//  AuthorizationViewController.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 13.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import UIKit

protocol AuthorizationViewControllerDelegate: AnyObject {
    func logedIn()
    func registrate()
}

class AuthorizationViewController: UIViewController {
    
    // MARK: Public
    
    public weak var delegate: AuthorizationViewControllerDelegate?
    
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
            viewModel.login(username: username, password: password,
            onSuccess: { [weak self] in
                self?.delegate?.logedIn()
            })
        }
    }
    
    @IBAction func registration(_ sender: Any) {
        delegate?.registrate()
    }
    
    // MARK: UIKit
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Private

    private let viewModel: AuthorizationViewModel
}
