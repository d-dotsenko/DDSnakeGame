//
//  Snake.swift
//  SnakeGame
//
//  Created by Dotsenko  on 06.01.2021.
//

import UIKit

enum Way {
	case l
	case r
	case u
	case d
	case unknown
}

struct Snake {

	init(way: Way) {
		self.way = way
	}

// MARK: Public

	public var way: Way
	public var head: CGPoint = .zero
	public var tail: CGPoint = .zero

	public var points: [CGPoint] {
		set {
			_points = newValue
			update()
		}
		get {
			return _points
		}
	}

	public mutating func growUp() {
		addToHead()
	}

	public mutating func move() {
		delFromTail()
		addToHead()
	}

// MARK: Private


	private var _points = [CGPoint]()

	private mutating func update() {
		tail = _points.first ?? .zero
		head = _points.last ?? .zero
	}

	private mutating func delFromTail() {
		guard _points.count >= 2 else {
			return
		}
		_points.remove(at: 0)
		tail = _points[0]
	}

	private mutating func addToHead() {
		let newHead = getNewHead()
		_points.append(newHead)
		head = newHead
	}

	private func getNewHead() -> CGPoint {
		let oldX = Int(head.x)
		let oldY = Int(head.y)

		var x = oldX
		var y = oldY

		switch way {
		case .l:
			x = oldX - 1
		case .r:
			x = oldX + 1
		case .u:
			y = oldY - 1
		case .d:
			y = oldY + 1
		default:
			return .zero
		}

		return CGPoint(x: x, y: y)
	}
}

