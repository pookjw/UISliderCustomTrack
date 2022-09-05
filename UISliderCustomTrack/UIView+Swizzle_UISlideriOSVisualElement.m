//
//  UIView+Swizzle_UISlideriOSVisualElement.m
//  UISliderCustomTrack
//
//  Created by Jinwoo Kim on 9/5/22.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import "UISlider+trackLocatedAtTheCenter.h"

@implementation UIView (Swizzle_UISlideriOSVisualElement)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleWithClass:NSClassFromString(@"_UISlideriOSVisualElement")
              originalSelector:NSSelectorFromString(@"didPerformLayout")
              swizzledSelector:@selector(_UISlideriOSVisualElement_swizzledDidPerformLayout)];
    });
}

+ (void)swizzleWithClass:(Class)targetClass originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector {
    Method originalMethod = class_getInstanceMethod(targetClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(targetClass, swizzledSelector);
    
    IMP originalImp = method_getImplementation(originalMethod);
    IMP swizzledImp = method_getImplementation(swizzledMethod);
    
    class_replaceMethod(targetClass, swizzledSelector, originalImp, nil);
    class_replaceMethod(targetClass, originalSelector, swizzledImp, nil);
}

- (void)_UISlideriOSVisualElement_swizzledDidPerformLayout {
    [self _UISlideriOSVisualElement_swizzledDidPerformLayout];
    
    UISlider *slider = ((UISlider * (*)(UIView *, SEL))objc_msgSend)(self, NSSelectorFromString(@"slider"));
    if (!slider.trackLocatedAtTheCenter) return;
    
    float totalValue = (fabsf(slider.minimumValue) + fabsf(slider.maximumValue));
    if (totalValue == 0.0f) return;
    
    UIView *_minTrackClipView = [self valueForKey:@"_minTrackClipView"];
    UIView *_maxTrackClipView = [self valueForKey:@"_maxTrackClipView"];
    
    UIImageView *minTrackView = ((UIImageView * (*)(UIView *, SEL))objc_msgSend)(self, NSSelectorFromString(@"minTrackView"));
    UIImageView *maxTrackView = ((UIImageView * (*)(UIView *, SEL))objc_msgSend)(self, NSSelectorFromString(@"maxTrackView"));
    
    float totalWidth = _minTrackClipView.frame.size.width + _maxTrackClipView.frame.size.width;
    
    _maxTrackClipView.frame = CGRectMake(_minTrackClipView.frame.origin.x,
                                         _maxTrackClipView.frame.origin.y,
                                         _minTrackClipView.frame.size.width + _maxTrackClipView.frame.size.width,
                                         _maxTrackClipView.frame.size.height);
    maxTrackView.frame = CGRectMake(0.0f,
                                    maxTrackView.frame.origin.y,
                                    maxTrackView.frame.size.width,
                                    maxTrackView.frame.size.height);
    
    float percentage = (slider.value / totalValue);
    
    _minTrackClipView.frame = CGRectMake(_minTrackClipView.frame.origin.x + (totalWidth / 2.0f) + ((percentage > 0.0f) ? 0.0f : totalWidth * percentage),
                                         _minTrackClipView.frame.origin.y,
                                         fabsf(totalWidth * percentage),
                                         _minTrackClipView.frame.size.height);
}

@end
