//
//  CombineCompaitableExtensions.swift
//  ValifyApp
//
//  Created by iOSAYed on 06/10/2024.
//

import Foundation
import UIKit
import Combine

protocol CombineCompatible { }

extension UIControl: CombineCompatible { }

extension CombineCompatible where Self: UIControl {
    func publisher(for events: UIControl.Event) -> UIControlPublisher<UIControl> {
        return UIControlPublisher(control: self, events: events)
    }
}
