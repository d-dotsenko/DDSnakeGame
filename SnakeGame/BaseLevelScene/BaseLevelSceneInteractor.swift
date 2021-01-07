//
//  BaseLevelSceneInteractor.swift
//  SnakeGame
//
//  Created by Dotsenko Dmitriy on 06.01.2021.
//

import UIKit

protocol BaseLevelSceneInteractorProtocol {
	var output: BaseLevelSceneInteractorOutput? { get set }

	func start()
	func lost()
	func stop()
	func changeDirection(way: Way)
}

protocol BaseLevelSceneInteractorOutput: AnyObject {
	func lost()
	func updateSnake(points: [CGPoint], color: UIColor)
	func updateFood(points: [CGPoint], color: UIColor)
	func updateAnabolic(points: [CGPoint], color: UIColor)
}

enum Constants {
	static let lines: Int = 20
	static let anabolicProbabiliry: Int = 3
}

final class BaseLevelSceneInteractor: BaseLevelSceneInteractorProtocol {
	weak var output: BaseLevelSceneInteractorOutput?

	init(startPoints: [CGPoint]) {
		self.startPoints = startPoints

		timer.block = { [weak self] (aTimer) in
			self?.nextStep()
		}
	}

	private var snake = Snake(way: .r)
//	private var food = [Food]()
	private let timer = SnakeTimer(period: 1)
	private let foodHelper = FoodHelper()

// MARK: public

	public var startPoints: [CGPoint]

	public func start() {
		snake = Snake(way: .r)
		snake.points = startPoints
		foodHelper.add(type: .normal)
//		addFood()
		showPosition()
		timer.start()
	}

	public func stop() {
		timer.stop()
		snake.points = []
		foodHelper.clean()
//		food = []
//		timer.updateTimer(acceleration: .normal)
	}

	public func lost() {
		output?.lost()
		timer.stop()
	}

	public func changeDirection(way: Way) {
		if way == snake.way {
			return
		}
		switch way {
		case .l:
			if snake.way == .r {
				return
			}
		case .r:
			if snake.way == .l {
				return
			}
		case .u:
			if snake.way == .d {
				return
			}
		case .d:
			if snake.way == .u {
				return
			}
		default: break
		}

		snake.way = way
	}

	func showPosition() {
		output?.updateSnake(points: snake.points, color: .green)
		output?.updateFood(points: foodHelper.foods.compactMap { $0.position }, color: .purple)
		output?.updateAnabolic(points: foodHelper.anabolics.compactMap { $0.position }, color: .yellow)
	}

	func nextStep() {
		let nextPos = nextPosition()

		if isOutside(position: nextPos) {
			lost()
			return
		} else if isEatHimself(position: nextPos) {
			lost()
			return
		} else if let aFood = foodHelper.isEatFood(position: nextPos) {
			feed(aFood: aFood)
			// eatCount += 1
		} else {
			move()
		}

		showPosition()
	}

	func move() {
		snake.move()
	}

	func feed(aFood: Food) {
		if aFood.type == .anabolic {
			feedAnabolic(aFood: aFood)
		} else {
			feedFood(aFood: aFood)
		}
		tryAddAnabolic()
	}

	func feedFood(aFood: Food) {
		foodHelper.del(aFood: aFood)
		foodHelper.add(type: .normal)
		snake.growUp()
		timer.updateTimer(acceleration: .faster)
	}

	func feedAnabolic(aFood: Food) {
		foodHelper.del(aFood: aFood)
		snake.growUp()
		snake.growUp()
		timer.updateTimer(acceleration: .normal)
	}

	func nextPosition() -> CGPoint {
		let oldX = Int(snake.head.x)
		let oldY = Int(snake.head.y)

		var nextX: Int = oldX
		var nextY: Int = oldY

		switch snake.way {
		case .l:
			nextX = oldX - 1
		case .r:
			nextX = oldX + 1
		case .u:
			nextY = oldY - 1
		case .d:
			nextY = oldY + 1
		default: break
		}

		return CGPoint(x: nextX, y: nextY)
	}

	func isOutside(position: CGPoint) -> Bool {
		if position.x < 0 ||
			position.x > CGFloat(Constants.lines - 1) ||
			position.y < 0 ||
			position.y > CGFloat(Constants.lines - 1) {
			return true
		}
		return false
	}

	func isEatHimself(position: CGPoint) -> Bool {
		var isEat = false
		snake.points.forEach { (aPoint) in
			if aPoint == position {
				isEat = true
			}
		}
		return isEat
	}

	func tryAddAnabolic() {
		let randRange: Range<Int> = 0..<Constants.anabolicProbabiliry
		if Int.random(in: randRange) == 2 {
			foodHelper.add(type: .anabolic)
		}
	}
	
}
