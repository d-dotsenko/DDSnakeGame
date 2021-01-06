//
//  BaseLevelSceneRouter.swift
//  SnakeGame
//
//  Created by Dotsenko Dmitriy on 06.01.2021.
//

import UIKit

protocol BaseLevelSceneRouterProtocol {
	var parentViewController: UIViewController? { get set }
}

final class BaseLevelSceneRouter: BaseLevelSceneRouterProtocol {
	weak var parentViewController: UIViewController?


}

