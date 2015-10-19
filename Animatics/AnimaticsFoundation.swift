//
//  AnimaticsFoundation.swift
//  AnimationFramework
//
//  Created by Nikita Arkhipov on 14.09.15.
//  Copyright © 2015 Anvics. All rights reserved.
//

import Foundation

protocol AnimaticsTargetWaiter: AnimaticsSettingsSetter{
   typealias TargetType
   func to(t: TargetType) -> AnimaticsReady
}

protocol Animatics: AnimaticsSettingsHolder, AnimaticsTargetWaiter{
   typealias ValueType
   
   var value: ValueType { get }
   
   init(_ v: ValueType)
   
   func _animateWithTarget(t: TargetType, completion: AnimaticsCompletionBlock?)
}

extension Animatics{
   func to(target: TargetType) -> AnimaticsReady{ return AnimationReady(animator: self, target: target) }
}

protocol AnimaticsReady: AnimaticsSettingsSetter {
   func animateWithCompletion(completion: AnimaticsCompletionBlock?)
}
extension AnimaticsReady{
   func animate(){ animateWithCompletion(nil) }
}

final class AnimationReady<T: Animatics>: AnimaticsReady, AnimaticsSettingsSettersWrapper {
   let animator: T
   let target: T.TargetType
   
   init(animator: T, target: T.TargetType){
      self.animator = animator
      self.target = target
   }
   
   func animateWithCompletion(completion: AnimaticsCompletionBlock? = nil){
      animator._animateWithTarget(target, completion: completion)
   }
   
   func getSettingsSetters() -> [AnimaticsSettingsSetter]{ return [animator] }
}

infix operator |-> { associativity left }
infix operator ~> {}
func ~><T: AnimaticsTargetWaiter>(a: T, t: T.TargetType){
   a.to(t).animate()
}

func Animatics_GCD_After(seconds: Double, block: () -> ()){
   let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(seconds * Double(NSEC_PER_SEC)))
   dispatch_after(delayTime, dispatch_get_main_queue()) {
      block()
   }
}

