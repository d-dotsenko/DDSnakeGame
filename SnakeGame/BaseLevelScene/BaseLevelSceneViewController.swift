//
//  BaseLevelSceneViewController.swift
//  SnakeGame
//
//  Created by Dotsenko Dmitriy on 06.01.2021.
//

import UIKit

final class BaseLevelSceneViewController: UIViewController, BaseLevelSceneViewControllerProtocol {

	var interactor: BaseLevelSceneInteractorProtocol?

	var router: BaseLevelSceneRouterProtocol?

	weak var input: BaseLevelSceneViewControllerInput?

}

extension BaseLevelSceneViewController: BaseLevelSceneInteractorOutput {

}

extension BaseLevelSceneViewController: BaseLevelSceneViewControllerInput {

}
