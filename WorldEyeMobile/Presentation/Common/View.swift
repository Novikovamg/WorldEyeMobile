//
//  View.swift
//  WorldEyeMobile
//
//  Created by Viktor Novikov on 14.08.2019.
//  Copyright © 2019 Viktor Novikov. All rights reserved.
//

import UIKit

open class View: UIView {
    
    public var view: UIView!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    public class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    private func xibSetup() {
        backgroundColor = UIColor.clear
        view = loadNib()
        view.frame = bounds
        addSubview(view)
    }
    
    private func loadNib() -> UIView {
        let bundle = Bundle.main
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
}
