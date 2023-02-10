//
//  KeepyUpCounterController.swift
//  Challenge6_v1
//
//  Created by Pedro Peçanha on 05/02/23.
//

import Foundation
import UIKit

class KeepyUpCounterController: UIViewController {
    
    let keepyUpCounterView = KeepyUpCounterView()
    private var recognizerTarget = UIViewController()
    
    override func loadView() {
        view = keepyUpCounterView
    }
    override func viewDidLoad() {
    
    }
        
    func updateRecognizerTarget (controller: UIViewController){
        self.recognizerTarget = controller
        
    }
    
    
}
