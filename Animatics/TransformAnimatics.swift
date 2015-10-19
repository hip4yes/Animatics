//
//  TransformAnimatics.swift
//  PokeScrum
//
//  Created by Nikita Arkhipov on 19.09.15.
//  Copyright © 2015 Anvics. All rights reserved.
//

import Foundation
import UIKit

class ViewTransformAnimatics: AnimationSettingsHolder, AnimaticsViewChangesPerformer {
   typealias TargetType = UIView
   typealias ValueType = CGAffineTransform
   
   let value: ValueType
   
   required init(_ v: ValueType){ value = v }
   
   func _updateForTarget(t: TargetType){ fatalError() }
}

class TransformAnimator: ViewTransformAnimatics{
   override func _updateForTarget(t: TargetType) { t.transform = value }
}

class AdditiveTransformAnimator: ViewTransformAnimatics {
   override func _updateForTarget(t: TargetType) { t.transform = CGAffineTransformConcat(t.transform, value) }
}

class ScaleAnimator: ViewFloatAnimatics {
   override func _updateForTarget(t: TargetType) { t.transform = CGAffineTransformMakeScale(value, value) }
}

class RotateAnimator: ViewFloatAnimatics {
   override func _updateForTarget(t: TargetType) { t.transform = CGAffineTransformMakeRotation(value) }
}
