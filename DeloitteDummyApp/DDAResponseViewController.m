//
//  DDAResponseViewController.m
//  DeloitteDummyApp
//
//  Created by HUGE | PJ Herring on 4/17/13.
//  Copyright (c) 2013 HUGE | PJ Herring. All rights reserved.
//

#import "DDAResponseViewController.h"

@interface DDAResponseViewController ()

@property (nonatomic, strong) UIButton *paidButton;
@property (nonatomic, strong) UIButton *suspendButton;
@property (nonatomic, strong) UIButton *errorButton;
@property (nonatomic, strong) UIButton *voidButton;

- (void)openUrlWithStatus:(NSString *)status;

@end

@implementation DDAResponseViewController

- (void)viewWillAppear:(BOOL)animated {
	[self.view addSubview:self.paidButton];
	[self.view addSubview:self.suspendButton];
	[self.view addSubview:self.errorButton];
	[self.view addSubview:self.voidButton];
}


- (void)viewDidLayoutSubviews {
	self.paidButton.frame = CGRectMake(10.0f, 10.0f, 100.0f, 30.0f);
	self.suspendButton.frame = CGRectMake(130.0f, 10.0f, 100.0f, 30.0f);
	self.errorButton.frame = CGRectMake(10.0f, 60.0f, 100.0f, 30.0f);
	self.voidButton.frame = CGRectMake(130.0f, 60.0f, 100.0f, 30.0f);
}

#pragma mark - Lazy Loaders


- (UIButton *)paidButton {
	if (!_paidButton) {
		_paidButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[_paidButton addTarget:self action:@selector(tappedButton:) forControlEvents:UIControlEventTouchUpInside];
		[_paidButton setTitle:@"Paid" forState:UIControlStateNormal];
	}
	
	return _paidButton;
}


- (UIButton *)suspendButton {
	if (!_suspendButton) {
		_suspendButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[_suspendButton addTarget:self action:@selector(tappedButton:) forControlEvents:UIControlEventTouchUpInside];
		[_suspendButton setTitle:@"Suspend" forState:UIControlStateNormal];
	}
	
	return _suspendButton;
}


- (UIButton *)errorButton {
	if (!_errorButton) {
		_errorButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[_errorButton addTarget:self action:@selector(tappedButton:) forControlEvents:UIControlEventTouchUpInside];
		[_errorButton setTitle:@"Error" forState:UIControlStateNormal];
	}
	
	return _errorButton;
}


- (UIButton *)voidButton {
	if (!_voidButton) {
		_voidButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[_voidButton addTarget:self action:@selector(tappedButton:) forControlEvents:UIControlEventTouchUpInside];
		[_voidButton setTitle:@"Void" forState:UIControlStateNormal];
	}
	
	return _voidButton;
}

- (void)openUrlWithStatus:(NSString *)status {
	assert(self.request);
	NSDictionary *json;
	NSString *jsonString, *urlString;
	
	json = @{ @"orderId" : [self.request objectForKey:@"orderId"], @"status" : status };
	jsonString = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:json options:0 error:nil] encoding:NSUTF8StringEncoding];
	jsonString = [jsonString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	urlString = [NSString stringWithFormat:@"%@://%@%@?%@", [self.request objectForKey:@"responseUrlScheme"],
				 [self.request objectForKey:@"responseUrlHost"], [self.request objectForKey:@"responseUrlPath"], jsonString];
	assert([[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]]);
}


#pragma mark - Actions

- (void)tappedButton:(UIButton *)button {
	assert(button);
	
	if (button == self.paidButton) {
		[self openUrlWithStatus:@"paid"];
	} else if (button == self.suspendButton) {
		[self openUrlWithStatus:@"suspend"];
	} else if (button == self.errorButton) {
		[self openUrlWithStatus:@"error"];
	} else if (button == self.voidButton) {
		[self openUrlWithStatus:@"void"];
	}
}


@end
