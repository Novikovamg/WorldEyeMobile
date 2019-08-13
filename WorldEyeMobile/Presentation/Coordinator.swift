//
//  Coordinator.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 13.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import Foundation
import UIKit

protocol CoordinatorDelegate: AnyObject {
    func finish(flow: Coordinator)
}

class Coordinator: NSObject {
    
    weak var delegate: CoordinatorDelegate?
    var childFlows: [Coordinator] = []
    var assembly: AppAssembly!
    
    var navigationController: UINavigationController?
    var topViewController: UIViewController?
    
    func addChild(flow: Coordinator) {
        flow.assembly = self.assembly
        flow.delegate = self
        childFlows.append(flow)
    }
    
    func addChild(flow: Coordinator, with navigationController: UINavigationController?) {
        if navigationController == nil {
            flow.navigationController = UINavigationController()
        } else {
            flow.navigationController = navigationController
        }
        flow.navigationController?.delegate = flow
        flow.topViewController = flow.navigationController!.topViewController
        
        addChild(flow: flow)
    }
}

extension Coordinator: CoordinatorDelegate {
    @objc
    func finish(flow: Coordinator) {
        for i in childFlows.indices where childFlows[i] === flow {
            childFlows.remove(at: i)
            break
        }
    }
}

extension Coordinator: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard viewController === topViewController else { return }
        delegate?.finish(flow: self)
    }
}
