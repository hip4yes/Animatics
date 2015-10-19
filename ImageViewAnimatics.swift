//
//  ImageViewAnimatics.swift
//  AnimationFramework
//
//  Created by Nikita Arkhipov on 14.09.15.
//  Copyright © 2015 Anvics. All rights reserved.
//

import Foundation
import UIKit

class ImageAnimator: AnimationSettingsHolder, Animatics {
   typealias TargetType = UIImageView
   typealias ValueType = UIImage
   
   let value: ValueType
   
   required init(_ v: ValueType){ value = v }
 
   func _animateWithTarget(t: TargetType, completion: AnimaticsCompletionBlock?){
      Animatics_GCD_After(_delay) {
         UIView.transitionWithView(t, duration: self._duration, options: self._animationOptions, animations: { () -> Void in
            t.image = self.value
         }, completion: completion)
      }

   }
}
