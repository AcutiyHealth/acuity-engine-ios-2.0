//
//  RotaryWheel.h
//  AcuityCircle
//
//  Created by Pradip Gami on 11/09/15.
//  Copyright (c) 2015 Pradip Gami. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol RotaryProtocol <NSObject>
- (void) wheelDidChangeValue:(int)newValue;
@end

@interface RotaryWheel : UIControl

@property (weak) id <RotaryProtocol> delegate;
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) NSMutableArray *chevrons;
@property (nonatomic, strong) NSMutableArray *arrBodySystems;
@property (nonatomic, strong) UIImageView *backGroundImageView;
@property (nonatomic, strong) UIView *whiteCircleContainerView;
@property (nonatomic, strong) UIImageView *arrowDownImageView;
@property (nonatomic, strong) UIView *roundbackGroundView;


@property (nonatomic) BOOL shouldGestureApply;
@property int currentValue;
@property int selectedSystem;
@property int numberOfSections;
@property CGPoint touchPoint;
@property CGPoint prevPoint;
@property CGAffineTransform startTransform;
@property (nonatomic) BOOL needToRotateChevron;
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;

- (id) initWithFrame:(CGRect)frame andDelegate:(id)del withSections:(int)noOfSection bodySystems : (NSMutableArray *) arrBody selectedSystem:(int)selSystem needToRotateChevron:(BOOL)needToRotateChevron;
- (void)drawWheel;
- (float) calculateDistanceFromCenter:(CGPoint)point;
- (void) buildChevronsEven;
- (void) buildChevronsOdd;
//- (UIView *) getChevronByValue:(int)value;
- (NSString *) getChevronName:(int)position;

-(void)recognizeChevronGesture : (UITapGestureRecognizer*) gestureRecognizer;
- (void) toggleRotation:(BOOL) needToRotateChevron;
- (void) transformWheel:(BOOL) needToRotateChevron andselectedIndex:(int)selectedIndex andPreviousIndex:(int)previousIndex;

@end
