//
//  ViewController.m
//  UISliderCustomTrack
//
//  Created by Jinwoo Kim on 9/5/22.
//

#import "ViewController.h"
#import "UISlider+trackLocatedAtTheCenter.h"

@interface ViewController ()
@property (retain) UIImageView *imageView;
@property (retain) UIVisualEffectView *blurView;
@property (retain) UIVisualEffectView *vibrancyView;
@property (retain) UISlider *slider;
@end

@implementation ViewController

- (void)dealloc {
    [_imageView release];
    [_blurView release];
    [_vibrancyView release];
    [_slider release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"image"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self.view addSubview:imageView];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [NSLayoutConstraint activateConstraints:@[
        [imageView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [imageView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [imageView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [imageView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
    self.imageView = imageView;
    [imageView release];
    
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterialDark]];
    [self.view addSubview:blurView];
    blurView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [blurView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [blurView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [blurView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [blurView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
    self.blurView = blurView;
    
    UIVisualEffectView *vibrancyView = [[UIVisualEffectView alloc] initWithEffect:[UIVibrancyEffect effectForBlurEffect:(UIBlurEffect *)blurView.effect]];
    [blurView.contentView addSubview:vibrancyView];
    vibrancyView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [vibrancyView.topAnchor constraintEqualToAnchor:blurView.contentView.topAnchor],
        [vibrancyView.leadingAnchor constraintEqualToAnchor:blurView.contentView.leadingAnchor],
        [vibrancyView.trailingAnchor constraintEqualToAnchor:blurView.contentView.trailingAnchor],
        [vibrancyView.bottomAnchor constraintEqualToAnchor:blurView.contentView.bottomAnchor]
    ]];
    self.vibrancyView = vibrancyView;
    [blurView release];
    
    UISlider *slider = [UISlider new];
    slider.minimumValue = -1.0f;
    slider.maximumValue = 1.0f;
    slider.value = 0.0f;
    slider.trackLocatedAtTheCenter = YES;
    [vibrancyView.contentView addSubview:slider];
    slider.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [slider.leadingAnchor constraintEqualToAnchor:vibrancyView.contentView.leadingAnchor],
        [slider.trailingAnchor constraintEqualToAnchor:vibrancyView.contentView.trailingAnchor],
        [slider.centerYAnchor constraintEqualToAnchor:vibrancyView.contentView.centerYAnchor]
    ]];
    [vibrancyView release];
    [slider release];
}

@end
