//
//  LayerAnimatics.swift
//  PokeScrum
//
//  Created by Nikita Arkhipov on 19.09.15.
//  Copyright © 2015 Anvics. All rights reserved.
//

import Foundation
import UIKit

class LayerFloatAnimatics: AnimationSettingsHolder, AnimaticsLayerChangesPerformer {
   typealias TargetType = UIView
   typealias ValueType = CGFloat
   
   let value: ValueType
   
   required init(_ v: ValueType){ value = v }
   
   func _animationKeyPath() -> String { fatalError("_animationKeyPath() is called but not implemented in \(self.dynamicType)") }
}

class ShadowRadiusAnimator: LayerFloatAnimatics {
   override func _animationKeyPath() -> String { return "shadowRadius" }
}

class ShadowOpacityAnimator: LayerFloatAnimatics {
   override func _animationKeyPath() -> String { return "shadowOpacity" }
}

class CornerRadiusAnimator: LayerFloatAnimatics {
   override func _animationKeyPath() -> String { return "cornerRadius" }
}

class BorderWidthAnimator: LayerFloatAnimatics {
   override func _animationKeyPath() -> String { return "borderWidth" }
}

class LayerTransformAnimatics: AnimationSettingsHolder, AnimaticsLayerChangesPerformer {
   typealias TargetType = UIView
   typealias ValueType = CATransform3D
   
   let value: ValueType
   
   required init(_ v: ValueType){ value = v }
   
   func _animationKeyPath() -> String { return "transform" }
}

class LayerColorAnimatics: AnimationSettingsHolder, AnimaticsLayerChangesPerformer {
   typealias TargetType = UIView
   typealias ValueType = UIColor
   
   let value: ValueType
   
   required init(_ v: ValueType){ value = v }
   
   func _animationKeyPath() -> String { fatalError("_animationKeyPath() is called but not implemented in \(self.dynamicType)") }
}

class BorderColorAnimator: LayerColorAnimatics {
   override func _animationKeyPath() -> String { return "borderColor" }
}

class GradientLayerPointAnimatics: AnimationSettingsHolder, AnimaticsLayerChangesPerformer {
   typealias TargetType = CAGradientLayer
   typealias ValueType = CGPoint
   
   let value: ValueType
   
   required init(_ v: ValueType){ value = v }
   
   func _animationKeyPath() -> String { fatalError("_animationKeyPath() is called but not implemented in \(self.dynamicType)") }
}

class GradientLayerStartPointAnimator: GradientLayerPointAnimatics {
   override func _animationKeyPath() -> String { return "startPoint" }
}

class GradientLayerEndPointAnimator: GradientLayerPointAnimatics {
   override func _animationKeyPath() -> String { return "endPoint" }
}
