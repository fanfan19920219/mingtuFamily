//
//  ZZH_LoadingProject.h
//  KangLeBao
//
//  Created by M-SJ077 on 2016/10/31.
//  Copyright © 2016年 冯宝东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Header.h"
@interface ZZH_LoadingProject : NSObject

+(instancetype)shareMBProgress;

//-(void)MBprogressShowContentString:(NSString*)contentString andDetailString:(NSString*)detailString withView:(UIView*)view;
//
//-(void)MBprogressShowOnlyTextWithCircleViewContentString:(NSString*)contentString andDetailString:(NSString*)detailString withView:(UIView*)view;
//
//-(void)showMBInformation:(NSString*)showString andDelayDismissTime:(CGFloat)time withSuperView:(UIView*)superView;
//
//-(void)HiddenMBprogressWithView:(UIView*)view;

-(void)showAlkerInformation:(NSString*)showString andDelayDismissTime:(CGFloat)time;

-(void)save:(NSString *)saveString forKey:(NSString*)key;

-(void)removeObjectforKey:(NSString*)key;

-(void)removeObjectforFilePath:(NSString*)path;


-(BOOL)save:(NSString*)filePath andSaveObject:(NSObject*)obj;
-(NSObject*)read:(NSString *)filePath;

//对图片进行存取
-(void)saveImage:(UIImage *)image andPath:(NSString*)path;
-(UIImage*)readImage:(NSString*)path;


@end
