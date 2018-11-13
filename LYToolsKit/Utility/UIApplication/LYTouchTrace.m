//
//  LYTouchTrace.m
//
//  茗玥古城
//
//  Created by 似水灵修 on 13-11-11.
//  Copyright (c) 2013年 MingYueGuCheng. All rights reserved.
//

#import "LYTouchTrace.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

@interface LYTouchTrace ()
- (void)updateTouches:(NSSet *)touches;
- (void)applicationDidFinishLaunching:(NSNotification *)notification;
- (void)screenDidConnectNotification:(NSNotification *)notification;
- (void)screenDidDisonnectNotification:(NSNotification *)notification;
- (void)keyboardDidShowNotification:(NSNotification *)notification;
- (void)keyboardDidHideNotification:(NSNotification *)notification;
- (BOOL)hasMirroredScreen;
- (void)keyWindowChanged:(UIWindow *)window;
- (void)bringTouchViewToFront;

@end

// The LYTouchposeFingerView is used to render a finger touches on the screen.
@interface LYTouchposeFingerView : UIView

@property (nonatomic, strong) UIImageView *touchImageView;

- (id)initWithPoint:(CGPoint)point hue:(CGFloat)hue imageName:(NSString *)imageName;

@end

@implementation LYTouchposeFingerView
#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame {
    return [self initWithPoint:(CGPoint){-frame.size.width, -frame.size.height} hue:0.0f imageName:nil];
}

#pragma mark - LYTouchposeFingerView

- (id)initWithPoint:(CGPoint)point hue:(CGFloat)hue imageName:(NSString *)imageName {
    const CGFloat kFingerRadius = 14.50f;
    
    if ((self = [super initWithFrame:CGRectMake(point.x-kFingerRadius, point.y-kFingerRadius, 2*kFingerRadius, 2*kFingerRadius)])) {
        
        if (imageName.length > 0) {
            if (_touchImageView == nil) {
                _touchImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
            }else {
            }
            
            [self addSubview:_touchImageView];
        }else {
            self.opaque = NO; //Result = Source + Destination * (1 - SourceAlpha), opaque = YES SourceAlpha = 1,
            self.layer.borderColor = [UIColor colorWithHue:hue saturation:0.5f brightness:0.5f alpha:0.6f].CGColor;
            self.layer.cornerRadius = kFingerRadius;
            self.layer.borderWidth = 2.0f;
            self.layer.backgroundColor = [UIColor colorWithHue:hue saturation:0.5f brightness:0.5f alpha:0.4f].CGColor;
        }
        
        self.userInteractionEnabled = NO;
    }
    return self;
}

@end

IMP SwizzleMethod(Class c, SEL sel, IMP newImplementation)
{
    Method method = class_getInstanceMethod(c, sel);
    IMP originalImplementation = method_getImplementation(method);
    if (!class_addMethod(c, sel, newImplementation, method_getTypeEncoding(method)))
        method_setImplementation(method, newImplementation);
    return originalImplementation;
}

static void (*UIWindow_orig_becomeKeyWindow)(UIWindow *, SEL);

// This method replaces -[UIWindow becomeKeyWindow] (but calls the original -becomeKeyWindow). This
// is used to move the overlay to the current key window.
static void UIWindow_new_becomeKeyWindow(UIWindow *window, SEL _cmd)
{
    LYTouchTrace *application = (LYTouchTrace *)[UIApplication sharedApplication];
    [application keyWindowChanged:window];
    (*UIWindow_orig_becomeKeyWindow)(window, _cmd);
}

static void (*UIWindow_orig_didAddSubview)(UIWindow *, SEL, UIView *);

// This method replaces -[UIWindow didAddSubview:] (but calls the original -didAddSubview:). This is
// used to keep the overlay view the top-most view of the window.
static void UIWindow_new_didAddSubview(UIWindow *window, SEL _cmd, UIView *view)
{
    if (![view isKindOfClass:[LYTouchposeFingerView class]])
    {
        LYTouchTrace *application = (LYTouchTrace *)[UIApplication sharedApplication];
        [application bringTouchViewToFront];
    }
    (*UIWindow_orig_didAddSubview)(window, _cmd, view);
}


@implementation LYTouchTrace
{
    // Dictionary of touches being displayed. Keys are UITouch pointers and values are UIView pointers.
    __block CFMutableDictionaryRef _touchDictionary;
    UIView *_touchView;
    CGFloat _touchHue;
    BOOL _showTouches;
    BOOL _alwaysShowTouches;
    BOOL _showTouchesWhenKeyboardShown;
}

#pragma mark - NSObject

+ (NSUInteger)majorSystemVersion {
    NSArray *versionComponents = [[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."];
    return [[versionComponents objectAtIndex:0] integerValue];
}

- (id)init {
    if ((self = [super init])) {
        _touchDictionary = CFDictionaryCreateMutable(NULL, 10, NULL, NULL);
        _touchHue = 0.55f;
        _alwaysShowTouches = YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidFinishLaunching:) name:UIApplicationDidFinishLaunchingNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenDidConnectNotification:) name:UIScreenDidConnectNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenDidDisonnectNotification:) name:UIScreenDidDisconnectNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShowNotification:) name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHideNotification:) name:UIKeyboardDidHideNotification object:nil];
        
        // In my experience, the keyboard performance is crippled when showing touches on a
        // device running iOS < 5, so by default, disable touches when the keyboard is
        // present.
        _showTouchesWhenKeyboardShown = [[self class] majorSystemVersion] >= 5;
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    CFRelease(_touchDictionary);
}


#pragma mark - UIApplication

- (void)sendEvent:(UIEvent *)event
{
    [super sendEvent:event];
    if (_showTouches)
        [self updateTouches:[event allTouches]];
}

#pragma mark - LYTouchTrace
- (void)removeTouchesActiveTouches:(NSSet *)activeTouches {
    CFIndex count = CFDictionaryGetCount(_touchDictionary);
    const void **keys = alloca(sizeof(UITouch *) * count);
    const void **values = alloca(sizeof(UIView *) * count);
    CFDictionaryGetKeysAndValues(_touchDictionary, keys, values);
    
    for (CFIndex i = 0; i < count; ++i) {
        UITouch *touch = (__bridge UITouch *)(keys[i]);
        if (activeTouches == nil || ![activeTouches containsObject:touch]) {
            UIView *view = (__bridge UIView *)(values[i]);
            CFDictionaryRemoveValue(_touchDictionary, (__bridge const void *)(touch));
            [UIView animateWithDuration:0.5f animations:^{
                view.alpha = 0.0f;
            } completion:^(BOOL completed){
                [view removeFromSuperview];
            }];
        }
    }
}

- (void)updateTouches:(NSSet *)touches {
    [touches enumerateObjectsUsingBlock:^(UITouch  *_Nonnull touch, BOOL * _Nonnull stop) {
        CGPoint point = [touch locationInView:self->_touchView];
        UIView *fingerView = (UIView *)CFDictionaryGetValue(self->_touchDictionary, (__bridge const void *)(touch));
        if (touch.phase == UITouchPhaseCancelled || touch.phase == UITouchPhaseEnded) {
            // Note that there seems to be a bug in iOS: we won't observe all UITouches
            // in the UITouchPhaseEnded phase, resulting in some finger views being left
            // on the screen when they shouldn't be. See
            // https://discussions.apple.com/thread/1507669?start=0&tstart=0 for other's
            // comments about this issue. No workaround is implemented here.
            
            if (fingerView != NULL) {
                // Remove the touch from the
                CFDictionaryRemoveValue(self->_touchDictionary, (__bridge const void *)(touch));
                [UIView animateWithDuration:0.5f animations:^{
                    fingerView.alpha = 0.0f;
                } completion:^(BOOL completed){
                    [fingerView removeFromSuperview];
                }];
            }
        } else {
            if (fingerView == NULL) {
                if (touch.window) {
                    fingerView = [[LYTouchposeFingerView alloc] initWithPoint:point hue:self->_touchHue imageName:self->_touchImageName];
                    [self->_touchView addSubview:fingerView];
                    CFDictionarySetValue(self->_touchDictionary, (__bridge const void *)(touch), (__bridge const void *)(fingerView));
                }
            } else {
                fingerView.center = point;
            }
        }
    }];

    [self removeTouchesActiveTouches:touches];
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    // We intercept calls to -becomeKeyWindow and -didAddSubview of UIWindow to manage the
    // overlay view QTouchposeTouchesView and ensure it remains the top-most window.
    UIWindow_orig_didAddSubview = (void (*)(UIWindow *, SEL, UIView *))SwizzleMethod([UIWindow class], @selector(didAddSubview:), (IMP)UIWindow_new_didAddSubview);
    UIWindow_orig_becomeKeyWindow = (void (*)(UIWindow *, SEL))SwizzleMethod([UIWindow class], @selector(becomeKeyWindow), (IMP)UIWindow_new_becomeKeyWindow);
    
    self.showTouches = _alwaysShowTouches || [self hasMirroredScreen];
}

- (void)screenDidConnectNotification:(NSNotification *)notification {
    self.showTouches = _alwaysShowTouches || [self hasMirroredScreen];
}

- (void)screenDidDisonnectNotification:(NSNotification *)notification {
    self.showTouches = _alwaysShowTouches || [self hasMirroredScreen];
}

- (void)keyboardDidShowNotification:(NSNotification *)notification {
    self.showTouches = _showTouchesWhenKeyboardShown && (_alwaysShowTouches || [self hasMirroredScreen]);
}

- (void)keyboardDidHideNotification:(NSNotification *)notification {
    self.showTouches = _alwaysShowTouches || [self hasMirroredScreen];
}

- (void)keyWindowChanged:(UIWindow *)window {
    if (_touchView)
        [window addSubview:_touchView];
}

- (void)bringTouchViewToFront {
    if (_touchView)
        [_touchView.window bringSubviewToFront:_touchView];
}

- (BOOL)hasMirroredScreen {
    __block BOOL hasMirroredScreen = NO;
    NSArray *screens = [UIScreen screens];
    [screens enumerateObjectsUsingBlock:^(UIScreen  *_Nonnull screen, NSUInteger idx, BOOL * _Nonnull stop) {
        if (screen.mirroredScreen != nil) {
            hasMirroredScreen = YES;
            *stop = YES;
        }
    }];
    
    return hasMirroredScreen;
}

- (void)setShowTouches:(BOOL)showTouches {
    if (showTouches) {
        if (_touchView == nil && self.keyWindow)
        {
            UIWindow *window = self.keyWindow;
            _touchView = [[LYTouchposeFingerView alloc] initWithFrame:window.bounds];
            [window addSubview:_touchView];
        }
    }else {
        [self removeTouchesActiveTouches:nil];
        if (_touchView) {
            [_touchView removeFromSuperview];
            _touchView = nil;
        }
    }
    _showTouches = showTouches;
}

@end
