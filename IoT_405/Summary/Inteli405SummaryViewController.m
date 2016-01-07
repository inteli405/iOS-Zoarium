//
//  Inteli405SummaryViewController.m
//  IoT_405
//
//  Created by Zhang Junkai on 16/1/6.
//  Copyright © 2016年 Zhang Junkai. All rights reserved.
//

#import "Inteli405SummaryViewController.h"
#import <AFHTTPSessionManager.h>
#import <AFNetworking.h>

#define MYURLTEMPER @"http://192.168.199.187/statistic/Temperature/lateast"
@interface Inteli405SummaryViewController ()
@property (strong,nonatomic)AFHTTPSessionManager *manager;
@property (strong,nonatomic)UILabel *temperDataLabel;//温度
@property (strong,nonatomic)UILabel *humidityDataLabel;//湿度
@property (strong,nonatomic)UILabel *MQ2DataLabel;//烟雾
@property (strong,nonatomic)UILabel *PressureDataLabel;//气压
@property (strong,nonatomic)UILabel *dangerLable;//危险提示

@property (strong,nonatomic)NSTimer *requestTimerTemper;
@property (strong,nonatomic)NSTimer *requesetTimerDanger;

@property (strong,nonatomic)NSString *temperData;
@property (strong,nonatomic)NSString *humidityData;
@property (strong,nonatomic)NSString *MQ2Data;
@property (strong,nonatomic)NSString *PressureData;

@property (strong,nonatomic)NSArray *LabelArray;
@property (strong,nonatomic)NSArray *paragArray;
@property (strong,nonatomic)NSArray *dataArray;
@property (strong,nonatomic)NSMutableDictionary *dangerDictionary;

@end

@implementation Inteli405SummaryViewController

-(NSTimer *)requestTimerTemper{
    if (_requestTimerTemper == nil) {
        _requestTimerTemper = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(requestRepeatTemper) userInfo:nil repeats:YES];
    }
    return _requestTimerTemper;
}

-(NSTimer *)requesetTimerDanger{
    if (_requesetTimerDanger == nil) {
        _requesetTimerDanger = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(requestDanger) userInfo:nil repeats:YES];
    }
    return  _requesetTimerDanger;
}

-(AFHTTPSessionManager *)manager{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
        return _manager;
    }else{
        return _manager;
    }
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    UIViewController * ins = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    //温度标签
    UILabel *temperLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 100, 100, 30)];
    temperLabel.text = @"温度";
    [self.view addSubview:temperLabel];
    self.temperDataLabel = [[UILabel alloc]initWithFrame:CGRectMake(200, 100, 100, 30)];
    [self.view addSubview:self.temperDataLabel];
    //湿度标签
    UILabel *humidityLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 150, 100, 30)];
    humidityLabel.text = @"湿度";
    [self.view addSubview:humidityLabel];
    self.humidityDataLabel = [[UILabel alloc]initWithFrame:CGRectMake(200, 150, 100, 30)];
    [self.view addSubview:self.humidityDataLabel];
    //烟雾标签
    UILabel *MQ2Label = [[UILabel alloc]initWithFrame:CGRectMake(50, 200, 100, 30)];
    MQ2Label.text = @"烟雾";
    [self.view addSubview:MQ2Label];
    self.MQ2DataLabel = [[UILabel alloc]initWithFrame:CGRectMake(200, 200, 100, 30)];
    [self.view addSubview:self.MQ2DataLabel];
    //气压
    UILabel *pressureLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 250, 100, 30)];
    pressureLabel.text = @"气压";
    [self.view addSubview:pressureLabel];
    self.PressureDataLabel = [[UILabel alloc]initWithFrame:CGRectMake(200, 250, 100, 30)];
    [self.view addSubview:self.PressureDataLabel];
    //危险提示信息
    self.dangerLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 300, 300, 30)];
    self.dangerLable.textColor = [UIColor redColor];
    [self.view addSubview:self.dangerLable];
    //初始化数组
    self.LabelArray = [[NSArray alloc]initWithObjects:self.temperDataLabel,self.humidityDataLabel,self.MQ2DataLabel,self.PressureDataLabel, nil];
    self.paragArray = [[NSArray alloc]initWithObjects:@"Temperature",@"Humidity",@"MQ2",@"Pressure", nil];
    self.dataArray = [[NSArray alloc]initWithObjects:self.temperData,self.humidityData,self.MQ2Data,self.PressureData, nil];
    //初始化字典
    self.dangerDictionary = [[NSMutableDictionary alloc]init];
    [self.dangerDictionary setObject:@"温度过高,当前温度为" forKey:@"temperature_high"];
    [self.dangerDictionary setObject:@"温度过低，当前温度为" forKey:@"temperature_low"];
    [self.dangerDictionary setObject:@"湿度过高，当前湿度为" forKey:@"humidity_high"];
    [self.dangerDictionary setObject:@"湿度过低，当前湿度为" forKey:@"humidity_low"];
    [self.dangerDictionary setObject:@"气压过高，当前气压为" forKey:@"pressure_high"];
    [self.dangerDictionary setObject:@"气压过低，当前气压为" forKey:@"pressure_low"];
    [self.dangerDictionary setObject:@"烟雾浓度过高，当前浓度为" forKey:@"mq2_high"];
    [self.dangerDictionary setObject:@"烟雾浓度过低，当前浓度为" forKey:@"mq2_low"];
    [self.dangerDictionary setObject:@"有书被携带出阅览室：" forKey:@"book_take_out_door"];
    [self.dangerDictionary setObject:@"当前大门未锁" forKey:@"door_exceeding"];
    [self.dangerDictionary setObject:@"当前书门未锁" forKey:@"bookdoor_exceeding"];
    
    return ins;
}

-(void)requestDanger{
    NSString *url = @"http://192.168.199.187/statistic/Alert/lateast";
    [self.manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *temp = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"type"]];
        NSString *dangerInfo = [self.dangerDictionary objectForKey:temp];
        NSString *value = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"value"]];
        if (dangerInfo) {
            self.dangerLable.text = [dangerInfo stringByAppendingString:value];
            [self.dangerLable setNeedsDisplay];
        }else{
            self.dangerLable.text = nil;
            [self.dangerLable setNeedsDisplay];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"danger error");
    }];
}
//后台请求刷新温度等
-(void)requestRepeatTemper{
    static int j = 0;
    NSLog(@"j ======== %i",j);
    j++;
    for (int i=0; i<self.LabelArray.count; i++) {
        NSString *temp = [self.paragArray[i] stringByAppendingString:@"/lateast"];
        NSString *URL =[@"http://192.168.199.187/statistic/" stringByAppendingString:temp];
        [self.manager GET:URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSString *temp = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"value"]];
            UILabel *tempLabel = self.LabelArray[i];
            NSLog(@"%@",temp);
            tempLabel.text = temp;
            [tempLabel setNeedsDisplay];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error");
        }];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    //开启定时器
    [self.requestTimerTemper setFireDate:[NSDate distantPast]];
    [self.requesetTimerDanger setFireDate:[NSDate distantPast]];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    //关闭定时器
    [self.requestTimerTemper setFireDate:[NSDate distantFuture]];
    [self.requesetTimerDanger setFireDate:[NSDate distantFuture]];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"405环境";
    self.view.backgroundColor = [UIColor whiteColor];
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
