# MMTransition

[![CI Status](http://img.shields.io/travis/millmanyang@gmail.com/MMTransition.svg?style=flat)](https://travis-ci.org/millmanyang@gmail.com/MMTransition)
[![Version](https://img.shields.io/cocoapods/v/MMTransition.svg?style=flat)](http://cocoapods.org/pods/MMTransition)
[![License](https://img.shields.io/cocoapods/l/MMTransition.svg?style=flat)](http://cocoapods.org/pods/MMTransition)
[![Platform](https://img.shields.io/cocoapods/p/MMTransition.svg?style=flat)](http://cocoapods.org/pods/MMTransition)

## Description

  1. Custom PresentmodaController with UIPresentationController and UIViewControllerTransitioningDelegate ,
  2. More convenience to custom your dialog or menu 

## Demo
![demo](https://github.com/MillmanY/MMTransition/blob/master/demo/dialog.gif)
![demo](https://github.com/MillmanY/MMTransition/blob/master/demo/menu.gif)
![demo](https://github.com/MillmanY/MMTransition/blob/master/demo/demo2.gif)


## Requirements
    iOS 8.0+
    Xcode 8.0+
    Swift 3.0+
## Use (Menu / Dialog)
1.Add in your present controller
  
    class DialogViewController: UIViewController {
        required init?(coder aDecoder: NSCoder) {
             super.init(coder: aDecoder)
        
             self.mmT.present.dialog { (config) in
                config.animateType = .scale(from: 0, to: 1)
                config.dialogType = .size(s: CGSize(width: 300, height: 200))
             }
        }
    }
2.Init with code

    let story = UIStoryboard.init(name: "Main", bundle: nil)
    let second = story.instantiateViewController(withIdentifier: "Second")
        
    second.mmT.present.menu { (config) in
            config.isDraggable = true
            config.presentingScale = 1.0
            config.menuType = .bottomHeight(h: 200)
    }

    self.present(second, animated: true, completion: nil)
## Use (pass view)

1.PassViewFromProtocol use on where you want to pass view 
    
    // Thsis is you passView
    var passView: UIView { get }
    // when transition dismiss or popView you need reset your UI
    func completed(passView: UIView,superV: UIView)
2.PassViewToProtocol use on target controller
    
    //your pass view's superView 
    var containerView: UIView { get }
    
    // Thsis two method can let you get view from previous controller
    // you need set your constraint when transition completed
    func transitionWillStart(passView: UIView)
    func transitionCompleted(passView: UIView)

## Setting parameter in activity closure

    vc.mmT.present.menu { (config) in
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
pod 'MMTransition'
pod 'MMTransition', '1.0.0'

ex. if you can't see command (pod repo update) in terminal
```

## Author

millmanyang@gmail.com

## License

MMTransition is available under the MIT license. See the LICENSE file for more info.
