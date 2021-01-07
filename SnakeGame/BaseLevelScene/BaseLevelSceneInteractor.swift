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
	func stop()
	func changeDirection(way: Way)
}

protocol BaseLevelSceneInteractorOutput: AnyObject {
	func stop()
	func updateSnake(points: [CGPoint], color: UIColor)
	func updateFood(points: [CGPoint], color: UIColor)
}

enum Constants {
	static let lines: Int = 20
}

final class BaseLevelSceneInteractor: BaseLevelSceneInteractorProtocol {
	weak var output: BaseLevelSceneInteractorOutput?

	init(startPoints: [CGPoint]) {
		self.startPoints = startPoints

		timer.block = { [weak self] (aTimer) in
			self?.nextStep()
		}
	}

// MARK: private

	private var snake = Snake(way: .r)
	private var food = [Food]()
	private let timer = SnakeTimer(period: 1)

// MARK: public

	public var startPoints: [CGPoint]

	public func start() {
		snake.points = startPoints
		addFood()
		showPosition()
		timer.start()
	}

	public func stop() {
		output?.stop()
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
		output?.updateFood(points: food.compactMap { $0.position }, color: .green)
	}

	func nextStep() {
		let nextPos = nextPosition()

		if isOutside(position: nextPos) {
			stop()
			return
		} else if isEatHimself(position: nextPos) {
			stop()
			return
		} else if !isEatFood(position: nextPos) {
			move()
		}

		showPosition()
	}

	func move() {
		snake.move()
	}

	func feed(aFood: Food) {
		delFood(aFood: aFood)
		addFood()
		snake.growUp()
	}

	func addFood() {
		let randRange: Range<Int> = 0..<Constants.lines
		let position = CGPoint(x: Int.random(in: randRange), y: Int.random(in: randRange))
		let aFood = Food(position: position)
		self.food.append(aFood)
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

	func isEatFood(position: CGPoint) -> Bool {
		var isEat = false
		food.forEach { (aFood) in
			if aFood.position == position {
				isEat = true
				feed(aFood: aFood)
//				eatCount += 1
				return
			}
		}
		return isEat
	}

	func delFood(aFood: Food) {
		if let index = self.food.firstIndex(of: aFood) {
			food.remove(at: index)
		}
	}
	
}
