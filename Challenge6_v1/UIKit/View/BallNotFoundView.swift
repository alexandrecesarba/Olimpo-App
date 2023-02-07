//
//  BallNotFoundView.swift
//  Challenge6_v1
//
//  Created by Pedro Peçanha on 06/02/23.
//

import Foundation
import UIKit

class BallNotFoundView: UIView {
    
    public var oi = 5
    let ball = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        self.configView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configView(){
        self.tag = 10
        self.backgroundColor = .black.withAlphaComponent(0.7)
        ball.image = UIImage(systemName: "soccerball")
        ball.contentMode = .scaleAspectFit
        self.addSubview(ball)
    }
    
    func bounceBallLoading(){
//        ball.transform = CGAffineTransform(translationX: 0.1, y: 0.1)
        let initialHeight = ball.center.y
        
        
        
        var sinAux = 0
        while(Int(sinAux)<100){
            var sinFloat = CGFloat(sinAux)
            let transform = CGAffineTransform(translationX: 1.0, y: sinFloat)
            ball.transform = transform
            sinAux += 1
        }
        
    }
    
}
