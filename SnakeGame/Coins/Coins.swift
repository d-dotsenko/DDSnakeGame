//
//  Coins.swift
//  SnakeGame
//
//  Created by Dotsenko  on 07.01.2021.
//

enum Prize: Int {
	case normal = 1
	case many = 2
	case max = 3
}

struct Coins {

	private(set) var num: Int = 0

	mutating func add(_ prize: Prize) {
		num += prize.rawValue
	}

	mutating func clean() {
		num = 0
	}

}


