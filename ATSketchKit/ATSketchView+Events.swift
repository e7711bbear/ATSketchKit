//
//  ATSketchView+Events.swift
//  ATSketchKit
//
//  Created by Arnaud Thiercelin on 11/26/15.
//  Copyright © 2015 Arnaud Thiercelin. All rights reserved.
//

import Foundation

extension ATSketchView {
	
	public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
		guard touches.count != 0 else {
			NSLog("No touches")
			return
		}
		
		
		if event != nil {
		}

		let touchPoint = touches.first!.locationInView(self)
		
		self.touchDownPoint = touchPoint
		self.lastKnownTouchPoint = touchPoint
		if self.currentAction == .Draw {
			if self.currentTool == .Pencil {
				self.pointsBuffer.append(touchPoint)
				self.setNeedsDisplay()
			}
		}
	}
	
	public override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
		guard touches.count != 0 else {
			NSLog("No touches")
			return
		}
		
		
		if event != nil {
		}
		
		let touchPoint = touches.first!.locationInView(self)
		
		self.touchDownPoint = touchPoint
		self.lastKnownTouchPoint = touchPoint
		if self.currentAction == .Draw {
			if self.currentTool == .Pencil {
				self.pointsBuffer.append(touchPoint)
				self.setNeedsDisplay()
			}
		}
	}
	
	public override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
		if self.currentAction == .Draw {
			if self.currentTool == .Pencil {
				self.pointsLayers.append([CGPoint](self.pointsBuffer))
				self.pointsBuffer.removeAll()
			}
		}
				
	}
	
	public override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
		
	}
	
	/*
	- (void)mouseDown:(NSEvent *)theEvent
	{
	NSPoint clicPoint = [self convertPoint:[theEvent locationInWindow] fromView:nil];
	
	// store this point as last known mouse point.
	self.mouseDownPoint = clicPoint;
	self.lastKnownMousePoint = clicPoint;
	
	if (self.selectedTool == kPLFlowSelectedToolCursor)
	{
	BOOL shiftIsPressed = [theEvent modifierFlags] & NSShiftKeyMask ? YES : NO;
	// do we deselect or add the selection.
	
	// Find layer
	PLFlowLayer *layerAtPoint = [self findFrontLayerAtPoint:clicPoint];
	// If layer
	if (layerAtPoint)
	{
	// Select layer
	
	if (layerAtPoint.isSelectable == NO)
	return;
	
	if (!((PLFlowLayer *)layerAtPoint).isSelected && shiftIsPressed == NO)
	{
	[self deselectAllLayers];
	((PLFlowLayer *)layerAtPoint).isSelected = YES;
	}
	else if (shiftIsPressed)
	((PLFlowLayer *)layerAtPoint).isSelected = !((PLFlowLayer *)layerAtPoint).isSelected;
	[self.topLayer setNeedsDisplay];
	
	// set action to move
	self.currentAction = kPLMouseActionMove;
	
	
	}
	else if (shiftIsPressed)
	{
	self.currentAction = kPLMouseActionRectSelection;
	// Adding rectangle selection additive selection
	}
	// If no layer
	else
	{
	self.currentAction = kPLMouseActionRectSelection;
	[self deselectAllLayers];
	[self.topLayer setNeedsDisplay];
	}
	// return
	}
	else if (self.selectedTool == kPLFlowSelectedToolEntity)
	{
	// Create a new entity
	PLFlowEntityLayer *newEntityLayer = [PLFlowEntityLayer new];
	
	newEntityLayer.position = clicPoint;
	
	[self.layer insertSublayer:newEntityLayer below:self.topLayer];
	
	}
	else if (self.selectedTool == kPLFlowSelectedToolRelation)
	{
	PLFlowEntityLayer *layerAtPoint = [self findFrontLayerAtPoint:clicPoint];
	// If layer
	if (layerAtPoint)
	{
	self.relationFirstEntity = layerAtPoint;
	}
	}
	}
	
	- (void)mouseDragged:(NSEvent *)theEvent
	{
	NSPoint mousePoint = [self convertPoint:[theEvent locationInWindow] fromView:nil];
	
	if (self.currentAction == kPLMouseActionMove)
	{
	for (CALayer *layer in self.layer.sublayers)
	{
	if ([layer isKindOfClass:[PLFlowLayer class]])
	{
	if (((PLFlowLayer *)layer).isSelected)
	{
	CGPoint currentLayerPosition = layer.position;
	CGPoint newPosition = CGPointMake(currentLayerPosition.x - (self.lastKnownMousePoint.x - mousePoint.x), currentLayerPosition.y - (self.lastKnownMousePoint.y - mousePoint.y));
	
	[CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
	layer.position = newPosition;
	[(PLFlowEntityLayer *)layer redesignAllRelations];
	[CATransaction commit];
	[self.topLayer setNeedsDisplay];
	}
	}
	}
	self.lastKnownMousePoint = mousePoint;
	}
	else if (self.currentAction == kPLMouseActionRectSelection)
	{
	self.lastKnownMousePoint = mousePoint;
	CGPoint p1 = self.mouseDownPoint;
	CGPoint p2 = self.lastKnownMousePoint;
	self.topLayer.selectionRect = CGRectMake(MIN(p1.x, p2.x),
	MIN(p1.y, p2.y),
	fabs(p1.x - p2.x),
	fabs(p1.y - p2.y));
	[self.topLayer setNeedsDisplay];
	}
	}
	
	- (void)mouseUp:(NSEvent *)theEvent
	{
	NSPoint mousePoint = [self convertPoint:[theEvent locationInWindow] fromView:nil];
	
	if (self.selectedTool == kPLFlowSelectedToolRelation && self.relationFirstEntity != nil)
	{
	PLFlowEntityLayer *layerAtPoint = (PLFlowEntityLayer *)[self findFrontLayerAtPoint:mousePoint];
	// If layer
	if (layerAtPoint && ![layerAtPoint isEqualTo:self.relationFirstEntity])
	{
	// add new relation.
	PLFlowRelationLayer *newRelation = [PLFlowRelationLayer new];
	
	newRelation.entityA = self.relationFirstEntity;
	newRelation.entityB = layerAtPoint;
	newRelation.flowsAtoB = YES;
	
	[self.relationFirstEntity.relations addObject:newRelation];
	[layerAtPoint.relations addObject:newRelation];
	
	[self.layer insertSublayer:newRelation above:self.topLayer];
	[newRelation redesignRelationLayer];
	}
	}
	else if (self.selectedTool == kPLFlowSelectedToolCursor)
	{
	if (self.currentAction == kPLMouseActionRectSelection)
	{
	[self selectAllItemsWithinRect:self.topLayer.selectionRect];
	}
	}
	// reset
	self.topLayer.selectionRect = CGRectNull;
	[self.topLayer setNeedsDisplay];
	self.relationFirstEntity = nil;
	self.currentAction = kPLMouseActionSelect;
	
	} */
}
