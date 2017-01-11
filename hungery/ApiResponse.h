//
//  ApiResponse.h
//luhui
//


//

#import <Foundation/Foundation.h>

#define API_STATUS_NETWORK      -1
#define API_STATUS_JSON         @"-2"
#define API_STATUS_SUCCESS      @"1"
#define API_STATUS_UNAUTHORIZED 401
#define API_STATUS_PARAMERROR   402
#define API_STATUS_NONETWORK    101
#define API_STATUS_PAYEND       405

@interface ApiResponse : NSObject

@property (nonatomic, strong) NSString*status;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) id data;
@property (nonatomic, strong) NSString *errorcode;
- (void)parse:(NSData *)data withReturnClassName:(NSString *)className;

@end

@protocol ApiResponseDelegate

- (BOOL)apiWillFinishLoading:(ApiResponse *)response withTag:(NSObject *)tag;
- (void)apiDidFinishLoading:(ApiResponse *)response withTag:(NSObject *)tag;

@end