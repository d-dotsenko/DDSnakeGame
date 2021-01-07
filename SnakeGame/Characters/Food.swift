//
//  Food.swift
//  SnakeGame
//
//  Created by Dotsenko  on 06.01.2021.
//

import UIKit

enum FoodType {
	case normal
	case anabolic
}

struct Food: Equatable {

	let type: FoodType
	let position: CGPoint

	static func == (lhs: Food, rhs: Food) -> Bool {
		return (lhs.position == rhs.position) && (lhs.type == rhs.type)
	}

}
