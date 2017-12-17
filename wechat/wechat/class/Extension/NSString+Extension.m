//
//  NSString+Extension.m
//  weibo
//
//  Created by sangcixiang on 17/1/4.
//  Copyright © 2017年 sangcixiang. All rights reserved.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (Extension)
-(CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
-(CGSize)sizeWithFont:(UIFont *)font
{
    return [self sizeWithFont:font maxW:MAXFLOAT];
}

-(NSString *)URLEncodeString{
    NSString *encode = [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"!*'\"();:@&=+$,/?%#[]% "].invertedSet];
    return encode;
}
-(NSString *)URLDecodeString{
    return [self stringByRemovingPercentEncoding];
}

- (BOOL)match:(NSString *)pattern
{
    // 1.创建正则表达式
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    // 2.测试字符串
    NSArray *results = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    return results.count > 0;
}

- (BOOL)isPhoneNumber
{
    // 3.以13\15\18\17开头
    return [self match:@"^1[3578]\\d{9}$"];
}

-(NSString *)dateWithStringFormat:(NSString *)format{
    
    NSInteger inter = [self integerValue];
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:inter];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    return currentDateStr;
}

-(BOOL)checkAccount{
    //6-20位数字和字母组成
    NSString *regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,12}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([pred evaluateWithObject:self]) {
        return YES ;
    }else
        return NO;
}

-(BOOL)checkPassWord{
    //6-20位数字和字母组成
    NSString *regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([pred evaluateWithObject:self]) {
        return YES ;
    }else
        return NO;
}

-(BOOL)checkEmail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    if( [emailTest evaluateWithObject:self]){
        return YES;
    }else{
        return NO;
    }
}
-(NSDate *)stringWithDate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter setTimeZone:timeZone];
    return [formatter dateFromString:self];
}

- (BOOL)checkBankCard{
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[self length];
    int lastNum = [[self substringFromIndex:cardNoLength-1] intValue];
    NSString *cardNo = [self substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}


-(NSString *)md5ForLower16Bate{
    NSString *md5Str = [self md5ForLower32Bate];
    NSString  *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}
-(NSString *)md5ForUpper16Bate{
    NSString *md5Str = [self md5ForUpper32Bate];
    NSString  *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
    return nil;
}
-(NSString *)md5ForLower32Bate{

    const char* input = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    return digest;
}
-(NSString *)md5ForUpper32Bate{
    const char* input = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02X", result[i]];
    }
    return digest;
}

- (NSString *)base64EncodedString {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

- (NSString *)base64DecodedString {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self options:0];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}
@end
