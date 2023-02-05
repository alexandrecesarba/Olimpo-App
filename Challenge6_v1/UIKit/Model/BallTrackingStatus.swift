//
//  BallStatus.swift
//  Challenge6_v1
//
//  Created by Pedro Peçanha on 04/02/23.
//

import Foundation
import UIKit

enum BallTrackingStatus: String {
    case notFound = "❌ Ball not found."
    case finding = "⚠️ Hold on steady..."
    case found = "✅ Ball found!"
    
    var color: UIColor {
        switch self {
            case .notFound:
                return .red.withAlphaComponent(0.3)
            case .finding:
                return .yellow.withAlphaComponent(0.3)
            case .found:
                return .green.withAlphaComponent(0.3)
        }
    }
}
