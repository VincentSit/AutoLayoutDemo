
#import "VSViewController.h"

#import "VSLabel.h"
#import "VSLayoutExample1.h"

@implementation VSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    [self example17];
}

/**
 *	最基础方式进行布局
 */
- (void)example1 {
    UIView *view = [UIView new];
    [view setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:view];
    
    CGRect viewFrame = CGRectMake(50.f, 100.f, 150.f, 150.f);
    
    // 使用 Auto Layout 布局
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // `view` 的左边距离 `self.view` 的左边 50 点.
    NSLayoutConstraint *viewLeft = [NSLayoutConstraint constraintWithItem:view
                                                                attribute:NSLayoutAttributeLeading
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.view
                                                                attribute:NSLayoutAttributeLeading
                                                               multiplier:1
                                                                 constant:CGRectGetMinX(viewFrame)];
    // `view` 的顶部距离 `self.view` 的顶部 100 点.
    NSLayoutConstraint *viewTop = [NSLayoutConstraint constraintWithItem:view
                                                               attribute:NSLayoutAttributeTop
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeTop
                                                              multiplier:1
                                                                constant:CGRectGetMinY(viewFrame)];
    // `view` 的宽度 是 60 点.
    NSLayoutConstraint *viewWidth = [NSLayoutConstraint constraintWithItem:view
                                                                 attribute:NSLayoutAttributeWidth
                                                                 relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                    toItem:nil
                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                multiplier:1
                                                                  constant:CGRectGetWidth(viewFrame)];
    // `view` 的高度是 60 点.
    NSLayoutConstraint *viewHeight = [NSLayoutConstraint constraintWithItem:view
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                 multiplier:1
                                                                   constant:CGRectGetHeight(viewFrame)];
    // 把约束添加到父视图上.
    [self.view addConstraints:@[viewLeft, viewTop, viewWidth, viewHeight]];
}


/**
 *	使用 `VFL` 重构上一个布局
 */
- (void)example2 {
    UIView *view = [UIView new];
    [view setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:view];
    
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(view);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-50-[view(>=150)]" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[view(>=150)]" options:0 metrics:nil views:views]];
}

/**
 *	在右侧添加一个视图
 */
- (void)example3 {
    UIView *view = [UIView new];
    [view setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:view];
    
    UIView *view2 = [UIView new];
    [view2 setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:view2];
    
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [view2 setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(view, view2);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-50-[view(>=150)]" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[view(>=150)]" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[view]-[view2(>=50)]" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[view2(>=50)]" options:0 metrics:nil views:views]];
}

/**
 *	简化 `VFL` 语句
 */
- (void)example4 {
    UIView *view = [UIView new];
    [view setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:view];
    
    UIView *view2 = [UIView new];
    [view2 setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:view2];
    
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [view2 setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(view, view2);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-50-[view(>=150)]-[view2(>=50)]" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[view(>=150)]" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[view2(>=50)]" options:0 metrics:nil views:views]];
}

/**
 *	添加第三个视图
 */
- (void)example5 {
    UIView *view = [UIView new];
    [view setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:view];
    
    UIView *view2 = [UIView new];
    [view2 setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:view2];
    
    UIView *view3 = [UIView new];
    [view3 setBackgroundColor:[UIColor orangeColor]];
    [self.view addSubview:view3];
    
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [view2 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [view3 setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(view, view2, view3);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(50)-[view(>=150)]-[view2(>=50)]" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(100)-[view(>=150)]" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[view]-[view3(>=50)]" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(100)-[view2(>=50)][view3(>=100)]" options:0 metrics:nil views:views]];
}

/**
 *	重构上一个布局代码
 */
- (void)example6 {
    UIView *view = [UIView new];
    [view setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:view];
    
    UIView *view2 = [UIView new];
    [view2 setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:view2];
    
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [view2 setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(view, view2);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-50-[view(>=150)]-[view2(>=50)]" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[view(>=150)]" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[view2(>=50)]" options:0 metrics:nil views:views]];
}

/**
 *	适当地使用 `options` 参数
 */
- (void)example7 {
    UIView *view = [UIView new];
    [view setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:view];
    
    UIView *view2 = [UIView new];
    [view2 setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:view2];
    
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [view2 setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(view, view2);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-50-[view(>=150)]-[view2(>=50)]"
                                                                      options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[view(>=150)]" options:0 metrics:nil views:views]];
}

/**
 *	使用 `metrics` 参数
 */
- (void)example8 {
    UIView *view = [UIView new];
    [view setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:view];
    
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    CGRect viewFrame = CGRectMake(50.f, 100.f, 150.f, 150.f);
    
    NSDictionary *views = NSDictionaryOfVariableBindings(view);
    
    NSDictionary *metrics = @{@"left": @(CGRectGetMinX(viewFrame)),
                              @"top": @(CGRectGetMinY(viewFrame)),
                              @"width": @(CGRectGetWidth(viewFrame)),
                              @"height": @(CGRectGetHeight(viewFrame))};
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-left-[view(>=width)]" options:0 metrics:metrics views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-top-[view(>=height)]" options:0 metrics:metrics views:views]];
}

/**
 *	使用 `metrics` 参数的另一个方式
 */
- (void)example9 {
    UIView *view = [UIView new];
    [view setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:view];
    
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];

    NSNumber *left = @50.f;
    NSNumber *top = @100.f;
    NSNumber *width = @150.f;
    NSNumber *height = @150.f;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(view);
    NSDictionary *metrics = NSDictionaryOfVariableBindings(left, top, width, height);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-left-[view(>=width)]" options:0 metrics:metrics views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-top-[view(>=height)]" options:0 metrics:metrics views:views]];
}

/**
 *	修改约束优先级
 */
- (void)example10 {
    UIView *view = [UIView new];
    [view setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:view];
    
    CGRect viewFrame = CGRectMake(50.f, 100.f, 150.f, 150.f);
    
    // 使用 Auto Layout 布局
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // `view` 的左边距离 `self.view` 的左边 50 点.
    NSLayoutConstraint *viewLeft = [NSLayoutConstraint constraintWithItem:view
                                                                attribute:NSLayoutAttributeLeading
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.view
                                                                attribute:NSLayoutAttributeLeading
                                                               multiplier:1
                                                                 constant:CGRectGetMinX(viewFrame)];
    // `view` 的顶部距离 `self.view` 的顶部 100 点.
    NSLayoutConstraint *viewTop = [NSLayoutConstraint constraintWithItem:view
                                                               attribute:NSLayoutAttributeTop
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeTop
                                                              multiplier:1
                                                                constant:CGRectGetMinY(viewFrame)];
    // `view` 的宽度 是 60 点.
    NSLayoutConstraint *viewWidth = [NSLayoutConstraint constraintWithItem:view
                                                                 attribute:NSLayoutAttributeWidth
                                                                 relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                    toItem:nil
                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                multiplier:1
                                                                  constant:CGRectGetWidth(viewFrame)];
    // `view` 的高度是 60 点.
    NSLayoutConstraint *viewHeight = [NSLayoutConstraint constraintWithItem:view
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                 multiplier:1
                                                                   constant:CGRectGetHeight(viewFrame)];
    // `view` 紧贴着 `self.view` 的左边.
    NSLayoutConstraint *marginLeft = [NSLayoutConstraint constraintWithItem:view
                                                                  attribute:NSLayoutAttributeLeading
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.view
                                                                  attribute:NSLayoutAttributeLeading
                                                                 multiplier:1
                                                                   constant:0];
    viewLeft.priority = UILayoutPriorityDefaultHigh;
    
    // 把约束添加到父视图上.
    [self.view addConstraints:@[viewLeft, viewTop, viewWidth, viewHeight, marginLeft]];
}

/**
 *	布局完成后修改优先级将会得到异常
 */
- (void)example11 {
    UIView *view = [UIView new];
    [view setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:view];
    
    CGRect viewFrame = CGRectMake(50.f, 100.f, 150.f, 150.f);
    
    // 使用 Auto Layout 布局
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // `view` 的左边距离 `self.view` 的左边 50 点.
    NSLayoutConstraint *viewLeft = [NSLayoutConstraint constraintWithItem:view
                                                                attribute:NSLayoutAttributeLeading
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.view
                                                                attribute:NSLayoutAttributeLeading
                                                               multiplier:1
                                                                 constant:CGRectGetMinX(viewFrame)];
    // `view` 的顶部距离 `self.view` 的顶部 100 点.
    NSLayoutConstraint *viewTop = [NSLayoutConstraint constraintWithItem:view
                                                               attribute:NSLayoutAttributeTop
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeTop
                                                              multiplier:1
                                                                constant:CGRectGetMinY(viewFrame)];
    // `view` 的宽度 是 60 点.
    NSLayoutConstraint *viewWidth = [NSLayoutConstraint constraintWithItem:view
                                                                 attribute:NSLayoutAttributeWidth
                                                                 relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                    toItem:nil
                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                multiplier:1
                                                                  constant:CGRectGetWidth(viewFrame)];
    // `view` 的高度是 60 点.
    NSLayoutConstraint *viewHeight = [NSLayoutConstraint constraintWithItem:view
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                 multiplier:1
                                                                   constant:CGRectGetHeight(viewFrame)];
    // `view` 紧贴着 `self.view` 的左边.
    NSLayoutConstraint *marginLeft = [NSLayoutConstraint constraintWithItem:view
                                                                  attribute:NSLayoutAttributeLeading
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.view
                                                                  attribute:NSLayoutAttributeLeading
                                                                 multiplier:1
                                                                   constant:0];
    viewLeft.priority = UILayoutPriorityDefaultHigh;
    
    // 把约束添加到父视图上.
    [self.view addConstraints:@[viewLeft, viewTop, viewWidth, viewHeight, marginLeft]];
    
    // 等待布局完成
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        viewLeft.priority = UILayoutPriorityRequired;
    });
}

/**
 *	固有内容尺寸
 */
- (void)example12 {
    NSString *text = @"Auto Layout is a system that lets you lay out your app’s user interface by creating a mathematical description of the relationships between the elements. You define these relationships in terms of constraints either on individual elements, or between sets of elements. Using Auto Layout, you can create a dynamic and versatile interface that responds appropriately to changes in screen size, device orientation, and localization.";
    
    UILabel *label = [UILabel new];
    label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    label.text = text;
    label.numberOfLines = 0;
    label.preferredMaxLayoutWidth = CGRectGetWidth(self.view.frame);
    [self.view addSubview:label];
    
    [label setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    CGSize size = [label intrinsicContentSize];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(label);
    NSDictionary *metrics = @{@"width": @(size.width), @"height": @(size.height)};
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[label(<=width)]" options:0 metrics:metrics views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[label(>=height)]" options:0 metrics:metrics views:views]];
}

/**
 *	自定义视图的固有内容尺寸
 */
- (void)example13 {
    NSString *title = @"Auto Layout Guide";
    NSString *body = @"Auto Layout is a system that lets you lay out your app’s user interface by creating a mathematical description of the relationships between the elements. You define these relationships in terms of constraints either on individual elements, or between sets of elements. Using Auto Layout, you can create a dynamic and versatile interface that responds appropriately to changes in screen size, device orientation, and localization.";
    
    VSLabel *label = [VSLabel new];
    label.backgroundColor = [UIColor redColor];
    label.title = title;
    label.body = body;
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:label];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(label);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[label]-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[label]-|" options:0 metrics:nil views:views]];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"Intrinsic Content Size :%@", NSStringFromCGSize([label intrinsicContentSize]));
        label.bodyFont = [UIFont systemFontOfSize:16];
        NSLog(@"Intrinsic Content Size :%@", NSStringFromCGSize([label intrinsicContentSize]));
    });
}

/**
 *	内容压缩优先级（Content Hugging Priority）
 */
- (void)example14 {
    NSString *text = @"Auto Layout is a system that lets you lay out your app’s user interface by creating a mathematical description of the relationships between the elements. You define these relationships in terms of constraints either on individual elements, or between sets of elements. Using Auto Layout, you can create a dynamic and versatile interface that responds appropriately to changes in screen size, device orientation, and localization.";
    
    UILabel *label = [UILabel new];
    label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    label.text = text;
    label.numberOfLines = 0;
    label.preferredMaxLayoutWidth = CGRectGetWidth(self.view.frame);
    label.backgroundColor = [UIColor purpleColor];
//    [label setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.view addSubview:label];
    
    [label setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    CGSize size = [label intrinsicContentSize];
    CGFloat delta = 50.f;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(label);
    NSDictionary *metrics = @{@"width": @(size.width), @"height": @(size.height + delta)};
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[label(<=width)]" options:0 metrics:metrics views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[label(>=height@249)]" options:0 metrics:metrics views:views]];
}

/**
 *	内容抗压缩优先级（Content Compression Resistance Priority）
 */
- (void)example15 {
    NSString *text = @"Auto Layout is a system that lets you lay out your app’s user interface by creating a mathematical description of the relationships between the elements. You define these relationships in terms of constraints either on individual elements, or between sets of elements. Using Auto Layout, you can create a dynamic and versatile interface that responds appropriately to changes in screen size, device orientation, and localization.";
    
    UILabel *label = [UILabel new];
    label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    label.text = text;
    label.numberOfLines = 0;
    label.preferredMaxLayoutWidth = CGRectGetWidth(self.view.frame);
    label.backgroundColor = [UIColor purpleColor];
//    [label setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.view addSubview:label];
    
    [label setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    CGSize size = [label intrinsicContentSize];
    CGFloat delta = -50.f;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(label);
    NSDictionary *metrics = @{@"width": @(size.width), @"height": @(size.height + delta)};
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[label(<=width)]" options:0 metrics:metrics views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[label(<=height@749)]" options:0 metrics:metrics views:views]];
}


- (void)example16 {
    UIView *view = [UIView new];
    [view setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:view];
    
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(view);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-50-[view(>=150)]" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[view(<=150)]-|" options:0 metrics:nil views:views]];
}


- (void)example17 {
    VSLayoutExample1 *view = [VSLayoutExample1 newAutoLayoutView];
    [self.view addSubview:view];
    
    [view autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [view autoSetDimension:ALDimensionHeight toSize:[view intrinsicContentSize].height];
}




#pragma mark -

- (BOOL)prefersStatusBarHidden {
    return YES;
}


@end
