//
//  MovieDetailTheaterList.m
//  ociney
//
//  Created by florent champigny on 30/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "MovieDetailTheaterList.h"
#import "SalleCell.h"

#define IDENTIFIER_SALLE @"IDENTIFIER_SALLE"

@implementation MovieDetailTheaterList
{
    BOOL first;
}

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        first = YES;
        self.array = [NSMutableArray array];
    }
    return self;
}

- (void)layoutSubviews {
    if(first){
        first = NO;
        
        [self creer];
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self remplir];
}

-(void)creer
{
    [self addSubview:(self.tableView = [UITableView new])];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor blackColor];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)remplir
{
    self.tableView.frame = self.bounds;
}

-(void)loadTheaters:(NSArray *)array
{
    [self.array addObjectsFromArray:array];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.array == nil)
        return 0;
    else
        return self.array.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER_SALLE];
    
    if(cell == nil){
        [tableView registerNib:[UINib nibWithNibName:@"SalleCell" bundle:nil] forCellReuseIdentifier:IDENTIFIER_SALLE];
        cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER_SALLE];
        [cell awakeFromNib];
    }
    
    cell.contentView.frame = CGRectMake(cell.contentView.frame.origin.x,
                                        cell.contentView.frame.origin.y,
                                        self.tableView.frame.size.width,
                                        cell.contentView.frame.size.height);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SALLE_CELL_HEIGHT;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:
(NSIndexPath *)indexPath{
    
    SalleCell *s = (SalleCell*)cell;
    
    Theater * object = nil;
    
    if(indexPath.row < self.array.count)
        object = self.array[indexPath.row];
    
    [s chargerAvecSalle:object];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate didSelectTheater:self.array[indexPath.row]];
}



@end
