
#import "VSLabel.h"

@interface VSLabel ()

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation VSLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _textLabel = [UILabel new];
        _textLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
        _textLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _textLabel.backgroundColor = [UIColor blueColor];
        [self addSubview:_textLabel];
        
        _detailLabel = [UILabel new];
        _detailLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        _detailLabel.numberOfLines = 0;
        _detailLabel.textColor = [UIColor whiteColor];
        _detailLabel.backgroundColor = [UIColor orangeColor];
        _detailLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_detailLabel];
    }
    return self;
}

- (void)setupConstraints {
    /**
     *	这里有一个常见问题，如果字典中包含 `self` 这个键，就不能包含其他以 `self.`开头的键，否则 `VFL` 会解析错误。
     */
    NSDictionary *views = NSDictionaryOfVariableBindings(self, _textLabel, _detailLabel);
    NSDictionary *metrics = @{@"fontSize": @(self.textLabel.font.pointSize)};
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_textLabel]-|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_detailLabel]-|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_textLabel(<=fontSize)]-[_detailLabel]-|"
                                                                 options:NSLayoutFormatAlignAllLeading metrics:metrics views:views]];
    self.didSetupConstraints = YES;
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        [self setupConstraints];
    }
    [super updateConstraints];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat preferredMaxLayoutWidth = CGRectGetWidth(self.frame);
    self.textLabel.preferredMaxLayoutWidth = preferredMaxLayoutWidth;
    self.detailLabel.preferredMaxLayoutWidth = preferredMaxLayoutWidth;
}

- (CGSize)intrinsicContentSize {
    CGSize textLabelIntrinsicContentSize = [self.textLabel intrinsicContentSize];
    CGSize detailLabelIntrinsicContentSize = [self.detailLabel intrinsicContentSize];

    CGFloat width = MAX(textLabelIntrinsicContentSize.width, detailLabelIntrinsicContentSize.width);
    CGFloat height = textLabelIntrinsicContentSize.height + detailLabelIntrinsicContentSize.height + CGRectGetMinY(self.textLabel.frame) * 2 + 8.f;
    
    return CGSizeMake(width, height);
}


#pragma mark - Custom Accessors

- (void)setTitle:(NSString *)title {
    if (_title != title) {
        _title = title;
        self.textLabel.text = title;
        [self invalidateIntrinsicContentSize];
    }
}

- (void)setBody:(NSString *)body {
    if (_body != body) {
        _body = body;
        self.detailLabel.text = body;
        [self invalidateIntrinsicContentSize];
    }
}

- (void)setBodyFont:(UIFont *)bodyFont {
    if (_bodyFont != bodyFont) {
        _bodyFont = bodyFont;
        self.detailLabel.font = bodyFont;
        [self invalidateIntrinsicContentSize];
    }
}

@end
