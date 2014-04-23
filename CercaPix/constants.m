
/**
 * Implementation of constants defined and exported in constants.h
 *
 */

#import "constants.h"

/**
 * The default search radius (in meters) from user's location.
 * Used as parameter to instagram api /media/search* method
 */

CGFloat const kDefaultSearchRadius              = 1000; // meters

/**
 * Instagram authentication credentials - client id
 */
NSString* const kInstagramClientId              = @"";

/**
 * Instagram authentication credentials - client secret
 */
NSString* const kInstagramClientSecret          = @"";

/**
 * Instagram api server hostname
 */
NSString* const kInstagramAPIServer             = @"https://api.instagram.com";


// an example endpoint url as per docs
// http://instagram.com/developer/endpoints/media/#
//
// parameters are
// lat - float
// lng - float
// lng - float
// distance float? in km
// access token = string
//
// Example format;
// @"https://api.instagram.com/v1/media/search?lat=48.858844&lng=2.294351&access_token=230662350.f59def8.b8767874e9ca4be2b57b0aec4819306d
//


NSString* const kInstagramMediaSearchEndpoint   = @"/v1/media/search";

/** 
 *  Media access endpoint 
 *  *Note this string is a % encoded format string ****
 *
 *  configuration - NOTE: api uses path_info in addition to query string as parameters
 *
 *  format is: /media/MEDIA-ID?QUERY_STRING
 *
 *  query string parameters are: access_token
 *
 *  In this example media api url, the number '3' is the media id
 *
 *     https://api.instagram.com/v1/media/3?access_token=230662350.f59def8.b8767874e9ca4be2b57b0aec4819306d
 *
 */

NSString* const kInstagramMediaInfoEndpoint     = @"/media/%@";


// Various Tags
NSString* const kErrorTag                       = @"error";




