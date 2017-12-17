//
//  ContactsIndexView.h
//  wechat
//
//  Created by 桑赐相 on 2017/12/17.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ContactsIndexView;
@protocol ContactsIndexViewDelegate<NSObject>
-(void)contactsIndexViewDidSelected:(NSInteger)index;
@end
@interface ContactsIndexView : UIView

@property (nonatomic,weak) id<ContactsIndexViewDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame withNames:(NSArray *)names;



@end
