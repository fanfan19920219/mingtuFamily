//
//  EditPersonalViewController.m
//  MingTu
//
//  Created by zhangzhihua on 2017/7/31.
//  Copyright © 2017年 zhangzhihua. All rights reserved.
//

#import "EditPersonalViewController.h"
#import "Header.h"



@interface EditPersonalViewController ()
@property (strong, nonatomic) IBOutlet UITextField *nicnName;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation EditPersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *nickName = [[ZZH_LoadingProject shareMBProgress]getObjectForKey:NICKNAMEKEY];
    if(nickName){
        self.nicnName.text = nickName;
    }
    
    
}
- (IBAction)saveMethod:(UIButton *)sender {
    if([[ZZH_LoadingProject shareMBProgress]save:self.nicnName.text forKey:NICKNAMEKEY]){
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
