//
//  BaseLevelSceneConfigurator.swift
//  SnakeGame
//
//  Created by Dotsenko Dmitriy on 06.01.2021.
//

import UIKit

final class BaseLevelSceneConfigurator {

	func configuredModule() -> UIViewController & BaseLevelSceneViewControllerProtocol {

		let snakePoints = [
			CGPoint(x: 10, y: 10),
			CGPoint(x: 11, y: 10),
			CGPoint(x: 12, y: 10),
			CGPoint(x: 13, y: 10),
		]

		let viewController = BaseLevelSceneViewController()
		let interactor = BaseLevelSceneInteractor(startPoints: snakePoints)
		let router = BaseLevelSceneRouter()

		router.parentViewController = viewController
		interactor.output = viewController
		viewController.interactor = interactor
		viewController.router = router
		viewController.input = viewController

		return viewController
	}

}
