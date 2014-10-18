
#import "VSLayoutExample1.h"

static CGSize const kAvatarSize = {32.f, 32.f};

@interface VSLayoutExample1 ()

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel     *nicknameLabel;
@property (nonatomic, strong) UIView      *timestampIndicator;
@property (nonatomic, strong) UILabel     *timestampLabel;
@property (nonatomic, strong) UIImageView *contentImageView;
@property (nonatomic, strong) UIView      *likeIndicator;
@property (nonatomic, strong) UILabel     *likesLabel;
@property (nonatomic, strong) UIButton    *likeButton;
@property (nonatomic, strong) UIButton    *commentButton;
@property (nonatomic, strong) UIButton    *moreButton;
@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation VSLayoutExample1

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        
        _avatarImageView = [UIImageView newAutoLayoutView];
        _avatarImageView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:.3f];
        _avatarImageView.layer.cornerRadius = kAvatarSize.height / 2.f;
        _avatarImageView.layer.masksToBounds = YES;
        
        _nicknameLabel = [UILabel newAutoLayoutView];
        _nicknameLabel.text = @"iamkeyeelee";
        _nicknameLabel.textColor = [[UIColor blueColor] colorWithAlphaComponent:.3f];
        _nicknameLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
        
        _timestampIndicator = [UIView newAutoLayoutView];
        _timestampIndicator.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:.3f];
        
        _timestampLabel = [UILabel newAutoLayoutView];
        _timestampLabel.text = @"7小时";
        _timestampLabel.textColor = [UIColor lightGrayColor];
        _timestampLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
        
        _contentImageView = [UIImageView newAutoLayoutView];
        _contentImageView.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:.3f];
        
        _likeIndicator = [UIView newAutoLayoutView];
        _likeIndicator.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:.3f];
        
        _likesLabel = [UILabel newAutoLayoutView];
        _likesLabel.text = @"12 次赞";
        _likesLabel.textColor = _nicknameLabel.textColor;
        _likesLabel.font = _nicknameLabel.font;
        
        _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _likeButton.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:.3f];
        _likeButton.translatesAutoresizingMaskIntoConstraints = NO;
        
        _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _commentButton.backgroundColor = [[UIColor cyanColor] colorWithAlphaComponent:.3f];
        _commentButton.translatesAutoresizingMaskIntoConstraints = NO;
        
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreButton.backgroundColor = [[UIColor magentaColor] colorWithAlphaComponent:.3f];
        _moreButton.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self addSubview:_avatarImageView];
        [self addSubview:_nicknameLabel];
        [self addSubview:_timestampIndicator];
        [self addSubview:_timestampLabel];
        [self addSubview:_contentImageView];
        [self addSubview:_likeIndicator];
        [self addSubview:_likesLabel];
        [self addSubview:_likeButton];
        [self addSubview:_commentButton];
        [self addSubview:_moreButton];
    }
    return self;
}


- (void)setupConstraints {
    // 头像左边距离父视图左边 10 点.
    [self.avatarImageView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:10.f];
    
    // 头像顶边距离父视图顶部 10 点.
    [self.avatarImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10.f];
    
    // 设置头像尺寸
    [self.avatarImageView autoSetDimensionsToSize:kAvatarSize];
    
    // 昵称的左边位于头像的右边 10 点的地方.
    [self.nicknameLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.avatarImageView withOffset:10.f];
    
    // 根据昵称的固有内容尺寸设置它的尺寸
    [self.nicknameLabel autoSetDimensionsToSize:[self.nicknameLabel intrinsicContentSize]];
    
    // 时间标识的右边位于时间视图左边 -10 点的地方, 从右往左、从下往上布局时数值都是负的。
    [self.timestampIndicator autoPinEdge:ALEdgeTrailing toEdge:ALEdgeLeading ofView:self.timestampLabel withOffset:-10.f];
    
    // 根据时间标识的固有内容尺寸设置它的尺寸
    [self.timestampIndicator autoSetDimensionsToSize:CGSizeMake(10.f, 10.f)];
    
    // 时间视图的右边距离父视图的右边 10 点.
    [self.timestampLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10.f];
    
    // 根据时间视图的固有内容尺寸设置它的尺寸
    [self.timestampLabel autoSetDimensionsToSize:[self.timestampLabel intrinsicContentSize]];
    
    // 头像、昵称、时间标识、时间视图水平对齐。（意思就是说只需要设置其中一个的垂直约束（y）即可）
    [@[self.avatarImageView, self.nicknameLabel, self.timestampIndicator, self.timestampLabel] autoAlignViewsToAxis:ALAxisHorizontal];
    
    // 内容图片视图顶部距离头像的底部 10 点.
    [self.contentImageView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.avatarImageView withOffset:10.f];
    
    // 内容图片视图左边紧贴父视图左边
    [self.contentImageView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    
    // 内容图片视图的宽度等于父视图的宽度
    [self.contentImageView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self];

    // 内容图片视图的高度等于父视图的宽度
    [self.contentImageView autoMatchDimension:ALDimensionHeight toDimension:ALDimensionWidth ofView:self];
    
    // 赞标识与头像左对齐
    [self.likeIndicator autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.avatarImageView];
    
    // 赞标识的顶部距离内容图片视图底部 10 点.
    [self.likeIndicator autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.contentImageView withOffset:10.f];
    
    // 设置赞标识的尺寸
    [self.likeIndicator autoSetDimensionsToSize:CGSizeMake(10.f, 10.f)];
    
    // 赞数量视图与赞标识水平对齐
    [self.likesLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.likeIndicator];
    
    // 赞数量视图的左边距离赞标识的右边 10 点.
    [self.likesLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.likeIndicator withOffset:10.f];
    
    // 以下请自行脑补...
    [self.likesLabel autoSetDimensionsToSize:[self.likesLabel intrinsicContentSize]];
    
    NSArray *buttons = @[self.likeButton, self.commentButton, self.moreButton];
    [buttons autoMatchViewsDimension:ALDimensionHeight];
    [buttons autoAlignViewsToEdge:ALEdgeBottom];
    [self.likeButton autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.avatarImageView];
    [self.likeButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10.f];
    [self.likeButton autoSetDimensionsToSize:CGSizeMake(50.f, 25.f)];
    
    [self.commentButton autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.likeButton withOffset:5.f];
    [self.commentButton autoSetDimension:ALDimensionWidth toSize:65.f];
    
    [self.moreButton autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10.f];
    [self.moreButton autoSetDimension:ALDimensionWidth toSize:40.f];
    
    self.didSetupConstraints = YES;
}

/**
 *	`updateConstraints` 可能会多次调用, 所以使用一个布尔值防止多次添加约束.
 */
- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        [self setupConstraints];
    }
    [super updateConstraints];
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(320.f, 440.f);
}

@end
