# MMTransition

[![CI Status](http://img.shields.io/travis/millmanyang@gmail.com/MMTransition.svg?style=flat)](https://travis-ci.org/millmanyang@gmail.com/MMTransition)
[![Version](https://img.shields.io/cocoapods/v/MMTransition.svg?style=flat)](http://cocoapods.org/pods/MMTransition)
[![License](https://img.shields.io/cocoapods/l/MMTransition.svg?style=flat)](http://cocoapods.org/pods/MMTransition)
[![Platform](https://img.shields.io/cocoapods/p/MMTransition.svg?style=flat)](http://cocoapods.org/pods/MMTransition)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
    iOS 8.0+
    Xcode 8.0+
    Swift 3.0+
## Use
1.Add in your present controller
  
    class DialogViewController: UIViewController {
        let animator = MMAnimator<DialogConfig>()
        required init?(coder aDecoder: NSCoder) {
             super.init(coder: aDecoder)

             self.modalPresentationStyle = .custom
             self.transitioningDelegate = animator
             animator.activity { (config) in
                config.animateType = .scale(from: 0, to: 1)
                config.dialogType = .size(s: CGSize(width: 300, height: 200))
            }
       }
    }
2.Init with code

    let story = UIStoryboard.init(name: "Main", bundle: nil)
    let second = story.instantiateViewController(withIdentifier: "Second")
        
    menuAnimator.activity { (config) in
        config.isDraggable = true
        config.presentingScale = 1.0
    }
    second.modalPresentationStyle = .custom
    second.transitioningDelegate = menuAnimator
    self.present(second, animated: true, completion: nil)

## Setting parameter in activity closure
    menuAnimator.activity { (config) in
       config.isDraggable = true
       config.presentingScale = 1.0
       ......
       ....
       ..
    } 
## Style
1.Common parameter
    
    // presenting scale when present
    public var presentingScale: CGFloat
    // present controller animate damping
    public var damping: CGFloat
    // present controller animate option
    public var animationOption: UIViewAnimationOptions
    // present controller animate springVelocity
    public var springVelocity: CGFloat
    // present controller duration
    public var duration: TimeInterval

1.Menu parameter
     
     let menu = MMAnimator<MenuConfig>()
     
     1.Menu Type
        public var menuType:MenuTypepe 
        public enum MenuType {
           case leftWidth(w: CGFloat)
           case leftWidthFromViewRate(rate: CGFloat)
           case rightWidth(w: CGFloat)2
           case rightWidthFromViewRate(rate: CGFloat)
           case bottomHeight(h: CGFloat)
           case bottomHeightFromViewRate(rate: CGFloat)
           case leftFullScreen
           case rightFullScreen  
       }
     2.Set Drag
       public var isDraggable:Bool
     
2.Dialog parameter
  
    let dialog = MMAnimator<DialogConfig>()
    
    1.Dialog type
      public var dialogType:DialogType
      public enum DialogType {
         case preferSize //Xib use
         case size(s:CGSize) //Custom Size
      }
    2.Animate Type
      public var animateType:DialogAnimateType
      
      public enum DialogAnimateType {
        case alpha(from:CGFloat , to:CGFloat)
        case scale(from:CGFloat , to:CGFloat)
        case direction(type:DirectionType)
      }
     
      public enum DirectionType {
         case left
         case right
         case top
         case bottom
      }
## Installation

MMTransition is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "MMTransition"
```

## Author

millmanyang@gmail.com, millmanyang@gmail.com

## License

MMTransition is available under the MIT license. See the LICENSE file for more info.
