
#import "RNOocr.h"
#import <Foundation/Foundation.h>
#import "RCTLog.h"
#import <AipOcrSdk/AipOcrSdk.h>

@implementation RNOocr

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(test)
{
    RCTLogInfo(@"test");
}
RCT_EXPORT_METHOD(auth)
{
    RCTLogInfo(@"auth");
    NSString *licenseFile = [[NSBundle mainBundle] pathForResource:@"aip" ofType:@"license"];
    NSData *licenseFileData = [NSData dataWithContentsOfFile:licenseFile];
    [[AipOcrService shardService] authWithLicenseFileData:licenseFileData];
}

RCT_EXPORT_METHOD(detectIdCardFrontFromImage: (NSString *)image
                  successResolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    RCTLogInfo(@"testingdddd, %@",image);
    NSData *data = [[NSData alloc]initWithBase64EncodedString:image options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *finalImage = [UIImage imageWithData:data];
    RCTLogInfo(@"done. ");
    //  [[AipOcrService shardService] authWithToken:@"24.a854dbd5d0e36c523523ecbf6519b3f9.2592000.1500518501.282335-9785895"];
    [[AipOcrService shardService] detectIdCardFrontFromImage:finalImage withOptions:nil successHandler:^(id result) {
        // 成功
        RCTLogInfo(@"result... %@",result);
        resolve(result);
    } failHandler:^(NSError *err) {
        // 失败
        RCTLogInfo(@"detect error errrrr %@", err);
        reject(@"detect error", @"errrrr", err);
    }];
    
}


@end
  
