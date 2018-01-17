//
//  TweetsViewController.m
//  wechat
//
//  Created by 桑赐相 on 2017/12/24.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import "TweetsViewController.h"
#import "ImageCollectionViewCell.h"
#define ImageWidth (ScreenWidth - 30 - 15)/4
@interface TweetsViewController ()<YYTextViewDelegate,TZImagePickerControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewConstraint;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
/** 编辑区域 */
@property (weak, nonatomic) IBOutlet UIView *editView;
/** 图片容器 */
@property (weak, nonatomic) IBOutlet UICollectionView *conllectionView;
/** 选择位置 */
@property (weak, nonatomic) IBOutlet UIView *locationView;
/** 所在的位置 */
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
/** 谁可以看 */
@property (weak, nonatomic) IBOutlet UIView *publicView;
/** 谁可以看的人 */
@property (weak, nonatomic) IBOutlet UILabel *publicLabel;
/** 提醒谁看 */
@property (weak, nonatomic) IBOutlet UIView *remindView;
/** 提醒谁看的人 */
@property (weak, nonatomic) IBOutlet UILabel *remindLabel;
/** 图片窗口的高度 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionConstraint;
/** toolbar的位置 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolbarConstraint;
/** 发送按钮 */
@property (nonatomic,strong) UIBarButtonItem *postItem;
/** TextView */
//@property (nonatomic, weak) YYTextView   *edittingArea;
@property (weak, nonatomic) IBOutlet YYTextView *edittingArea;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@property (nonatomic, strong) ImageCollectionViewCell *moveImageCell; //用于记录移动的Cell

@property (nonatomic,strong) NSMutableArray *imagesData;
@property (nonatomic,strong) NSMutableArray *images;

@end

@implementation TweetsViewController
#pragma mark -- Controller 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    [self initSubView];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_edittingArea resignFirstResponder];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
#pragma mark -- 初始化导航栏
-(void)initNavigation{
    
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismissViewController)];
    self.navigationItem.leftBarButtonItem = cancel;
    
    self.postItem = [[UIBarButtonItem alloc]initWithTitle:@"发表" style:UIBarButtonItemStylePlain target:self action:@selector(postAction)];
    self.postItem.enabled = NO;
    self.navigationItem.rightBarButtonItem = self.postItem;

}

#pragma mark -- initSubView

-(void)initSubView{
    
    if (@available(iOS 11.0, *)) {
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.scrollViewConstraint.constant = TopHeight;
    }
//    YYTextView* edittingArea = [[YYTextView alloc] initWithFrame:CGRectMake(8, 8, kScreenSize.width - 16, self.view.width / 3  - 8)];
//    _edittingArea = edittingArea;
    _edittingArea.placeholderFont = [UIFont systemFontOfSize:16];
    _edittingArea.placeholderTextColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
    _edittingArea.autocorrectionType = UITextAutocorrectionTypeDefault;
    _edittingArea.returnKeyType = UIReturnKeySend;
    _edittingArea.enablesReturnKeyAutomatically = YES;
    _edittingArea.scrollEnabled = YES;
    _edittingArea.font = [UIFont systemFontOfSize:16];
    _edittingArea.textColor = [UIColor blackColor];
    _edittingArea.backgroundColor = [UIColor whiteColor];
    _edittingArea.typingAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor],
                                       NSFontAttributeName : [UIFont systemFontOfSize:16]};
    _edittingArea.delegate = self;

    UILongPressGestureRecognizer *longPressGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(moveClick:)];
    longPressGR.delegate = self;
    longPressGR.minimumPressDuration = 0.5;
    [self.conllectionView addGestureRecognizer:longPressGR];
    
    self.conllectionView.collectionViewLayout = [self collectionViewLayout];
    [self.conllectionView registerClass:[ImageCollectionViewCell class] forCellWithReuseIdentifier:@"ImageCollectionViewCell"];
}
#pragma mark - YYTextViewDelegate
-(void)textViewDidChange:(YYTextView *)textView{
    if (self.imagesData.count <= 0 && ![textView hasText]) {
        self.postItem.enabled = NO;
    }else{
        self.postItem.enabled = YES;
    }
    
}

#pragma mark - NSNotification
- (void)keyboardWillShow:(NSNotification *)notification {
    CGRect keyboardBounds = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.toolbarConstraint.constant = keyboardBounds.size.height;
    [self updateBarHeight];
}
- (void)keyboardWillHide:(NSNotification *)notification {
    self.toolbarConstraint.constant = 0;
    [self updateBarHeight];
}
#pragma mark -- 更新布局
- (void)updateBarHeight {
    [self.view setNeedsUpdateConstraints];
    [UIView animateKeyframesWithDuration:0.25 delay:0 options:7 << 16 animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}
-(void)updateConllectionViewHeight{
    int row = (int)(self.images.count + 3) / 4;
    CGFloat height = (ImageWidth * row) + 20 +(row-1) * 5;
    self.collectionConstraint.constant = height;
    [self.conllectionView reloadData];
    [self updateBarHeight];
    if (self.imagesData.count <= 0 && ![self.edittingArea hasText]) {
        self.postItem.enabled = NO;
    }else{
        self.postItem.enabled = YES;
    }
    CGFloat maxY = self.remindView.maxY;
    if (maxY > self.toolbar.y) {
        CGSize size = self.scrollView.contentSize;
        size.height += maxY - self.toolbar.y;
        self.scrollView.contentSize = size;
    }else{
        self.scrollView.contentSize = self.scrollView.size;
    }
    NSLog(@"remindView maxY %@",NSStringFromCGRect(self.scrollView.frame));
}
#pragma mark - 发表
// 发表
-(void)postAction{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",domain,POSTTOPICURL];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"content"] = self.edittingArea.text;
    if (self.imagesData.count > 0) {
        dict[@"type"] = @"1";
        [HTTPTools POST:url parameters:dict imageDatas:self.imagesData success:^(NSDictionary *success) {
            NSLog(@"%@",success);
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }else{
        dict[@"type"] = @"0";
        [HTTPTools POST:url parameters:dict success:^(NSDictionary *success) {
            NSLog(@"%@",success);
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
}



#pragma mark - 选择图片
// 添加图片
- (IBAction)addImageAction:(UIBarButtonItem *)sender {
    [self.edittingArea resignFirstResponder];
    if (self.imagesData.count >= 9) {
        [self openAlertControllerTitle:@"提示" message:@"最多只能添加9张图片" style:UIAlertControllerStyleAlert actionTitle1:@"OK" actionTitle2:nil callback:^(int index) {}];
        return;
    }
    [self openAlertControllerTitle:@"选择图片" message:nil style:UIAlertControllerStyleActionSheet actionTitle1:@"相册" actionTitle2:@"拍照" callback:^(int index) {
        if (index == 1) {
            [self openImagePicker];
        }else if (index == 2){
            [self openCamera];
        }
    }];
}

-(void)openImagePicker{
    
    TZImagePickerController* albumPrickerController = [[TZImagePickerController alloc]initWithMaxImagesCount:9-self.imagesData.count delegate:self];
    albumPrickerController.allowPickingOriginalPhoto = NO;
    albumPrickerController.allowPickingVideo = NO;
    albumPrickerController.navigationBar.barTintColor = navColor;
    [self presentViewController:albumPrickerController animated:YES completion:nil];
}
-(void)openCamera{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self openAlertControllerTitle:@"Error" message:@"Device has no camera" style:UIAlertControllerStyleAlert actionTitle1:@"OK" actionTitle2:nil callback:^(int index) {}];
    }else{
        UIImagePickerController *imagePickerController = [UIImagePickerController new];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.allowsEditing = NO;
        imagePickerController.showsCameraControls = YES;
        imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage];
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
}
#pragma mark TZImagePickerController Delegate

- (void)imagePickerController:(TZImagePickerController *)picker
       didFinishPickingPhotos:(NSArray<UIImage *> *)photos
                 sourceAssets:(NSArray *)assets
        isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto
                        infos:(NSArray<NSDictionary *> *)infos{
    [picker dismissViewControllerAnimated:YES completion:nil];
    if ([self.images.lastObject isKindOfClass:[NSString class]]) {
        [self.images removeLastObject];
    }
    for (UIImage* image in photos) {
        NSData* sourceImageData = UIImageJPEGRepresentation(image, 0.5);
        [self.images addObject:image];
        [self.imagesData addObject:sourceImageData];
    }
    if (self.imagesData.count < 9) {
        if (![self.images.lastObject isKindOfClass:[NSString class]]) {
            [self.images addObject:@"AlbumAddBtn"];
        }
    }
    [self updateConllectionViewHeight];
}

- (void)imagePickerControllerDidCancel:(TZImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - UIImagePickerController 回调函数

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.imagesData addObject:UIImageJPEGRepresentation(image, 0.5)];
    if ([self.images.lastObject isKindOfClass:[NSString class]]) {
        [self.images removeLastObject];
    }
    [self.images addObject:image];
    if (self.imagesData.count < 9) {
        if (![self.images.lastObject isKindOfClass:[NSString class]]) {
            [self.images addObject:@"AlbumAddBtn"];
        }
    }
    [self updateConllectionViewHeight];
}
#pragma mark UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.images.count;
}
- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCollectionViewCell" forIndexPath:indexPath];
    cell.isLast = NO;
    id obj = self.images[indexPath.item];
    if ([obj isKindOfClass:[NSString class]]) {
        cell.image = [UIImage imageNamed:obj];
        cell.isLast = YES;
    }else{
        
        cell.image = self.images[indexPath.item];
    }
    WeakSelf(weakSelf);
    cell.deleteCell = ^(ImageCollectionViewCell *cell){
        cell.image = nil;
        NSIndexPath *index = [collectionView indexPathForCell:cell];
        [weakSelf deleteImageCellWithIndex:index.row];
    };
    return cell;
}
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == _images.count - 1 && [[self.images lastObject] isKindOfClass:[NSString class]]){
        return NO;
    }
    return YES;
}
//删除
-(void)deleteImageCellWithIndex:(NSInteger)index{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.images removeObjectAtIndex:index];
    [self.imagesData removeObjectAtIndex:index];
    [self.conllectionView deleteItemsAtIndexPaths:@[indexPath]];
    //当删除第九张时
    if(_images.count < 9 && ![[self.images lastObject] isKindOfClass:[NSString class]]){
        [_images insertObject:@"AlbumAddBtn" atIndex:_images.count];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_images.count-1 inSection:0];
        [self.conllectionView insertItemsAtIndexPaths:@[indexPath]];
    }
    if (self.images.count == 1) {
        [_images removeAllObjects];
        [self.conllectionView reloadData];
    }
    [self updateConllectionViewHeight];
}


//添加表情
- (IBAction)addEmojiAction:(UIBarButtonItem *)sender {
    
}


#pragma mark -- 移动图片
-(void)moveClick:(UILongPressGestureRecognizer *)longPressGR{
    if (longPressGR.state == UIGestureRecognizerStateBegan) {
        NSIndexPath *indexPath = [self.conllectionView indexPathForItemAtPoint:[longPressGR locationInView:self.conllectionView]];
        if (!(indexPath.row == self.images.count - 1 && ![[self.images lastObject] isKindOfClass:[NSString class]])) {
            self.moveImageCell = (ImageCollectionViewCell *)[_conllectionView cellForItemAtIndexPath:indexPath];
            if (self.moveImageCell) {
                [self.conllectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
                [UIView animateWithDuration:0.3 animations:^{
                    self.moveImageCell.transform = CGAffineTransformMakeScale(1.2, 1.2);
                    self.moveImageCell.alpha = 0.8;
                }];
            }
        }
    }else if (longPressGR.state == UIGestureRecognizerStateChanged){
        CGPoint point = [longPressGR locationInView:self.conllectionView];
        float width = ImageWidth;
        CGPoint postionPoint = CGPointMake(point.x - width * 0.3, point.y - width * 0.3);
        CGRect rectOfCurrent = CGRectMake(postionPoint.x, postionPoint.y, width*0.6, width*0.6);
        UICollectionViewCell *lastCell = [self.conllectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_images.count - 1 inSection:0]];
        CGRect rectOfLast = lastCell.frame;
        if (!(!CGRectIsNull(CGRectIntersection(rectOfCurrent, rectOfLast)) && ![[self.images lastObject] isKindOfClass:[NSString class]])) {
            [self.conllectionView updateInteractiveMovementTargetPosition:[longPressGR locationInView:self.conllectionView]];
        }else if (!CGRectIsNull(CGRectIntersection(rectOfCurrent, rectOfLast)) && ![[self.images lastObject] isKindOfClass:[NSString class]]){
            if (self.moveImageCell) {
                [self.conllectionView endInteractiveMovement];
                [UIView animateWithDuration:0.3 animations:^{
                    self.moveImageCell.transform = CGAffineTransformMakeScale(1, 1);
                    self.moveImageCell.alpha = 1;
                }];
                self.moveImageCell = nil;
            }
        }
        self.moveImageCell.alpha = 0.8;
        self.moveImageCell.transform = CGAffineTransformMakeScale( 1.2, 1.2);
    }else{
        if(self.moveImageCell){
            [self.conllectionView endInteractiveMovement];
            [UIView animateWithDuration:0.3 animations:^{
                self.moveImageCell.transform = CGAffineTransformMakeScale(1, 1);
                self.moveImageCell.alpha = 1;
            }];
            self.moveImageCell = nil;
        }
    }
}
-(UICollectionViewFlowLayout *)collectionViewLayout{
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 2.5;
    layout.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15);
    layout.itemSize = CGSizeMake(ImageWidth, ImageWidth);
    return layout;
};

#pragma mark - lazy

-(NSMutableArray *)images{
    if (!_images) {
        _images = [NSMutableArray array];
    }
    return _images;
}
-(NSMutableArray *)imagesData{
    if (!_imagesData) {
        _imagesData = [NSMutableArray array];
    }
    return _imagesData;
}





@end
