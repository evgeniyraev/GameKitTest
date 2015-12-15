//
//  ViewController.swift
//  GridTest
//
//  Created by Evgeniy Raev on 12/15/15.
//  Copyright © 2015 Evgeniy Raev. All rights reserved.
//

import UIKit
import GameKit

class Point: GKGraphNode2D
{
	var id:Int
	
	init(id:Int, point:vector_float2)
	{
		self.id = id
		super.init(point: point)
	}
}

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		let coordinatesSource = [
			(365,269),
			(549, 490),
			(295, 647),
			(549, 866),
			(1007, 763),
			(1339, 490),
			(972, 269),
			(1440, 269),
			(1729, 560),
			(1622, 796),
			(1440, 989),
			(800, 1178),
			(260, 1143),
			(1233, 1278)
		]
		
		let connectonsSource:[(Int,Int)] = [
			(0,1),
			(1,2),
			(1,6),
			(1,4),
			(3,2),
			(3,11),
			(4,3),
			(4,5),
			(5,7),
			(5,8),
			(6,5),
			(9,5),
			(10,4),
			(11,13),
			(12,3)
		]
		
		var points = [Point]()
		var pMap = [Int:Point]()
		
		var counter = 0
		for (x, y) in coordinatesSource
		{
			let p = Point(id: counter++, point: vector_float2(x:Float(x), y:Float(y)))
			points.append(p)
			pMap[p.id] = p
		}
		
		var connections = [Int:[Point]]()
		for (leftId, rightId) in connectonsSource
		{
			if connections[leftId] == nil
			{
				connections[leftId] = [Point]()
			}
			
			if let rPoint = pMap[rightId]
			{
				print(rightId)
				connections[leftId]!.append(rPoint)
			}
		}
		
		for (leftId, con) in connections
		{
			if let leftPoint = pMap[leftId]
			{
				print(leftId)
				leftPoint.addConnectionsToNodes(con, bidirectional: true)
			}
		}
		
		let n1 = pMap[3]!
		let n2 = pMap[6]!
		
		let graph = GKGraph(nodes: points)
		//the problem is here 
		print(graph.findPathFromNode(n1, toNode: n2))
		//alternative crash
		//n1.estimatedCostToNode(n2)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

