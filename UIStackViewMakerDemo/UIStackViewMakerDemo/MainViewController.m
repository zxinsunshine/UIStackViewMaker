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
                @"What's up?",
                @"What are you doing recently? I haven't seen you speak for a long time。。。",
                @"I recently studied the usage of uistackview, summarized some useful schemes, and designed a chain framework 😄😄😄",
                @"really? What's the name of framework?",
                @"UIStackViewMaker",
                @"How can I use this?",
                @"You can retrieve relevant information on GitHub. There is a demo project in it. There are instructions on the home page. The project can be downloaded through pods",
                @"OK, I'll try",
                @"Uh huh. Okay"
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
