/**  CycleTracks, Copyright 2009-2013 San Francisco County Transportation Authority
 *                                    San Francisco, CA, USA
 *
 *   @author Matt Paul <mattpaul@mopimp.com>
 *
 *   This file is part of CycleTracks.
 *
 *   CycleTracks is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   CycleTracks is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with CycleTracks.  If not, see <http://www.gnu.org/licenses/>.
 */

//
//  CustomPickerDataSource.m
//  CycleTracks
//
//  Copyright 2009-2013 SFCTA. All rights reserved.
//  Written by Matt Paul <mattpaul@mopimp.com> on 9/22/09.
//	For more information on the project, 
//	e-mail Elizabeth Sall at the SFCTA <elizabeth.sall@sfcta.org>

#import "CustomPickerDataSource.h"
#import "CustomView.h"
#import "TripPurposeDelegate.h"

@implementation CustomPickerDataSource

@synthesize myImageArray,myTitleArray, parent;

- (id)init
{
	// use predetermined frame size
	self = [super init];
	if (self)
	{
		// create the data source for this custom picker
		NSMutableArray *imageArray = [[NSMutableArray alloc] init];
        NSMutableArray *titleArray = [[NSMutableArray alloc] init];

		/*
		 * Commute
		 * School
		 * Work-Related
		 * Exercise
		 * Social
		 * Shopping
		 * Errand
		 * Other
		 */
        
        [titleArray addObject:@"Commute"];
		[imageArray addObject:kTripPurposeCommuteIcon];
       
        
        
        [titleArray addObject:@"School"];
        [imageArray addObject:kTripPurposeSchoolIcon];
   

        
        [titleArray addObject:@"Work-Related"];
        [imageArray addObject:kTripPurposeWorkIcon];
        
        
        [titleArray addObject:@"Exercise"];
        [imageArray addObject:kTripPurposeExerciseIcon];
        
        [titleArray addObject:@"Social"];
        [imageArray addObject:kTripPurposeSocialIcon];
        
        
        [titleArray addObject:@"Shopping"];
        [imageArray addObject:kTripPurposeShoppingIcon];
        

        
        [titleArray addObject:@"Errand"];
        [imageArray addObject:kTripPurposeErrandIcon];
        
        [titleArray addObject:@"Other"];
        [imageArray addObject:kTripPurposeOtherIcon];
        
		self.myImageArray = imageArray;
        self.myTitleArray = titleArray;
		[imageArray release];
        [titleArray release];
	}
	return self;
}

- (void)dealloc
{
	[myImageArray release];
    [myTitleArray release];
	[super dealloc];
}


#pragma mark UIPickerViewDataSource


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
	return [CustomView viewWidth];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
	return [CustomView viewHeight];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [myTitleArray count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}


#pragma mark UIPickerViewDelegate


// tell the picker which view to use for a given component and row, we have an array of views to show
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row
		  forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UITableView *pickerCustomView = [UITableView new];

    UIImageView *myImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[myImageArray objectAtIndex:row]]];
    [pickerCustomView addSubview:myImageView];
    [myImageView release];

    double width = [[myImageView image] size].width;
    NSString * text = [myTitleArray objectAtIndex:row];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(width, 0, 300, 30)];
    label.text=text;
    [pickerCustomView addSubview:label];
    
    return pickerCustomView;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	//NSLog(@"child didSelectRow: %d inComponent:%d", row, component);
	[parent pickerView:pickerView didSelectRow:row inComponent:component];
}



@end
