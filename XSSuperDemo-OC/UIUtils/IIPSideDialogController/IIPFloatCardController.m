//
//  IIPFloatCardController.m
//  huafangDemo
//
//  Created by Liguoan on 2022/4/15.
//

#import "IIPFloatCardController.h"

@interface IIPFloatCardController ()

@end

@implementation IIPFloatCardController

#pragma mark - Override methods ---- About frame and size

- (void)setupOriginAndFinalFrame {
    
    CGSize viewSize = self.contentViewController.view.frame.size;
    CGFloat x=0, y=0;
    switch (self.direction) {
            
        case EnumIIPSideDialogDirectionNone: {
            
            // Setup origin frame
            x = (CGRectGetWidth(self.view.frame) - viewSize.width) * 0.5f - _floatCardOffset.left + _floatCardOffset.right;
            y = (CGRectGetHeight(self.view.frame) - viewSize.height) * 0.5f;
            self.originFrame = (CGRect){x, y, viewSize};
            
            // Setup final frame
            y = (CGRectGetHeight(self.view.frame) - viewSize.height) * 0.5f - _floatCardOffset.top + _floatCardOffset.bottom;
            self.finalFrame = (CGRect){x, y, viewSize};
            
            // Setup content view controller view frame
            self.contentViewController.view.frame = self.originFrame;
            
        }
            break;
            
        case EnumIIPSideDialogDirectionFromTop: {
            
            // Setup origin frame
            x = (CGRectGetWidth(self.view.frame) - viewSize.width) * 0.5f - _floatCardOffset.left + _floatCardOffset.right;
            y = viewSize.height * -1;
            self.originFrame = (CGRect){x, y, viewSize};
            
            // Setup final frame
            y = (CGRectGetHeight(self.view.frame) - viewSize.height) * 0.5f - _floatCardOffset.top + _floatCardOffset.bottom;
            self.finalFrame = (CGRect){x, y, viewSize};
            
            // Setup content view controller view frame
            self.contentViewController.view.frame = self.originFrame;
        }
            break;

        case EnumIIPSideDialogDirectionFromLeft: {
            
            // Setup origin frame
            x = viewSize.width * -1;
            y = (CGRectGetHeight(self.view.frame) - viewSize.height) * 0.5f - _floatCardOffset.top + _floatCardOffset.bottom;
            self.originFrame = (CGRect){x, y, viewSize};
            
            // Setup final frame
            x = (CGRectGetWidth(self.view.frame) - viewSize.width) * 0.5f - _floatCardOffset.left + _floatCardOffset.right;
            self.finalFrame = (CGRect){x, y, viewSize};
            
            // Setup content view controller view frame
            self.contentViewController.view.frame = self.originFrame;
        }
            break;

        case EnumIIPSideDialogDirectionFromBottom: {
            
            // Setup origin frame
            x = (CGRectGetWidth(self.view.frame) - viewSize.width) * 0.5f - _floatCardOffset.left + _floatCardOffset.right;
            y = CGRectGetHeight(self.view.frame);
            self.originFrame = (CGRect){x, y, viewSize};
            
            // Setup final frame
            y = (CGRectGetHeight(self.view.frame) - viewSize.height) * 0.5f - _floatCardOffset.top + _floatCardOffset.bottom;
            self.finalFrame = (CGRect){x, y, viewSize};
            
            // Setup content view controller view frame
            self.contentViewController.view.frame = self.originFrame;
        }
            break;

        case EnumIIPSideDialogDirectionFromRight: {
            
            // Setup origin frame
            x = CGRectGetWidth(self.view.frame);
            y = (CGRectGetHeight(self.view.frame) - viewSize.height) * 0.5f - _floatCardOffset.top + _floatCardOffset.bottom;
            self.originFrame = (CGRect){x, y, viewSize};
            
            // Setup final frame
            x = (CGRectGetWidth(self.view.frame) - viewSize.width) * 0.5f - _floatCardOffset.left + _floatCardOffset.right;
            self.finalFrame = (CGRect){x, y, viewSize};
            
            // Setup content view controller view frame
            self.contentViewController.view.frame = self.originFrame;
        }
            break;
    }
}

- (void)changeToFinalSize:(CGSize)finalSize {
    
    CGFloat x = (CGRectGetWidth(self.view.frame) - finalSize.width) * 0.5f;
    CGFloat y = (CGRectGetHeight(self.view.frame) - finalSize.height) * 0.5f;
    self.contentViewController.view.frame = (CGRect){x, y, finalSize};
}

@end
