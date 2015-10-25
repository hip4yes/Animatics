//
//  ShapeLayerAnimatics.swift
//  Animatics
//
//  Created by Nikita Arkhipov on 24.10.15.
//  Copyright © 2015 Anvics. All rights reserved.
//

import Foundation
import UIKit

class ShapeLayerFloatAnimatics: AnimationSettingsHolder, AnimaticsLayerChangesPerformer {
   typealias TargetType = CAShapeLayer
   typealias ValueType = CGFloat
   
   let value: ValueType
   
   required init(_ v: ValueType){ value = v }
   
   func _animationKeyPath() -> String { fatalError("_animationKeyPath() is called but not implemented in \(self.dynamicType)") }
}

class StrokeStartAnimator: ShapeLayerFloatAnimatics{
   override func _animationKeyPath() -> String { return "strokeStart" }
}

class StrokeEndAnimator: ShapeLayerFloatAnimatics{
   override func _animationKeyPath() -> String { return "strokeEnd" }
}

class LineWidthAnimator: ShapeLayerFloatAnimatics{
   override func _animationKeyPath() -> String { return "lineWidth" }
}

class MitterLimitAnimator: ShapeLayerFloatAnimatics{
   override func _animationKeyPath() -> String { return "miterLimit" }
}

class LineDashPhaseAnimator: ShapeLayerFloatAnimatics{
   override func _animationKeyPath() -> String { return "lineDashPhase" }
}


class ShapeLayerColorAnimatics: AnimationSettingsHolder, AnimaticsLayerChangesPerformer {
   typealias TargetType = CAShapeLayer
   typealias ValueType = UIColor
   
   let value: ValueType
   
   required init(_ v: ValueType){ value = v }
   
   func _animationKeyPath() -> String { fatalError("_animationKeyPath() is called but not implemented in \(self.dynamicType)") }
   func _newValue() -> AnyObject { return value.CGColor as AnyObject }
}

class FillColorAnimator: ShapeLayerColorAnimatics{
   override func _animationKeyPath() -> String { return "fillColor" }
}

class StrokeColorAnimator: ShapeLayerColorAnimatics{
   override func _animationKeyPath() -> String { return "strokeColor" }
}
