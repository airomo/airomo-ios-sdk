//
//  AIManager.h
//  Airomo-SDK-iOS
//
//  Created by Pavel Shpak on 05/11/13.
//  Copyright 2013 Airomo. All rights reserved.
//

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
 * Filter applications by price, default 'all' when is not used.
 */
@property (nonatomic, assign) AIPrice price;


/**
 * Search keywords separated by comma.
 */
@property (nonatomic, strong) NSString *query;

/**
 * Search URL. It shouldn't be used together with 'query' parameter.
 */
@property (nonatomic, strong) NSString *url;

/**
 * Comma separated meta keywords from target page. Can be used together with url parameter for increase relevant of results.
 */
@property (nonatomic, strong) NSString *metaKeywords;

/**
 * Array of tags used in search
 */
@property (nonatomic, strong) NSMutableArray *tags;

/**
 * Array of categories used in search
 */
@property (nonatomic, strong) NSMutableArray *categories;


/**
 * Search token. It is used for tracking searches.
 */
@property (nonatomic, strong) NSString *searchToken;


/**
 * @name Get the Shared API Instance
 */
+ (id)sharedManager;

/**
 * Perform a setting ClientId and ApiKey for Shared API Instance
 *
 * @param clientId - Unique identifier of client. Obtained via website.
 * @param apiKey - Token for verification of client. Obtained via website.
 */
+ (void)setupWithClientId:(NSString *)clientId apiKey:(NSString *)apiKey;


/**
 * Perform a POST request to Airomo API to obtain available categories. Categories are cached inside framework.
 */
- (void)allCategoriesWithCompletionHandler:(void (^)(id response, NSError *error))completionHandler;


/**
 * Show modal view with search results.
 *
 * @param partnerId - Product identifier. One client can have few products, which should tracks separately
 * @param channelId - Specify filter for analytic
 * @param offset - Offset
 * @param size - Number of results per request
 */
- (void)showApplicationsWithPartnerId:(int)partnerId
                   withChannelId:(int)channelId
//                     withOptions:(NSMutableDictionary*)optionalProperties
                      withOffset:(int)offset
                        withSize: (int)size
                           withCompletionHandler:(void (^)(NSError *error))completionHandler;

/**
 * Hides modal view with search results.
 *
 */
- (void)dismissPopup;

/**
 * Perform a POST request to Airomo API with the given method name and arguments.
 *
 * @param partnerId - Product identifier. One client can have few products, which should tracks separately
 * @param channelId - Specify filter for analytic
 * @param offset - Offset
 * @param size - Number of results per request
 */
- (void)searchApplicationsWithPartnerId:(int)partnerId
                          withChannelId:(int)channelId
//                            withOptions:(NSMutableDictionary*)optionalProperties
                             withOffset:(int)offset
                               withSize: (int)size
                  withCompletionHandler:(void (^)(id response, NSError *error))completionHandler;

/**
 * Perform a POST request to Airomo API to track user clicks.
 *
 * @param partnerId - Product identifier. One client can have few products, which should tracks separately
 * @param channelId - Specify filter for analytic
 * @param AppId - Application id
 * @param searchToken -     Application id
 *
*/
- (void)searchApplicationClickWithPartnerId:(int)partnerId
                 withChannelId:(int)channelId
                    withApp:(NSString*)appId
                    withSearchToken:(NSString*)searchToken
         withCompletionHandler:(void (^)(id response, NSError *error))completionHandler;
@end
