//
//  AnimaticsSettings.swift
//  PokeScrum
//
//  Created by Nikita Arkhipov on 14.10.15.
//  Copyright © 2015 Anvics. All rights reserved.
//

import Foundation
import UIKit

typealias AnimaticsCompletionBlock = Bool -> Void

protocol AnimaticsSettingsSetter{
   func duration(d: NSTimeInterval) -> Self
   func delay(d: NSTimeInterval) -> Self
   func baseAnimation(o: UIViewAnimationOptions) -> Self
   func springAnimation(dumping: CGFloat, velocity: CGFloat) -> Self
}

protocol AnimaticsSettingsHolder: AnimaticsSettingsSetter{
   var _duration: NSTimeInterval { get set }
   var _delay: NSTimeInterval  { get set }
   var _animationOptions: UIViewAnimationOptions { get set }
   var _isSpring: Bool { get set }
   var _springDumping: CGFloat { get set }
   var _springVelocity: CGFloat { get set }
   var _completion: AnimaticsCompletionBlock? { get set }
}

class AnimationSettingsHolder: AnimaticsSettingsHolder{
   var _duration: NSTimeInterval = 0.35
   var _delay: NSTimeInterval = 0
   var _animationOptions: UIViewAnimationOptions = UIViewAnimationOptions()
   var _isSpring: Bool = true
   var _springDumping: CGFloat = 0.8
   var _springVelocity: CGFloat = 0
   var _completion: AnimaticsCompletionBlock? = nil
   
   func duration(d: NSTimeInterval) -> Self{
      _duration = d
      return self
   }
   
   func delay(d: NSTimeInterval) -> Self{
      _delay = d
      return self
   }
   
   func baseAnimation(o: UIViewAnimationOptions = UIViewAnimationOptions.CurveEaseInOut) -> Self{
      _isSpring = false
      _animationOptions = o
      return self
   }
   
   func springAnimation(dumping: CGFloat = 0.8, velocity: CGFloat = 0) -> Self{
      _isSpring = true
      _springDumping = dumping
      _springVelocity = velocity
      return self
   }
}

protocol AnimaticsSettingsSettersWrapper: AnimaticsSettingsSetter {   
   func getSettingsSetters() -> [AnimaticsSettingsSetter]
}

extension AnimaticsSettingsSettersWrapper{
   func duration(d: NSTimeInterval) -> Self{
      for s in getSettingsSetters(){ s.duration(d) }
      return self
   }
   
   func delay(d: NSTimeInterval) -> Self{
      for s in getSettingsSetters(){ s.delay(d) }
      return self
      
   }
   func baseAnimation(o: UIViewAnimationOptions = UIViewAnimationOptions.CurveEaseInOut) -> Self{
      for s in getSettingsSetters(){ s.baseAnimation(o) }
      return self
   }
   
   func springAnimation(dumping: CGFloat = 0.8, velocity: CGFloat = 0) -> Self{
      for s in getSettingsSetters(){ s.springAnimation(dumping, velocity: velocity) }
      return self
   }
}