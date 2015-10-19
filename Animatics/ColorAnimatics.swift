//
//  ColorAnimatics.swift
//  PokeScrum
//
//  Created by Nikita Arkhipov on 20.09.15.
//  Copyright © 2015 Anvics. All rights reserved.
//

import Foundation
import UIKit

class ColorViewAnimatics: AnimationSettingsHolder, AnimaticsViewChangesPerformer {
   typealias TargetType = UIView
   typealias ValueType = UIColor
   
   let value: ValueType
   
   required init(_ v: ValueType){ value = v }
   
   func _updateForTarget(t: TargetType){ fatalError() }
}

class BackgroundColorAnimator: ColorViewAnimatics {
   override func _updateForTarget(t: TargetType) { t.backgroundColor = value }
}

class TintColorAnimator: ColorViewAnimatics {
   override func _updateForTarget(t: TargetType) { t.tintColor = value }
}
