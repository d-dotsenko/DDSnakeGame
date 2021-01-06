//
//  BaseLevelSceneInteractor.swift
//  SnakeGame
//
//  Created by Dotsenko Dmitriy on 06.01.2021.
//

import Foundation

protocol BaseLevelSceneInteractorProtocol {
	var output: BaseLevelSceneInteractorOutput? { get set }
}

protocol BaseLevelSceneInteractorOutput: AnyObject {

}

final class BaseLevelSceneInteractor: BaseLevelSceneInteractorProtocol {
	weak var output: BaseLevelSceneInteractorOutput?

	
}
