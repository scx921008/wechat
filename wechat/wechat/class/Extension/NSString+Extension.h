//
//  NSString+Extension.h
//  weibo
//
//  Created by sangcixiang on 17/1/4.
//  Copyright © 2017年 sangcixiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
/** 计算文字大小  */
-(CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
-(CGSize)sizeWithFont:(UIFont *)font;
/** URLencode  */
-(NSString *)URLEncodeString;
/** URLDecode  */
-(NSString *)URLDecodeString;

/** 账号判断 */
-(BOOL)checkAccount;
/** 手机号判断*/
- (BOOL)isPhoneNumber;
/** 密码验证必需包含字母或字符串 */
-(BOOL)checkPassWord;
/** 验证email */
-(BOOL)checkEmail;
/** 银行卡验证 */
- (BOOL)checkBankCard;
/** 时间鹾转时间 */
-(NSString *)dateWithStringFormat:(NSString *)format;
-(NSDate *)stringWithDate;
/** md5 32位小写 */
-(NSString *)md5ForLower32Bate;
/** md5 32位大写 */
-(NSString *)md5ForUpper32Bate;
/** md5 16位小写 */
-(NSString *)md5ForLower16Bate;
/** md5 16位大写 */
-(NSString *)md5ForUpper16Bate;

/**
 *  转换为Base64编码
 */
- (NSString *)base64EncodedString;
/**
 *  将Base64编码还原
 */
- (NSString *)base64DecodedString;


@end
