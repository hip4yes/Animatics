# Animatics
Declarative animations

##What wrong with UIView.animateWith?
The UIKit animation implementation is imperative and heavyweight. To chain several animations you should use UIView.animateKeyframesWithDuration which is VERY heavyweight beeing not flexible at the same time, or fall to a cycle of doom:
```
    UIView.animateWithDuration(0.7, animations: { () -> Void in
         
         }) { (_) -> Void in
               UIView.animateWithDuration(0.7, animations: { () -> Void in
               
               }) { (_) -> Void in
                  UIView.animateWithDuration(0.7, animations: { () -> Void in
                     
                  }) { (_) -> Void in
                        
                  }
               }
      }
```
which is looking disgusting.
Also you can not animate CALayer's properties in UIView's animation block. To animate them you should feed CABasicAnimation with 6-8 lines of code. 
Chaining several UIView animations with several CABasicAnimations using standard API feels like teleporting to hell. 
That the reason why even some senior developers are afraid of complex animations.

##Enough complains, move to solution
Animatics! It is shiny animation framework which provides easy-composable, easy-chainable, strongly typed, single-API for both UIView and CALayer animations and is lightweight as possible and declarative at the same time.

##OK, what can it do?
You can use it for wide range of tasks from simple animations (like Animatics deafult animation of changing UIView's alpha to 0):
```
AlphaAnimator(0) ~> testView
```
to chaining complex animations like lifting view up, moving it and lifting back:
```
let liftUp = ScaleAnimator(1.2) + ShadowRadiusAnimator(2)
let move = DXAnimator(150)
let liftBack = ScaleAnimator(1) + ShadowRadiusAnimator(0)
(liftUp |-> move |-> liftBack) ~> testView
```
you can also set specific settings for a single animator:
```
AlphaAnimator(0).duration(0.7).delay(0.7) ~> testView
```
and to group animation as a whole:
```
(liftUp |-> move |-> liftBack).duration(0.5).baseAnimation(.CurveEaseInOut) ~> testView
```
You can easily compose animation based on conditions:
```
var animation = XAnimation(200).duration(0.5)
if viewIsHidden { animation = AlphaAnimator(1) |-> animation }
if shouldHideOnComplete { animation = animation |-> AlphaAnimator(0) }
animation ~> targetView
```
and synchronize animations of different views:
```
let yellowViewAnimation = (BackgroundColorAnimator(UIColor.redColor()) + XAnimator(150).duration(0.6)).to(yellowView)
let greenViewAnimation = AlphaAnimator(1).to(greenView)
let blueViewAnimation = AlphaAnimator(0).to(blueView)
((yellowViewAnimation + greenViewAnimation) |-> blueViewAnimation).animate() 
// yellowViewAnimation and greenViewAnimation will be performed first and after both of them completes, blueViewAnimation will be performed
```

##So how it works?
###Foundation
In the foundation of the Animatics framework lies two most important types: `AnimaticsTargetWaiter` which represents an animation, that is waiting it's target (most commonly it is UIView):
```
protocol AnimaticsTargetWaiter: AnimaticsSettingsSetter{
   typealias TargetType
   func to(t: TargetType) -> AnimaticsReady
}
```
each Animator implements `AnimaticsTargetWaiter` protocol:
```
AlphaAnimator(1) //is AnimaticsTargetWaiter which waites UIView to perform animation
```
and `AnimaticsReady` which represents an animation that is ready to be performed:
```
protocol AnimaticsReady: AnimaticsSettingsSetter {
   func animate()
   func animateWithCompletion(completion: AnimaticsCompletionBlock?)
}
```
As can be seen from `AnimaticsTargetWaiter` declaration you can create `AnimaticsReady` by calling `to(t: TargetType)`. So to perform simple Alpha animation you will write:
```
AlphaAnimator(1).to(targetView).animate()
```
or you can use a shortcut operator `~>`:
```
AlphaAnimator(1) ~> targetView //equal to the previous line
```
###Chaining and composing
You can chain and compose animations. To compose animations use `+` operator:
```
//All animations will start at the same time
AlphaAnimator(1) + CornerRadiusAnimator(6) + ScaleAnimator(1.4)
```
you can compose all `AnimaticsReady` objects and any `AnimaticsTargetWaiter` objects that have the same `TargetType` (but not mix them). Composed `AnimaticsReady` becomes single `AnimaticsReady` object and composed `AnimaticsTargetWaiter` also becomes single `AnimaticsTargetWaiter` with the same `TargetType` as all composed objects:
```
let a1 = AlphaAnimator(1)//is AnimaticsTargetWaiter that waites UIView
let a2 = CornerRadiusAnimator(6)//also is AnimaticsTargetWaiter that waites UIView
let a3 = a1 + a2 //and this is also AnimaticsTargetWaiter that waites UIView
//you can animate it as normal AnimaticsTargetWaiter:
a3 ~> targetView
```
To chain animations use `|->` operator:
```
//alpha animation will start first and after it completes corner radius animation will start
AlphaAnimator(1) |-> CornerRadiusAnimator(6)
```
the behaviour of `|->` is the same as in `+`. Becouse of this you can easily create complex animations:
```
(AlphaAnimator(1) |-> (XAnimator(200) + ScaleAnimator(1.2)) |-> (ShadowRadiusAnimator(4) + RotateAnimator(3.14)) |-> AlphaAnimator(0)) ~> targetView
```
Imagine how hard it would be to create such animation with standard API?:)
##A word about settings
Both `AnimaticsTargetWaiter` and `AnimaticsReady` inherit `AnimaticsSettingsSetter` protocol:
```
protocol AnimaticsSettingsSetter{
   func duration(d: NSTimeInterval) -> Self
   func delay(d: NSTimeInterval) -> Self
   func baseAnimation(o: UIViewAnimationOptions) -> Self
   func springAnimation(dumping: CGFloat, velocity: CGFloat) -> Self
}
```
By default each animation is spring animation with dumping = 0.8, velocity = 0, duration = 0.3 s and delay = 0 s. Becouse each function returns `Self`, you can easily decorate animator in single line:
```
AlphaAnimator(1).duration(0.5).delay(0.3).baseAnimation(.CurveLinear) ~> targetView
```
In the same way you can also set setting to the group of animations:
```
((AlphaAnimator(1) + XAnimator(200)).duration(0.8) |-> AlphaAnimator(0)).baseAnimation(.CurveLinear) ~> targetView
//Both AlphaAnimator and XAnimator will have duration = 0.8, and all three animators will have baseAnimation(.CurveLinear)
```
##How to install?
Just grab all .swift files and add them to your project
##Licence
The MIT License (MIT)
Copyright (c) 2015 Nikita Arkhipov, Anvics.


