//
//  LYToolsKitTests.m
//  LYToolsKitTests
//
//  Created by yyly on 11/13/2018.
//  Copyright (c) 2018 yyly. All rights reserved.
//

@import XCTest;
#import <LYToolsKit/LYToolsKit.h>

@interface Tests : XCTestCase

@end

@implementation Tests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

- (void)testURLappendParams {
    NSString *target1 = nil;
    NSString *url1 = [NSString ly_stringURL:target1 appendParams:@{@"name": @"在自自在在"}];
    XCTAssertNil(url1, @"url1 不是nil");
    NSString *target2 = @"";
    NSString *url2 = [NSString ly_stringURL:target2 appendNotExistParams:@{@"age": @1234}];
    XCTAssertNotNil(url2, @"url2 是nil");
}

- (void)testOperator {
    LYOperatorType type = [UIDevice ly_operatorType];
    XCTAssertEqual(LYOperatorTypeUnKnown, type);
}

- (void)testFileSize {
    NSData *data = UIImagePNGRepresentation([UIImage imageNamed:@"照片"]);
    CGFloat size = [NSString ly_fileSizeMBFromData:data];
    XCTAssertEqual(size, 0);
}
@end

