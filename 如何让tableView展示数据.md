## 如何让tableView展示数据
- 设置数据源对象

```objc
self.tableView.dataSource = self;
```

- 数据源对象要遵守协议

```objc
@interface ViewController () <UITableViewDataSource>

@end
```

- 实现数据源方法

```objc
// 多少组数据
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;

// 每一组有多少行数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

// 每一行显示什么内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

// 每一组的头部
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;

// 每一组的尾部
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
```

## tableView的常见设置
```objc
// 设置每一行cell的高度
self.tableView.rowHeight = 100;

// 设置每一组头部的高度
self.tableView.sectionHeaderHeight = 50;

// 设置每一组尾部的高度
self.tableView.sectionFooterHeight = 50;

// 设置分割线颜色
self.tableView.separatorColor = [UIColor redColor];
// 设置分割线样式
self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
// 设置表头控件
self.tableView.tableHeaderView = [[UISwitch alloc] init];
// 设置表尾控件
self.tableView.tableFooterView = [UIButton buttonWithType:UIButtonTypeContactAdd];

// 设置右边索引文字的颜色
self.tableView.sectionIndexColor = [UIColor redColor];
// 设置右边索引文字的背景色
self.tableView.sectionIndexBackgroundColor = [UIColor blackColor];
```

## tableViewCell的常见设置
```objc
// 设置右边的指示样式
cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

// 设置右边的指示控件
cell.accessoryView = [[UISwitch alloc] init];

// 设置cell的选中样式
cell.selectionStyle = UITableViewCellSelectionStyleNone;
// backgroundView优先级 > backgroundColor

// 设置背景色
cell.backgroundColor = [UIColor redColor];

// 设置背景view
UIView *bg = [[UIView alloc] init];
bg.backgroundColor = [UIColor blueColor];
cell.backgroundView = bg;

// 设置选中的背景view
UIView *selectedBg = [[UIView alloc] init];
selectedBg.backgroundColor = [UIColor purpleColor];
cell.selectedBackgroundView = selectedBg;
```

## cell的循环利用
- 传统的写法

```objc
/**
 *  每当有一个cell要进入视野范围内，就会调用一次
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"wine";

    // 1.先去缓存池中查找可循环利用的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

    // 2.如果缓存池中没有可循环利用的cell
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }

    // 3.设置数据
    cell.textLabel.text = [NSString stringWithFormat:@"%zd行的数据", indexPath.row];

    return cell;
}
```

- 新的写法（注册cell）

```objc
NSString *ID = @"wine";

- (void)viewDidLoad {
    [super viewDidLoad];

    // 注册某个重用标识 对应的 Cell类型
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.先去缓存池中查找可循环利用的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

    // 2.设置数据
    cell.textLabel.text = [NSString stringWithFormat:@"%zd行的数据", indexPath.row];

    return cell;
}
```
