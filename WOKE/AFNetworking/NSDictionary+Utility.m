//
//  NSDictionary+Utility.m
//  VoxWaves
//
//  Created by Ramesh Ponnuvel on 01/10/14.
//  Copyright (c) 2014 Mangasaur Games. All rights reserved.
//

#import "NSDictionary+Utility.h"

@implementation NSDictionary (Utility)

- (id)objectForKeyNotNull:(id)key {
    id object = [self objectForKey:key];
    if (object == [NSNull null])
        return nil;
    
    return object;
}

@end
