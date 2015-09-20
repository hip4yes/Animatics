# Animatics
Declarative animations

##What wrong with UIView.animateWith?
The UIKit animation implementation is imperative and heavyweight. Animatics trying to be as lightweight as possible and declarative at the same time.

##What can it do?
You can use it for wide range of tasks from simple animations (like Animatics deafult animation of changing UIView's alpha to 0):
```
AlphaAnimator(testView) ~> 0
```
to complex animations like lifting view up, moving it and lifting back:
```
let liftUp = ScaleAnimator(testView).to(1.1) + ShadowRadiusAnimator(testView).to(3)
let move = DXAnimator(testView).to(150)
let liftBack = ScaleAnimator(testView).to(1) + ShadowRadiusAnimator(testView).to(1)
(liftUp |~> move |~> liftBack).animate()
```

