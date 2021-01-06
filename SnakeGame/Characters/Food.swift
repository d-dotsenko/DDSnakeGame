//
//  Food.swift
//  SnakeGame
//
//  Created by Dotsenko  on 06.01.2021.
//

import UIKit

struct Food: Equatable {

	let position: CGPoint

	static func == (lhs: Food, rhs: Food) -> Bool {
		return lhs.position == rhs.position
	}

}
