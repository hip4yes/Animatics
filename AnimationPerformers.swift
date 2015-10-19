//
//  AnimationPerformers.swift
//  PokeScrum
//
//  Created by Nikita Arkhipov on 20.09.15.
//  Copyright © 2015 Anvics. All rights reserved.
//

import Foundation
import UIKit

protocol AnimaticsViewChangesPerformer: Animatics{
   func _updateForTarget(t: TargetType)
}

extension AnimaticsViewChangesPerformer{
   func _animateWithTarget(t: TargetType, completion: AnimaticsCompletionBlock?){
      ViewAnimationPerformer.sharedInstance.animate(self, target: t, completion: completion)
   }
}

final class ViewAnimationPerformer{
   class var sharedInstance : ViewAnimationPerformer {
      struct Static {
         static let instance = ViewAnimationPerformer()
      }
      return Static.instance
   }

   func animate<T: AnimaticsViewChangesPerformer>(animator: T, target: T.TargetType, completion: AnimaticsCompletionBlock?){
      if animator._isSpring{
         UIView.animateWithDuration(animator._duration, delay: animator._delay, usingSpringWithDamping: animator._springDumping, initialSpringVelocity: animator._springVelocity, options: animator._animationOptions, animations: { () -> Void in
            animator._updateForTarget(target)
            }, completion: completion)
      }else{
         UIView.animateWithDuration(animator._duration, delay: animator._delay, options: animator._animationOptions, animations: { () -> Void in
            animator._updateForTarget(target)
         }, completion: completion)
      }
   }
}

protocol AnimaticsLayerChangesPerformer: Animatics{
   func _animationKeyPath() -> String
}

extension AnimaticsLayerChangesPerformer where TargetType == UIView{
   func _animateWithTarget(t: TargetType, completion: AnimaticsCompletionBlock?){
      LayerAnimationPerformer.sharedInstance.animate(self, target: t.layer, completion: completion)
   }
}

extension AnimaticsLayerChangesPerformer where TargetType == CALayer{
   func _animateWithTarget(t: TargetType, completion: AnimaticsCompletionBlock?){
      LayerAnimationPerformer.sharedInstance.animate(self, target: t, completion: completion)
   }
}

extension AnimaticsLayerChangesPerformer where TargetType == CAGradientLayer{
   func _animateWithTarget(t: TargetType, completion: AnimaticsCompletionBlock?){
      LayerAnimationPerformer.sharedInstance.animate(self, target: t, completion: completion)
   }
}

final class LayerAnimationPerformer{
   class var sharedInstance : LayerAnimationPerformer {
      struct Static {
         static let instance = LayerAnimationPerformer()
      }
      return Static.instance
   }
   
   func animate<T: AnimaticsLayerChangesPerformer, U: CALayer>(animator: T, target: U, completion: AnimaticsCompletionBlock?){
      let key = animator._animationKeyPath()
      let fromValue = target.valueForKeyPath(key)
      target.setValue((animator.value as! AnyObject), forKeyPath: key)
      target.removeAnimationForKey(key)
      let animation = CABasicAnimation(keyPath: key)
      animation.duration = animator._duration
      animation.beginTime = animator._delay
      animation.fromValue = fromValue
      target.addAnimation(animation, forKey: key)
      Animatics_GCD_After(animator._duration + animator._delay) { completion?(true) }
   }
}
