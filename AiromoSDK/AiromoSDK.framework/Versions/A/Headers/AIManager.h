//
//  AIManager.h
//  Airomo-SDK-iOS
//
//  Created by Pavel Shpak on 05/11/13.
//  Copyright 2013 Airomo. All rights reserved.
//

#import "AIReachability.h"

typedef enum {
    AIPlatformIOS          = 1,
    AIPlatformAndroid     = 2
} AIPlatform;

typedef enum {
    AIStoreItunes          = 1,
    AIStoreGooglePlay      = 2,
    AIStoreAmazon          = 3,
    AIStoreNook            = 4
} AIStore;

typedef enum {
    AIPriceFree,
    AIPricePaid
} AIPrice;

/**
 * This object is used to perform API request.
 */
@interface AIManager : NSObject

/**
 * Report the current reachability of the API.
 */
@property (nonatomic, readonly, assign) AINetworkStatus currentReachabilityStatus;

/**
 * Filter applications by platform, default 'all' when is not used.
 */
@property (nonatomic, assign) AIPlatform platform;

/**
 * Filter applications by store, default 'all' when is not used.
 */
@property (nonatomic, assign) AIStore store;

/**
 * Filter applications by price, default 'all' when is not used.
 */
@property (nonatomic, assign) AIPrice price;

/**
 * Search URL.
 */
@property (nonatomic, strong) NSString *url;

/**
 * Comma separated meta keywords from target page. Can be used together with url parameter for increase relevant of results
 */
@property (nonatomic, strong) NSString *metaKeywords;

/**
 * Search keywords separated by comma
 */
@property (nonatomic, strong) NSString *query;

/**
 * List of tags
 */
@property (nonatomic, strong) NSMutableArray *tags;


/**
 * @name Getting the Shared API Instance
 */
+ (id)sharedManager;

/**
 * Perform a setting ClientId and ApiKey for Shared API Instance
 *
 * @param clientId - Unique identifier of client
 * @param apiKey - Token for verification of client
 */
+ (void)setupWithClientId:(NSString *)clientId apiKey:(NSString *)apiKey;


/**
 * Perform a POST request to Airomo API to obtain available categories.
 */
- (void)allCategoriesWithCompletionHandler:(void (^)(id response, NSError *error))completionHandler;

/**
 * Perform a POST request to Airomo API with the given method name and arguments.
 *
 * @param partnerId - Product identifier. One client can have few products, which should tracks separately
 * @param channelId - Specify filter for analytic
 * @param optionalProperties - RESERVED FOR FUTURE: some addition properties with can be usefull for analytic.
 * @param filter - filter parameters
 * @param offset - Offset
 * @param size - Number of results per request
 */
- (void)searchApplicationsWithPartnerId:(int)partnerId
                          withChannelId:(int)channelId
                            withOptions:(NSMutableDictionary*)optionalProperties
                             withOffset:(int)offset
                               withSize: (int)size
                  withCompletionHandler:(void (^)(id response, NSError *error))completionHandler;

/**
 * Perform a POST request to Airomo API to track user clicks.
 *
 * @param partnerId - Product identifier. One client can have few products, which should tracks separately
 * @param channelId - Specify filter for analytic
 * @param optionalProperties - RESERVED FOR FUTURE: some addition properties with can be usefull for analytic.
 * @param AppId - Application id
 * @param AppId - Application id
 *
*/
+ (void)searchApplicationClickWithPartnerId:(int)partnerId
                 withChannelId:(int)channelId
                   withOptions:(NSMutableDictionary*)optionalProperties
                    withApp:(NSString*)appId
                    withSearchToken:(NSString*)searchToken
         withCompletionHandler:(void (^)(id response, NSError *error))completionHandler;
@end
