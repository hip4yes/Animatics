//
//  ViewFloatAnimatics.swift
//  AnimationFramework
//
//  Created by Nikita Arkhipov on 14.09.15.
//  Copyright © 2015 Anvics. All rights reserved.
//

import Foundation
import UIKit

class ViewFloatAnimatics: AnimationSettingsHolder, AnimaticsViewChangesPerformer {
   typealias TargetType = UIView
   typealias ValueType = CGFloat
   
   let value: ValueType
   
   required init(_ v: ValueType){ value = v }
   
   func _updateForTarget(t: TargetType){ fatalError() }
}

class XAnimator: ViewFloatAnimatics{
   override func _updateForTarget(t: TargetType) { t.frame.origin.x = value }
}

class DXAnimator: ViewFloatAnimatics{
   override func _updateForTarget(t: TargetType) { t.frame.origin.x += value }
}

class YAnimator: ViewFloatAnimatics{
   override func _updateForTarget(t: TargetType) { t.frame.origin.y = value }
}

class DYAnimator: ViewFloatAnimatics{
   override func _updateForTarget(t: TargetType) { t.frame.origin.y += value }
}

class WidthAnimator: ViewFloatAnimatics{
   override func _updateForTarget(t: TargetType) { t.frame.size.width = value }
}

class DWidthAnimator: ViewFloatAnimatics{
   override func _updateForTarget(t: TargetType) { t.frame.size.width += value }
}

class HeightAnimator: ViewFloatAnimatics{
   override func _updateForTarget(t: TargetType) { t.frame.size.height = value }
}

class DHeightAnimator: ViewFloatAnimatics{
   override func _updateForTarget(t: TargetType) { t.frame.size.height += value }
}

class AlphaAnimator: ViewFloatAnimatics {
   override func _updateForTarget(t: TargetType) { t.alpha = value }
}


class ViewPointAnimatics: AnimationSettingsHolder, AnimaticsViewChangesPerformer {
   typealias TargetType = UIView
   typealias ValueType = CGPoint
   
   let value: ValueType
   
   required init(_ v: ValueType){ value = v }
   
   func _updateForTarget(t: TargetType){ fatalError() }
}

class OriginAnimator: ViewPointAnimatics {
   override func _updateForTarget(t: TargetType) { t.frame.origin = value }
}

class DOriginAnimator: ViewPointAnimatics {
   override func _updateForTarget(t: TargetType) { t.frame.origin.x += value.x; t.frame.origin.y += value.y }
}

class CenterAnimator: ViewPointAnimatics {
   override func _updateForTarget(t: TargetType) { t.center = value }
}

class SizeAnimator: AnimationSettingsHolder, AnimaticsViewChangesPerformer {
   typealias TargetType = UIView
   typealias ValueType = CGSize
   
   let value: ValueType
   
   required init(_ v: ValueType){ value = v }
   
   func _updateForTarget(t: TargetType){ t.frame.size = value }
}



class FrameAnimator: AnimationSettingsHolder, AnimaticsViewChangesPerformer {
   typealias TargetType = UIView
   typealias ValueType = CGRect
   
   let value: ValueType
   
   required init(_ v: ValueType){ value = v }
   
   func _updateForTarget(t: TargetType){ t.frame = value }
}
