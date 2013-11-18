//
//  AICategory.h
//  Airomo-SDK-iOS
//
//  Created by Pavel Shpak on 11/11/13.
//  Copyright 2013 Airomo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AICategory : NSObject

@property (nonatomic, strong) NSNumber *categoryId;
@property (nonatomic, strong) NSString *categoryTitle;

- (AICategory *)initWithDictionary:(NSDictionary *)dict;
@end
