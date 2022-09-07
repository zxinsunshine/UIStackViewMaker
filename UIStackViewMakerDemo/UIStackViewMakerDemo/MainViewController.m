//
//  MainViewController.m
//  UIStackViewMakerDemo
//
//  Created by Theo on 2022/6/10.
//

#import "MainViewController.h"
#import "STTableViewCell.h"
#import "STMessageModel.h"
@interface MainViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray<STMessageModel *> * messages;
@property (nonatomic, strong) UITableView * listView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Chat";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.listView];
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [self getCellForTableView:tableView indexPath:indexPath];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [self getCellForTableView:tableView indexPath:indexPath];
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:CGSizeMake(tableView.bounds.size.width, 0)];
    return size.height;
}

#pragma mark - Private Methods
- (UITableViewCell *)getCellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath  {
    STTableViewCell * cell = (STTableViewCell *)[self getCellWithStyle:UITableViewCellStyleDefault tableView:tableView selectionStyle:UITableViewCellSelectionStyleNone class:[STTableViewCell class]];
    STMessageModel * model = self.messages[indexPath.row];
    cell.isSender = model.isSender;
    cell.message = model.message;
    return cell;
}

- (UITableViewCell *)getCellWithStyle:(UITableViewCellStyle)style tableView:(UITableView *)tableView selectionStyle:(UITableViewCellSelectionStyle)selectionStyle class:(Class)cls {
    NSString * reuseIdentifier = NSStringFromClass(cls);
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[cls alloc] initWithStyle:style reuseIdentifier:reuseIdentifier];
    }
    cell.selectionStyle = selectionStyle;
    return cell;
}

#pragma mark - Getter
- (UITableView *)listView {
    if (!_listView) {
        _listView = [[UITableView alloc] init];
        _listView.estimatedRowHeight = 0;
        _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listView.dataSource = self;
        _listView.delegate = self;
    }
    return _listView;
}

- (NSMutableArray<STMessageModel *> *)messages {
    if (!_messages) {
        _messages = ({
            NSArray<NSString *> * chatList = @[
                @"Hello?",
                @"在呢",
                @"最近在忙些啥？好久没见你说话了。。。",
                @"我最近在研究UIStackView的用法，总结出了一些有用的方案，设计了一个链式框架😄😄😄",
                @"是么？叫什么名字？",
                @"UIStackViewMaker",
                @"这个怎么用？",
                @"在github上可以检索到相关信息，里面有个Demo工程，主页上有使用说明，工程通过Pods下载即可",
                @"好的，我去试试",
                @"嗯嗯"
            ];
            NSMutableArray * arr = [NSMutableArray array];
            [chatList enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                STMessageModel * model = [STMessageModel new];
                model.isSender = (idx % 2 != 0);
                model.message = obj;
                [arr addObject:model];
            }];
            arr;
        });
    }
    return _messages;
}

@end
