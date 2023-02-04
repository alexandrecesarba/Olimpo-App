//
//  ResetButtonViewController.swift
//  Challenge6_v1
//
//  Created by Pedro Peçanha on 03/02/23.
//

import Foundation
import UIKit

class ResetButtonController: UIViewController {
    override func loadView() {
        let buttonView = ResetButtonView()
        self.view = buttonView
        buttonView.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    @objc func buttonAction(){
        print("oi")
    }
    
}

