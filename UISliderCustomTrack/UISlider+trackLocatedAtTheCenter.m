//
//  UISlider+trackLocatedAtTheCenter.m
//  UISliderCustomTrack
//
//  Created by Jinwoo Kim on 9/5/22.
//

#import "UISlider+trackLocatedAtTheCenter.h"
#import <objc/runtime.h>

static void *_UISliderTrackLocatedAtTheCenterAssociationKey;

@implementation UISlider (trackLocatedAtTheCenter)

- (BOOL)isTrackLocatedAtTheCenter {
    NSNumber *value = objc_getAssociatedObject(self, &_UISliderTrackLocatedAtTheCenterAssociationKey);
    if (value == NULL) return NO;
    return value.boolValue;
}

- (void)setTrackLocatedAtTheCenter:(BOOL)trackLocatedAtTheCenter {
    [self willChangeValueForKey:@"trackLocatedAtTheCenter"];
    objc_setAssociatedObject(self, &_UISliderTrackLocatedAtTheCenterAssociationKey, [NSNumber numberWithBool:trackLocatedAtTheCenter], OBJC_ASSOCIATION_COPY);
    [self didChangeValueForKey:@"trackLocatedAtTheCenter"];
}

@end
