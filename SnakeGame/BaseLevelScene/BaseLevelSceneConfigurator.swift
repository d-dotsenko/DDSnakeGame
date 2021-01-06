//
//  BaseLevelSceneConfigurator.swift
//  SnakeGame
//
//  Created by Dotsenko Dmitriy on 06.01.2021.
//

import UIKit

final class BaseLevelSceneConfigurator {

	func configuredModule() -> UIViewController & BaseLevelSceneViewControllerProtocol {
		let viewController = BaseLevelSceneViewController()
		let interactor = BaseLevelSceneInteractor()
		let router = BaseLevelSceneRouter()

		router.parentViewController = viewController
		interactor.output = viewController
		viewController.interactor = interactor
		viewController.router = router
		viewController.input = viewController

		return viewController
	}

}
