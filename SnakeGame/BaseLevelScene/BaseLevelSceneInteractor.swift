//
//  BaseLevelSceneInteractor.swift
//  SnakeGame
//
//  Created by Dotsenko Dmitriy on 06.01.2021.
//

import UIKit

protocol BaseLevelSceneInteractorProtocol {
	var output: BaseLevelSceneInteractorOutput? { get set }
}

protocol BaseLevelSceneInteractorOutput: AnyObject {

}

enum Constants {
	static let lines: Int = 20
}

final class BaseLevelSceneInteractor: BaseLevelSceneInteractorProtocol {
	weak var output: BaseLevelSceneInteractorOutput?

// MARK: public

	public var startPoints: [CGPoint]?

// MARK: private

	private var snake = Snake(way: .r)
	private var timer: Timer?
	
}
