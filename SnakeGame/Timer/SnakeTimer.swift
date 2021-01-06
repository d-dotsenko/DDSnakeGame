//
//  SnakeTimer.swift
//  SnakeGame
//
//  Created by Dotsenko  on 06.01.2021.
//

import Foundation

enum Acceleration {
	case faster
	case slower
	case normal

	func getInterval(currentInterval: TimeInterval) -> TimeInterval {
		switch self {
		case .faster:
			return currentInterval - (currentInterval/3)
		case .slower:
			return currentInterval + (currentInterval/3)
		case .normal:
			return SnakeTimer.period
		@unknown default:
			return currentInterval
		}
	}
}

class SnakeTimer {

	fileprivate static var period: TimeInterval = 1

	init(period: TimeInterval) {
		SnakeTimer.period = period
		_period = period
	}

// MARK: Public

	public var block: ((Timer) -> ())?

	public func start() {
		timer = Timer.scheduledTimer(withTimeInterval: SnakeTimer.period, repeats: true) { (aTimer) in
			if let block = self.block {
				block(aTimer)
			}
		}
	}

	public func stop() {
		timer?.invalidate()
	}

	public func updateTimer(acceleration: Acceleration) {
		timer?.invalidate()

		_period = acceleration.getInterval(currentInterval: _period)

		timer = Timer.scheduledTimer(withTimeInterval: _period, repeats: true) { (aTimer) in
			if let block = self.block {
				block(aTimer)
			}
		}
	}


// MARK: Private

	private var timer: Timer?

	private var _period: TimeInterval = 1

}
