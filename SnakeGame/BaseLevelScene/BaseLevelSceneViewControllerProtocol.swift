//
//  BaseLevelSceneViewControllerProtocol.swift
//  SnakeGame
//
//  Created by Dotsenko Dmitriy on 06.01.2021.
//

protocol BaseLevelSceneViewControllerProtocol {

	var interactor: BaseLevelSceneInteractorProtocol? { get set }

	var router: BaseLevelSceneRouterProtocol? { get set }

	var input: BaseLevelSceneViewControllerInput? { get set }

}

protocol BaseLevelSceneViewControllerInput: AnyObject {

}
