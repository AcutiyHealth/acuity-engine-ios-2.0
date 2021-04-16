//
//  RotaryWheel.m
//  AcuityCircle
//
//  Created by Pradip Gami on 11/09/15.
//  Copyright (c) 2015 Pradip Gami. All rights reserved.
//


#import "RotaryWheel.h"
#import <QuartzCore/QuartzCore.h>
#import "Chevron.h"

#define kChevronHeight 180
#define kChevronWidth 80
#define kAcuityCircleWidth  360
#define kAcuityCircleHeight  360
#define BLUECOLORLABELTITLE [UIColor colorWithRed:41.0/255.0 green:121.0/255.0 blue:255.0/255.0 alpha:1.0]
#define SUBMENUITEMTITLECOLOR [UIColor colorWithRed:206.0/255.0 green:216.0/255.0 blue:220.0/255.0 alpha:1.0]
#define MENULISTBACKGROUNDCOLOR [UIColor colorWithRed:69.0/255.0 green:90.0/255.0 blue:100.0/255.0 alpha:1.0]
#define REDCOLOR [UIColor colorWithRed:244.0/255.0 green:67.0/255.0 blue:54.0/255.0 alpha:1.0]
#define GREENCOLOR [UIColor colorWithRed:46.0/255.0 green:125.0/255.0 blue:50.0/255.0 alpha:1.0]
#define YELLOWCOLOR [UIColor colorWithRed:255.0/255.0 green:152.0/255.0 blue:0.0/255.0 alpha:1.0]
#define GRAYCOLOR [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1.0]
#define kDailyScheduleDateFormatter @"EEEE, dd MM yyyy"
static float deltaAngle;
//static float minAlphavalue = 0.6;
static float maxAlphavalue = 1.0;

@implementation RotaryWheel

@synthesize delegate, container, numberOfSections, startTransform, chevrons, currentValue,selectedSystem,arrBodySystems;
@synthesize roundbackGroundView;


// ------------------------------------------------------------------------------------

#pragma mark
#pragma mark  View Initialization methods

// ------------------------------------------------------------------------------------

- (id) initWithFrame:(CGRect)frame andDelegate:(id)del withSections:(int)noOfSection bodySystems : (NSMutableArray *) arrBody selectedSystem:(int)selSystem needToRotateChevron:(BOOL)needToRotateChevron {
    if ((self = [super initWithFrame:frame])) {
        self.currentValue = 0;
        deltaAngle = 0.0;
        self.numberOfSections = noOfSection;
        self.delegate = del;
        self.arrBodySystems = arrBody;
        self.selectedSystem = selSystem;
        _needToRotateChevron = needToRotateChevron;
        [self drawWheel];
    }
    return self;
}

// ------------------------------------------------------------------------------------

#pragma mark
#pragma mark  Custom methods

// ------------------------------------------------------------------------------------

/***

This method is responsible for gerenarting wheel with different views.
1. Container - This is the main view and all chevrons will be added in this view.
2. roundbackGroundView - This view will be responsible for providing background as per selected index to system.
3. _whiteCircleContainerView - This view contains white circle image view and hidden chevrons.
 
_panGestureRecognizer - This gesture will be responsible for rotating chevrons.
whiteImageViewpanGestureRecognizer - This gesture will be responsible for rotating white circle view.
tapGestureRecognizer - This gesture will be responsible for handling tap event of chevrons.
 
angle size is used to calculate the angles based on number of sections, angle value will be in respect to M_PI
 
chevrons will be used for smooth rotating, using min, mid and max value.
 
***/
- (void) drawWheel {
    container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    _panGestureRecognizer =[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(recognizeCircularViewGesture:)];
    _panGestureRecognizer.delegate = (id)self;
    [container addGestureRecognizer:_panGestureRecognizer];
    /*
     In this, circle will have 360 degree and number of angle will be number of sections. so chevron width(kChevronWidth) will be change accordingly. kChevronHeight is kAcuityCircleHeight/2
     Arc length = Angle * Radius
     kChevronWidth = Angle * kChevronHeight
     If 14 system is there... Angle = (2 * 3.14)/14 so It will be 0.4485.
     kChevronWidth = 0.4485 * 180 = 80
     */
    CGFloat angleSize = 2*M_PI/numberOfSections;
    
    for (int i = 0; i < numberOfSections; i++) {
        UIView *chevronView = [[UIView alloc] init];
        [chevronView setBackgroundColor:[UIColor redColor]];
        chevronView.layer.anchorPoint = CGPointMake(0.5f,1.0f);
        [chevronView setBackgroundColor:[UIColor clearColor]];
        chevronView.layer.bounds = CGRectMake(0.0, 0.0,self.bounds.size.width*kChevronWidth/340,self.bounds.size.width*kChevronHeight/340);
        chevronView.layer.position = CGPointMake(CGRectGetMidX(self.bounds),CGRectGetMidY(self.bounds));
        chevronView.transform = CGAffineTransformMakeRotation(angleSize*i);
        chevronView.userInteractionEnabled = YES;
        chevronView.backgroundColor = [UIColor clearColor];
        chevronView.alpha = maxAlphavalue;
        chevronView.tag = i;
        
        if (i == 0) {
            chevronView.alpha = maxAlphavalue;
        }
        
        UIImageView *chevronImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0,self.bounds.size.width*kChevronWidth/340,self.bounds.size.width*kChevronHeight/340)];
        chevronImageView.tag = i;
        chevronImageView.userInteractionEnabled = YES;
        chevronImageView.backgroundColor = [UIColor clearColor];
        
        NSString *strThemeColor = [self getThemeColor:[[arrBodySystems objectAtIndex:i] objectForKey:@"score"]];
        
        if([[strThemeColor uppercaseString] isEqualToString:@"RED"]){
            if(i != selectedSystem){
                chevronImageView.image = [UIImage imageNamed:@"red_chevron"];
            }else{
                chevronImageView.image = [UIImage imageNamed:@"red_chevron"];
            }
        }else if ([[strThemeColor uppercaseString] isEqualToString:@"GREEN"]){
            if(i != selectedSystem){
                chevronImageView.image = [UIImage imageNamed:@"green_chevron"];
            }else{
                chevronImageView.image = [UIImage imageNamed:@"green_chevron"];
            }
        }else{
            if(i != selectedSystem){
                chevronImageView.image = [UIImage imageNamed:@"yellow_chevron"];
            }else{
                chevronImageView.image = [UIImage imageNamed:@"yellow_chevron"];
            }
        }
        
        UITapGestureRecognizer *tapGestureRecognizer =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(recognizeChevronGesture:)];
        tapGestureRecognizer.delegate = (id)self;
        [chevronImageView addGestureRecognizer:tapGestureRecognizer];
        CGFloat x = 22;
        if (self.frame.size.width<290) {
            x = 18;
        }
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x*self.bounds.size.width/kAcuityCircleWidth, 5, 38,25)];
        [imageView setUserInteractionEnabled:NO];
        [imageView setTag:9999];
       
        //cardiovascular
        //[imageView setImage:[UIImage imageNamed:@"cardiovascular.png"]];
        [imageView setImage:[UIImage imageNamed:[[arrBodySystems objectAtIndex:i] objectForKey:@"image"]]];
        [imageView setContentMode:UIViewContentModeScaleAspectFit];
        imageView.backgroundColor = UIColor.clearColor;
        [chevronView addSubview:chevronImageView];
        [chevronView addSubview:imageView];
        [container addSubview:chevronView];
    }
    
    [self addSubview:container];

    chevrons = [NSMutableArray arrayWithCapacity:numberOfSections];
    
    if (numberOfSections % 2 == 0) {
        [self buildChevronsEven];
        
    } else {
        [self buildChevronsOdd];
    }
    
    _whiteCircleContainerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.frame.size.width, self.frame.size.height)];
    [_whiteCircleContainerView setBackgroundColor:[UIColor clearColor]];
    
    roundbackGroundView = [[UIView alloc] initWithFrame:CGRectMake(30,30, _whiteCircleContainerView.frame.size.width - 60, _whiteCircleContainerView.frame.size.height - 60)];
    roundbackGroundView.layer.cornerRadius = roundbackGroundView.frame.size.height/2;
    roundbackGroundView.center = CGPointMake(_whiteCircleContainerView.center.x, _whiteCircleContainerView.center.y);
    roundbackGroundView.backgroundColor = UIColor.clearColor;
    [roundbackGroundView setUserInteractionEnabled:NO];
    
    [self addSubview:roundbackGroundView];
    
   UIImageView *whiteCircleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30,30, _whiteCircleContainerView.frame.size.width - 52, _whiteCircleContainerView.frame.size.height - 52)];
    whiteCircleImageView.image = [UIImage imageNamed:@"white_circle"];
    [whiteCircleImageView setUserInteractionEnabled:NO];
    //whiteCircleImageView.layer.anchorPoint = CGPointMake(0.5f,0.5f);
    [whiteCircleImageView setBackgroundColor:[UIColor clearColor]];
    whiteCircleImageView.center = CGPointMake(_whiteCircleContainerView.center.x, _whiteCircleContainerView.center.y);
    [_whiteCircleContainerView addSubview:whiteCircleImageView];
    [self addSubview:_whiteCircleContainerView];
    
    UIPanGestureRecognizer *whiteImageViewpanGestureRecognizer =[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(recognizeWhiteCircleViewGesture:)];
    whiteImageViewpanGestureRecognizer.delegate = (id)self;
    [_whiteCircleContainerView addGestureRecognizer:whiteImageViewpanGestureRecognizer];
    
    if(_needToRotateChevron){
        [container setUserInteractionEnabled:YES];
        _whiteCircleContainerView.userInteractionEnabled = NO;
    }
    else{
       [self generateHiddenChevron];
       [container setUserInteractionEnabled:NO];
        _whiteCircleContainerView.userInteractionEnabled = YES;
    }
    roundbackGroundView.backgroundColor = [RotaryWheel getThemeColor:[[arrBodySystems objectAtIndex:selectedSystem] objectForKey:@"score"]];

    [self makeviewRounded:roundbackGroundView];
    [self makeviewRounded:_whiteCircleContainerView];
    
    [self.delegate wheelDidChangeValue:selectedSystem];
}
#pragma mark - Make Rounded view
-(void)makeviewRounded:(UIView* )view{
    view.layer.cornerRadius = view.frame.size.height/2;
    view.clipsToBounds = YES;
    view.layer.masksToBounds = YES;
}

#pragma mark -
+ (UIColor *)getThemeColor:(NSString *)index {
    int indexValue = [index intValue];
    if (indexValue > 0 && indexValue <= 75) {
        return REDCOLOR;
    } else if (indexValue > 75 && indexValue <= 85) {
        return YELLOWCOLOR;
    } else {
        return GREENCOLOR;
    }
}
// ------------------------------------------------------------------------------------

/***
 
 This method is responsible for gerenarting hidden chevrons.
 This chevrons will be used to handle tap event of chevrons while white circle rotation is selected.
***/

- (void) generateHiddenChevron{
    CGFloat angleSize = 2*M_PI/numberOfSections;
    for (int i = 0; i < numberOfSections; i++) {
        UIView *chevronView = [[UIView alloc] init];
        [chevronView setBackgroundColor:[UIColor clearColor]];
        chevronView.layer.anchorPoint = CGPointMake(0.5f,1.0f);
        [chevronView setBackgroundColor:[UIColor clearColor]];
        chevronView.layer.bounds = CGRectMake(0.0, 0.0,kChevronWidth,kChevronHeight);
        chevronView.layer.position = CGPointMake(CGRectGetMidX(self.bounds),CGRectGetMidY(self.bounds));
        chevronView.transform = CGAffineTransformMakeRotation(angleSize*i);
        chevronView.userInteractionEnabled = YES;
        chevronView.backgroundColor = [UIColor clearColor];
        chevronView.alpha = maxAlphavalue;
        chevronView.tag = i;
        
        if (i == 0) {
            chevronView.alpha = maxAlphavalue;
        }
        
        UIImageView *chevronImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, kChevronWidth, kChevronHeight)];
        chevronImageView.tag = i;
        chevronImageView.userInteractionEnabled = YES;
        chevronImageView.backgroundColor = [UIColor clearColor];
        
        UITapGestureRecognizer *tapGestureRecognizer =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(recognizeChevronGesture:)];
        tapGestureRecognizer.delegate = (id)self;
        [chevronImageView addGestureRecognizer:tapGestureRecognizer];
        
        [chevronView addSubview:chevronImageView];
        [_whiteCircleContainerView addSubview:chevronView];
    }
    chevrons = [NSMutableArray arrayWithCapacity:numberOfSections];
    if (numberOfSections % 2 == 0) {
        
        [self buildChevronsEven];
        
    } else {
        
        [self buildChevronsOdd];
    }
}

// ------------------------------------------------------------------------------------

/***
 
 This method is responsible for gerenarting Even chevron object.
 
***/

- (void) buildChevronsEven {
    
    CGFloat fanWidth = M_PI*2/numberOfSections;
    CGFloat mid = 0;
    
    for (int i = 0; i < numberOfSections; i++) {
        Chevron *chevron = [[Chevron alloc] init];
        chevron.minValue = mid - (fanWidth/2);
        chevron.midValue = mid;
        chevron.maxValue = mid + (fanWidth/2);
        chevron.value = i;
        
        if (chevron.maxValue-fanWidth < - M_PI){
            mid = M_PI;
            chevron.midValue = mid;
            chevron.minValue = fabsf(chevron.maxValue);
        }
        
        mid -= fanWidth;
        [chevrons addObject:chevron];
    }
}

// ------------------------------------------------------------------------------------

/***
 
 This method is responsible for gerenarting Odd chevron object.
 
***/

- (void) buildChevronsOdd {
    
    CGFloat fanWidth = M_PI*2/numberOfSections;
    CGFloat mid = 0;
    
    for (int i = 0; i < numberOfSections; i++) {
        Chevron *chevron = [[Chevron alloc] init];
        chevron.minValue = mid - (fanWidth/2);
        chevron.midValue = mid;
        chevron.maxValue = mid + (fanWidth/2);
        chevron.value = i;
        
        mid -= fanWidth;
        
        if (chevron.minValue < - M_PI) {
            mid = -mid;
            mid -= fanWidth;
        }
        
        //NSLog(@"Chevron : %@",[chevron description]);
        
        [chevrons addObject:chevron];
    }
}

// ------------------------------------------------------------------------------------

/***
 
This method will return color string based on index value.
 
***/

-(NSString *)getThemeColor:(NSString *)index{
    int indexValue = [index intValue];
    
    if(indexValue > 0 && indexValue <= 75){
        return @"RED";
    }else if (indexValue > 75 && indexValue <= 85){
        return @"YELLOW";
    }else{
        return @"GREEN";
    }
}

// ------------------------------------------------------------------------------------

/***
 
 calculateDistanceFromCenter will be used to calculate the disctance from center to specified point in the argument. This will be help to find if touch is on wheel or outside the wheel.
 
***/

- (float) calculateDistanceFromCenter:(CGPoint)point {
    
    CGPoint center = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0f);
    float dx = point.x - center.x;
    float dy = point.y - center.y;
    return sqrt(dx*dx + dy*dy);
}

// ------------------------------------------------------------------------------------

/***
 
 This method will rotate chevron or white circle based on needToRotateChevron value.
 This method will set white circle image to its original position if chevron rotation mode is selected or set the chevron wheel default position
***/

- (void) toggleRotation:(BOOL) needToRotateChevron{
    _needToRotateChevron = needToRotateChevron;
    if(needToRotateChevron){
         [container setUserInteractionEnabled:YES];
        _whiteCircleContainerView.userInteractionEnabled = NO;
         _whiteCircleContainerView.transform = CGAffineTransformIdentity;
    }
    else{
        [self generateHiddenChevron];
         [container setUserInteractionEnabled:YES];
        _whiteCircleContainerView.userInteractionEnabled = YES;
        [self redrawWheel:selectedSystem];
    }
}

// ------------------------------------------------------------------------------------

/***
 
 This method will transform chevron wheel and white circle based on selected index and previous index
***/

- (void) transformWheel:(BOOL) needToRotateChevron andselectedIndex:(int)selectedIndex andPreviousIndex:(int)previousIndex{
    _needToRotateChevron = needToRotateChevron;
    if(needToRotateChevron){
        double requiredRotationAngle = (numberOfSections-(selectedIndex-previousIndex))*(2*M_PI/numberOfSections);
        container.transform = CGAffineTransformRotate(container.transform, requiredRotationAngle);
        currentValue = selectedIndex;
        roundbackGroundView.backgroundColor = [RotaryWheel getThemeColor:[[arrBodySystems objectAtIndex:selectedSystem] objectForKey:@"score"]];
        [self.delegate wheelDidChangeValue:selectedIndex];
    }
    else{
        double requiredRotationAngle = (selectedIndex-previousIndex)*(2*M_PI/numberOfSections);
        _whiteCircleContainerView.transform = CGAffineTransformRotate(_whiteCircleContainerView.transform,requiredRotationAngle);
        currentValue = selectedIndex+currentValue;
        if(currentValue > numberOfSections-1)
            currentValue = currentValue-numberOfSections;
        roundbackGroundView.backgroundColor = [RotaryWheel getThemeColor:[[arrBodySystems objectAtIndex:selectedSystem] objectForKey:@"score"]];
        [self.delegate wheelDidChangeValue:currentValue];
    }
}

// ------------------------------------------------------------------------------------

/***
 
 This method will used to redraw.
 This method will replace background images for chevrons as per selected system
 
***/

-(void)redrawWheel:(int)selectedNumber{
    int i = 0;
    NSArray *arrWheel = [container subviews];
    
    for (UIView *view in arrWheel){
        NSArray *arrView = view.subviews;
        for(int j=0;j<arrView.count;j++){
            if([[arrView objectAtIndex:j] isKindOfClass:[UIImageView class]] && [[arrView objectAtIndex:j] tag] != 9999){
                UIImageView *imgView = [arrView objectAtIndex:j];
                
                NSString *strThemeColor = [self getThemeColor:[[arrBodySystems objectAtIndex:i] objectForKey:@"score"]];
                
                if([[strThemeColor uppercaseString] isEqualToString:@"RED"]){
                    if(i != selectedNumber){
                        imgView.image = [UIImage imageNamed:@"red_chevron"];
                    }else{
                        imgView.image = [UIImage imageNamed:@"red_chevron"];
                    }
                }else if ([[strThemeColor uppercaseString] isEqualToString:@"GREEN"]){
                    if(i != selectedNumber){
                        imgView.image = [UIImage imageNamed:@"green_chevron"];
                    }else{
                        imgView.image = [UIImage imageNamed:@"green_chevron"];
                    }
                }else{
                    if(i != selectedNumber){
                        imgView.image = [UIImage imageNamed:@"yellow_chevron"];
                    }else{
                        imgView.image = [UIImage imageNamed:@"yellow_chevron"];
                    }
                }
            }
        }
        i++;
    }
}


// ------------------------------------------------------------------------------------

#pragma mark
#pragma mark  Gesture methods

// ------------------------------------------------------------------------------------

/***
 
recognizeCircularViewGesture will be called when user will perfom pan gesture on container view.
This method will check touch position if it is whithin chevrons then it will allow rotation else rotation will not be allowed.
currentValue is the value of selected system after rotation.
 
***/

-(void)recognizeCircularViewGesture : (UIPanGestureRecognizer *) gestureRecognizer{
    if([gestureRecognizer state] == UIGestureRecognizerStateBegan){
        _prevPoint = [gestureRecognizer locationInView:container];
    
        float distance = [self calculateDistanceFromCenter:_prevPoint];
    
        // with below condition we can restrict or avoid any actions which is outside the wheel
        if(distance >= 125.0f && distance <= 170.0f){
        
            // calculate angle for start point
            float dx = _prevPoint.x - container.center.x;
            float dy = _prevPoint.y - container.center.y;
            deltaAngle = atan2(dy,dx);
            startTransform = container.transform;
            self.shouldGestureApply = YES;
        }
    }
    
    if([gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        
        if (self.shouldGestureApply) {
            startTransform = container.transform;
            
            CGPoint currPoint = [gestureRecognizer locationInView:container];
            
            // // calculate angle for end point
            float dx = currPoint.x  - container.center.x;
            float dy = currPoint.y  - container.center.y;
            float ang = atan2(dy,dx);
            
            // find angle difference between angle for start and end point
            float angleDifference = deltaAngle - ang;
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.1];
            
            container.transform = CGAffineTransformRotate(startTransform, -angleDifference);
            [UIView commitAnimations];
            
            CGFloat radians = atan2f(container.transform.b, container.transform.a);
            CGFloat newVal = 0.0;
            for (Chevron *c in chevrons) {
                if (radians > c.minValue && radians < c.maxValue){
                    newVal = radians - c.midValue;
                    currentValue = c.value;
                }
            }
            roundbackGroundView.backgroundColor = [RotaryWheel getThemeColor:[[arrBodySystems objectAtIndex:currentValue] objectForKey:@"score"]];
            [self redrawWheel:currentValue];
            [self.delegate wheelDidChangeValue:currentValue];
            
            _prevPoint = currPoint;
        }
    }
    // UIGestureRecognizerStateEnded will be useful to find point from where user ended with applying gesture
    if([gestureRecognizer state] == UIGestureRecognizerStateEnded){
        if (self.shouldGestureApply) {
            // this will be useful for properly moving wheel, without this circle will not worked with fixed position for chevrons.
            CGFloat radians = atan2f(container.transform.b, container.transform.a);
            CGFloat newVal = 0.0;
            
            for (Chevron *c in chevrons) {
                if (radians > c.minValue && radians < c.maxValue){
                    newVal = radians - c.midValue;
                    currentValue = c.value;
                }
            }
            
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.2];
            CGAffineTransform t = CGAffineTransformRotate(container.transform, -newVal);
            container.transform = t;
            [UIView commitAnimations];
            self.shouldGestureApply = NO;
        }
    }
}

// ------------------------------------------------------------------------------------

/***
 
 recognizeWhiteCircleViewGesture will be called when user will perfom pan gesture on white circle container view.
 currentValue is the value of selected system after rotation.
 
***/

-(void)recognizeWhiteCircleViewGesture : (UIPanGestureRecognizer *) gestureRecognizer{
    if([gestureRecognizer state] == UIGestureRecognizerStateBegan){
        _prevPoint = [gestureRecognizer locationInView:_whiteCircleContainerView];
        float dx = _prevPoint.x - _whiteCircleContainerView.center.x;
        float dy = _prevPoint.y - _whiteCircleContainerView.center.y;
        deltaAngle = atan2(dy,dx);
        startTransform = _whiteCircleContainerView.transform;
        self.shouldGestureApply = YES;
    }
    if([gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        if (self.shouldGestureApply) {
            startTransform = _whiteCircleContainerView.transform;
            CGPoint currPoint = [gestureRecognizer locationInView:_whiteCircleContainerView];
            
            // // calculate angle for end point
            float dx = currPoint.x  - _whiteCircleContainerView.center.x;
            float dy = currPoint.y  - _whiteCircleContainerView.center.y;
            float ang = atan2(dy,dx);
            
            // find angle difference between angle for start and end point
            float angleDifference = deltaAngle - ang;
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            
            _whiteCircleContainerView.transform = CGAffineTransformRotate(startTransform, -angleDifference);
            [UIView commitAnimations];
            _prevPoint = currPoint;
        }
    }
    // UIGestureRecognizerStateEnded will be useful to find point from where user ended with applying gesture
    if([gestureRecognizer state] == UIGestureRecognizerStateEnded){
        if (self.shouldGestureApply) {
            CGFloat radians = atan2f(_whiteCircleContainerView.transform.b, _whiteCircleContainerView.transform.a);
            CGFloat newVal = 0.0;
            
            for (Chevron *c in chevrons) {
                if (radians > c.minValue && radians < c.maxValue){
                    newVal = radians - c.midValue;
                    if(c.value != 0){
                      currentValue = numberOfSections-c.value;
                    }
                    else{
                        currentValue = 0;
                    }
                }
            }
            roundbackGroundView.backgroundColor = [RotaryWheel getThemeColor:[[arrBodySystems objectAtIndex:currentValue] objectForKey:@"score"]];
            [self.delegate wheelDidChangeValue:currentValue];
            
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.2];
            CGAffineTransform t = CGAffineTransformRotate(_whiteCircleContainerView.transform, -newVal);
            _whiteCircleContainerView.transform = t;
            [UIView commitAnimations];
            self.shouldGestureApply = NO;
        }
    }
}

// ------------------------------------------------------------------------------------

/***
 
 recognizeChevronGesture will be called when user will tap on chevrons.
 currentValue is the value of selected system after rotation.
 
***/

-(void)recognizeChevronGesture : (UITapGestureRecognizer*) gestureRecognizer{
    UIView *touchedView = gestureRecognizer.view;
    if(_needToRotateChevron){
        [self transformWheel:_needToRotateChevron andselectedIndex:(int)touchedView.tag andPreviousIndex:currentValue];
       
    }
    else{
        [self transformWheel:_needToRotateChevron andselectedIndex:(int)touchedView.tag andPreviousIndex:0];
        
    }
}

// ------------------------------------------------------------------------------------

#pragma mark
#pragma mark  Unused methods

// ------------------------------------------------------------------------------------

- (void)getGestureDirection:(UIPanGestureRecognizer *)sender{
    typedef NS_ENUM(NSUInteger, UIPanGestureRecognizerDirection) {
        UIPanGestureRecognizerDirectionUndefined,
        UIPanGestureRecognizerDirectionUp,
        UIPanGestureRecognizerDirectionDown,
        UIPanGestureRecognizerDirectionLeft,
        UIPanGestureRecognizerDirectionRight
    };
    
    static UIPanGestureRecognizerDirection direction = UIPanGestureRecognizerDirectionUndefined;
    
    switch (sender.state) {
            
        case UIGestureRecognizerStateBegan: {
            
            if (direction == UIPanGestureRecognizerDirectionUndefined) {
                
                CGPoint velocity = [sender velocityInView:container];
                
                BOOL isVerticalGesture = fabs(velocity.y) > fabs(velocity.x);
                
                if (isVerticalGesture) {
                    if (velocity.y > 0) {
                        direction = UIPanGestureRecognizerDirectionDown;
                    } else {
                        direction = UIPanGestureRecognizerDirectionUp;
                    }
                }
                
                else {
                    if (velocity.x > 0) {
                        direction = UIPanGestureRecognizerDirectionRight;
                    } else {
                        direction = UIPanGestureRecognizerDirectionLeft;
                    }
                }
            }
            
            break;
        }
            
        case UIGestureRecognizerStateChanged: {
            switch (direction) {
                case UIPanGestureRecognizerDirectionUp: {
                    [self handleUpwardsGesture:sender];
                    break;
                }
                case UIPanGestureRecognizerDirectionDown: {
                    [self handleDownwardsGesture:sender];
                    break;
                }
                case UIPanGestureRecognizerDirectionLeft: {
                    [self handleLeftGesture:sender];
                    break;
                }
                case UIPanGestureRecognizerDirectionRight: {
                    [self handleRightGesture:sender];
                    break;
                }
                default: {
                    break;
                }
            }
        }
            
        case UIGestureRecognizerStateEnded: {
            direction = UIPanGestureRecognizerDirectionUndefined;
            break;
        }
            
        default:
            break;
    }
    
}

// ------------------------------------------------------------------------------------

- (void)handleUpwardsGesture:(UIPanGestureRecognizer *)sender{
    NSLog(@"Up");
}

// ------------------------------------------------------------------------------------

- (void)handleDownwardsGesture:(UIPanGestureRecognizer *)sender{
    NSLog(@"Down");
}

// ------------------------------------------------------------------------------------

- (void)handleLeftGesture:(UIPanGestureRecognizer *)sender{
    NSLog(@"Left");
}

// ------------------------------------------------------------------------------------

- (void)handleRightGesture:(UIPanGestureRecognizer *)sender{
    NSLog(@"Right");
}

@end
