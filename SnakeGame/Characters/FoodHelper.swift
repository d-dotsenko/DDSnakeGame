//
//  FoodHelper.swift
//  SnakeGame
//
//  Created by Dotsenko  on 07.01.2021.
//

import UIKit

class FoodHelper {

	public var foods: [Food] = []
	public var anabolics: [Food] = []

	public func del(aFood: Food) {
		switch aFood.type {
		case .normal:
			if let index = self.foods.firstIndex(of: aFood) {
				foods.remove(at: index)
			}
		case .anabolic:
			if let index = self.anabolics.firstIndex(of: aFood) {
				anabolics.remove(at: index)
			}
		}
	}

	public func add(type: FoodType) {
		let randRange: Range<Int> = 0..<Constants.lines
		let position = CGPoint(x: Int.random(in: randRange), y: Int.random(in: randRange))
		let aFood = Food(type: type, position: position)

		if type == .anabolic {
			anabolics.append(aFood)
		} else {
			foods.append(aFood)
		}
	}

	public func clean() {
		foods = []
		anabolics = []
	}

	public func isEatFood(position: CGPoint) -> Food? {
		if let food = findFood(position: position, theFoods: foods) {
			return food
		}
		if let food = findFood(position: position, theFoods: anabolics) {
			return food
		}
		return nil
	}

// MARK: Private

	private func findFood(position: CGPoint, theFoods: [Food]) -> Food? {
		var food: Food?
		theFoods.forEach { (aFood) in
			if aFood.position == position {
				food = aFood
				return
			}
		}
		return food
	}

}
