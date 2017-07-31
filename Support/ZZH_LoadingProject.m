//
//  ZZH_LoadingProject.m
//  KangLeBao
//
//  Created by M-SJ077 on 2016/10/31.
//  Copyright © 2016年 冯宝东. All rights reserved.
//

#import "ZZH_LoadingProject.h"
@interface ZZH_LoadingProject()

@property (nonatomic , strong)UIView *superView;
@end
@implementation ZZH_LoadingProject
ZZH_LoadingProject *selfProject;
+(instancetype)shareMBProgress{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        selfProject = [[ZZH_LoadingProject alloc]init];
    });
    return selfProject;
}
//-(void)MBprogressShowContentString:(NSString*)contentString andDetailString:(NSString*)detailString withView:(UIView*)view{
//    MBProgressHUD *HUD;
//    HUD = [MBProgressHUD showHUDAddedTo:view animated:NO] ;
//    //    HUD.delegate = self;
//    self.superView = view;
//    //常用的设置
//    //小矩形的背景色
//    HUD.bezelView.color = MS_COLOR_TEXT(187);//这儿表示无背景
//    //显示的文字
//    //HUD.label.text = @"Test";
//    //细节文字
//    
//    HUD.detailsLabel.text = detailString;
//    
//    HUD.detailsLabel.textColor = MS_COLOR_TEXT(44);
//    //是否有庶罩
//    //customize hud background properties
//    HUD.dimBackground = YES;
//}
//
//-(void)MBprogressShowOnlyTextWithCircleViewContentString:(NSString*)contentString andDetailString:(NSString*)detailString withView:(UIView*)view{
//    MBProgressHUD *HUD;
//    HUD = [MBProgressHUD showHUDAddedTo:view animated:NO] ;
//    //    HUD.delegate = self;
//    self.superView = view;
//    //常用的设置
//    //小矩形的背景色
//    HUD.bezelView.color = MS_COLOR_TEXT(0);//这儿表示无背景
//    HUD.bezelView.alpha = 0.9;
//    HUD.mode = MBProgressHUDModeText;
//    //显示的文字
//    //HUD.label.text = @"Test";
//    //细节文字
//    
//    HUD.detailsLabel.text = detailString;
//    
//    HUD.detailsLabel.textColor = MS_COLOR_TEXT(255);
//    //是否有庶罩
//    //customize hud background properties
//    //HUD.dimBackground = YES;
//}
//-(void)HiddenMBprogressWithView:(UIView*)view{
//    [MBProgressHUD hideHUDForView:self.superView animated:YES];
//}


-(void)showAlkerInformation:(NSString*)showString andDelayDismissTime:(CGFloat)time{
    UIAlertView *alertSuccess = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:showString delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    
    [alertSuccess show];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alertSuccess dismissWithClickedButtonIndex:0 animated:YES];
    });
}

-(BOOL)save:(NSString *)saveString forKey:(NSString*)key{
    [[NSUserDefaults standardUserDefaults]setObject:saveString forKey:key];
    if([[NSUserDefaults standardUserDefaults] synchronize]){
        NSLog(@"保存成功  --- token --- %@",saveString);
    }
    return [[NSUserDefaults standardUserDefaults] synchronize];
}

-(id)getObjectForKey:(NSString*)keyString{
    @try {
        id ReturnBoject = [[NSUserDefaults standardUserDefaults]objectForKey:keyString];
        return ReturnBoject;
    } @catch (NSException *exception) {
    } @finally {
    }
}

-(void)removeObjectforKey:(NSString*)key{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:key];
    if([[NSUserDefaults standardUserDefaults] synchronize]){
        NSLog(@"删除成功");
    }
}

-(void)removeObjectforFilePath:(NSString*)path{
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    
    NSLog(@"saveFilePath --- %@ ---- %@",path,docDir);
    //NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL orSave = [[NSFileManager defaultManager]removeItemAtPath:path error:nil];
    if(orSave){
        NSLog(@"删除成功");
    }
}

-(BOOL)save:(NSString*)filePath andSaveObject:(NSObject*)obj{
    //NSArray *paths = ;
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    
    NSLog(@"saveFilePath --- %@ ---- %@",filePath,docDir);
    //#define PERSONAL_FILE_PATHNAME [NSHomeDirectory() stringByAppendingString:@"/personalcache.plist"]
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSData*data=[NSKeyedArchiver archivedDataWithRootObject:obj];
//    NSError *error;
//    BOOL isDir = YES;
//    if (![fileManager fileExistsAtPath:filePath isDirectory:&isDir]) {
//        
//        [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:NO attributes:nil error:nil];
//        [data writeToFile:filePath options:NSDataWritingAtomic error:&error];
//    }else{
        BOOL orSave = [[NSFileManager defaultManager]createFileAtPath:filePath contents:data attributes:nil];
        if(orSave){
            NSLog(@"保存成功");
        }
    
    return orSave;
//    }
    
    //[NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"%@",filePath]];    
}

-(NSObject*)read:(NSString *)filePath{
    
    if([[NSFileManager defaultManager]fileExistsAtPath:filePath isDirectory:nil]){
        NSLog(@"read");
        NSData *data= [NSData dataWithContentsOfFile:filePath];
        NSObject * obj=[NSKeyedUnarchiver unarchiveObjectWithData:data];
        NSLog(@"obj .... %@",obj);
        return obj;
    }
    return nil;
}

-(void)showMBInformation:(NSString*)showString andDelayDismissTime:(CGFloat)time withSuperView:(UIView*)superView{


}

-(void)saveImage:(UIImage *)image andPath:(NSString*)path{
    NSData *data = UIImagePNGRepresentation(image);
    NSData *saveData = [NSKeyedArchiver archivedDataWithRootObject:data];
    BOOL orSave = [[NSFileManager defaultManager]createFileAtPath:path contents:saveData attributes:nil];
    if(orSave){
        NSLog(@"储存成功");
    }
}
-(UIImage*)readImage:(NSString *)path{
    if([[NSFileManager defaultManager]fileExistsAtPath:path isDirectory:nil]){
        NSLog(@"read");
        NSData *data= [NSData dataWithContentsOfFile:path];
        NSData * obj=[NSKeyedUnarchiver unarchiveObjectWithData:data];
        UIImage *returnImage = [UIImage imageWithData:obj];
        return returnImage;
    }
    return nil;
}

@end
