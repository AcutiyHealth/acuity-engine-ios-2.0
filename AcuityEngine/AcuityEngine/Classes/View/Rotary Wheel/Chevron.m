//
//  Chevron.m
//  AcuityCircle
//
//  Created by Pradip Gami on 11/09/15.
//  Copyright (c) 2015 Pradip Gami. All rights reserved.
//


#import "Chevron.h"

@implementation Chevron

@synthesize minValue, maxValue, midValue, value;

- (NSString *) description {
    return [NSString stringWithFormat:@"%i | %f, %f, %f", self.value, self.minValue, self.midValue, self.maxValue];
}

@end
