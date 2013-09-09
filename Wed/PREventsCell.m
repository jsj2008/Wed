//
//  PREventsCell.m
//  Wed
//
//  Created by Rishabh Tayal on 9/9/13.
//  Copyright (c) 2013 Appikon. All rights reserved.
//

#import "PREventsCell.h"

@implementation PREventsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = (PREventsCell*) [[[NSBundle mainBundle] loadNibNamed:@"PREventsCell" owner:self options:nil] objectAtIndex:0];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
