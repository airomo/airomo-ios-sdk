//
//  AICategory.h
//  Airomo-SDK-iOS
//
//  Created by Pavel Shpak on 11/11/13.
//  Copyright 2013 Airomo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AICategory : NSObject

@property (nonatomic, assign) NSInteger categoryId;
@property (nonatomic, strong) NSString *name;

- (AICategory *)initWithDictionary:(NSDictionary *)dict;

+ (NSString*)categoryNameById:(NSInteger)catId;
@end
