//
//  AIManager.h
//  AiromoSDK
//
//  Copyright 2013 Airomo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    AIPlatformIOS          = 1,
    AIPlatformAndroid      = 2
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

typedef enum {
    AIPhoneListTypeList    = 1,
    AIPhoneListTypeTile    = 2
} AIPhoneListType;

/**
 * Main interface for working with the Airomo API.
 * It provides methods to search applications by phrase/word, meta keywords, url and tags.
 * Search results are can be shown as modal view or returned as JSON.
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
 * Type of application list (list or tiles)
 */
@property (nonatomic, assign) AIPhoneListType phoneListType;

/**
 * Search token. It is used for tracking searches.
 */
@property (nonatomic, strong) NSString *searchToken;

/**
 * Number of search results per request.
 */
@property (nonatomic, assign) NSInteger pageSize;

/**
 * Number of sponsored applications per request.
 */
@property (nonatomic, assign) NSInteger adSize;

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
+ (void)setupWithClientId:(NSString *)clientId
                   apiKey:(NSString *)apiKey;

/**
 * Show modal view with search results.
 *
 * @param viewController - view controller which will show search result modally, if nil - window subview will be added
 * @param partnerId - Product identifier. One client can have few products, which should tracks separately
 * @param channelId - Specify filter for analytic
 * @param offset - Offset
 * @param size - Number of results per request
 * @param completionHandler The block called when search is done. Use to get error from API.
 */
- (void)presentFromViewController:(UIViewController *)viewController
                    withPartnerId:(NSInteger)partnerId
                    withChannelId:(NSInteger)channelId
                       withOffset:(NSInteger)offset
                         withSize: (NSInteger)size
                            withAdSize: (NSInteger)adSize
                     withAdOffset:(NSInteger)adOffset
            withCompletionHandler:(void (^)(NSError *error))completionHandler;

/**
 * Hide modal view with search results.
 *
 */
- (void)dismissPopup;

/**
 * Perform a POST request to Airomo API with the given method name and arguments. Method returns JSON.
 *
 * @param partnerId - Product identifier. One client can have few products, which should tracks separately
 * @param channelId - Specify filter for analytic
 * @param offset - Offset
 * @param size - Number of results per request
 * @param completionHandler The block called when search is done.
 */
- (void)searchApplicationsWithPartnerId:(NSInteger)partnerId
                          withChannelId:(NSInteger)channelId
                             withOffset:(NSInteger)offset
                               withSize: (NSInteger)size
                             withAdSize: (NSInteger)adSize
                           withAdOffset:(NSInteger)adOffset
         withCompletionHandler:(void (^)(id response, NSError *error))completionHandler;

/**
 * Perform a POST request to Airomo API to obtain available categories. Categories are cached inside framework.
 */
- (void)allCategoriesWithCompletionHandler:(void (^)(id response, NSError *error))completionHandler;

@end
