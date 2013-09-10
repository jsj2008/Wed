//
//  PRFamilyCell.m
//  Wed
//
//  Created by Rishabh Tayal on 9/6/13.
//  Copyright (c) 2013 Appikon. All rights reserved.
//

#import "PRFamilyCell.h"

@interface PRFamilyCell()


@end

@implementation PRFamilyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray* nibs = [[NSBundle mainBundle] loadNibNamed:reuseIdentifier owner:self options:nil];
        if (nibs.count > 0 ) {
            self =  (PRFamilyCell*)[nibs objectAtIndex:0];
            return self;
        }
        return nil;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
