//
//  RegistrationViewController.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 13.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import UIKit

protocol RegistrationViewControllerDelegate: AnyObject {
    func registered()
}

class RegistrationViewController: UIViewController {
    
    // MARK: Public
    
    public weak var delegate: RegistrationViewControllerDelegate?
    
    // MARK: Initializer
    
    init(viewModel: RegistrationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UIKit

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: IBOutlet
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var loginTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: IBAction
    
    @IBAction func register(_ sender: Any) {
        if let name = nameTextField.text,
           let login = loginTextField.text,
           let email = emailTextField.text,
           let password = passwordTextField.text
        {
            viewModel.registrate(username: name, login: login, email: email, password: password,
            onSuccess: { [weak self] in
                self?.delegate?.registered()
            })
        }
    }
    
    // MARK: Private
    
    private let viewModel: RegistrationViewModel
}
