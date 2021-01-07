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

	private var snakeViews = [UIView]()
	private var foodViews = [UIView]()

	let gameView = UIView()

	let lGr = UISwipeGestureRecognizer()
	let rGr = UISwipeGestureRecognizer()
	let uGr = UISwipeGestureRecognizer()
	let dGr = UISwipeGestureRecognizer()

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = UIColor.systemGray5

		view.addSubview(gameView)
		gameView.backgroundColor = .black
		gameView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			gameView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			gameView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			gameView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100),
			gameView.heightAnchor.constraint(equalTo: gameView.widthAnchor)
		])

		gameView.addGestureRecognizer(lGr)
		gameView.addGestureRecognizer(rGr)
		gameView.addGestureRecognizer(uGr)
		gameView.addGestureRecognizer(dGr)

		lGr.addTarget(self, action: #selector(swipe))
		rGr.addTarget(self, action: #selector(swipe))
		uGr.addTarget(self, action: #selector(swipe))
		dGr.addTarget(self, action: #selector(swipe))

		lGr.direction = .left
		rGr.direction = .right
		uGr.direction = .up
		dGr.direction = .down

		gameView.setNeedsLayout()
		gameView.layoutIfNeeded()

		interactor?.start()

	}

	@objc func swipe(gesture: UIGestureRecognizer) {
		if let swipeGesture = gesture as? UISwipeGestureRecognizer {
			switch swipeGesture.direction {
			case .right:
				interactor?.changeDirection(way: .r)
			case .down:
				interactor?.changeDirection(way: .d)
			case .left:
				interactor?.changeDirection(way: .l)
			case .up:
				interactor?.changeDirection(way: .u)
			default:
				break
			}
		}
	}

}

extension BaseLevelSceneViewController: BaseLevelSceneInteractorOutput {

// MARK: public

	func stop() {
		snakeViews.forEach { $0.backgroundColor = .red }
	}
	
	func updateSnake(points: [CGPoint], color: UIColor) {
		clearSnakeViews()
		createSnakeViews(points: points, color: color)
		showSnakeViews()
	}

	func updateFood(points: [CGPoint], color: UIColor) {
		clearFoodViews()
		createFoodViews(points: points, color: color)
		showFoodViews()
	}

// MARK: private

	private func clearSnakeViews() {
		snakeViews.forEach { $0.removeFromSuperview() }
		snakeViews = []
	}

	private func clearFoodViews() {
		foodViews.forEach { $0.removeFromSuperview() }
		foodViews = []
	}

	private func createSnakeViews(points: [CGPoint], color: UIColor) {
		let aSnakeViews = createViews(points: points, color: color)
		snakeViews.append(contentsOf: aSnakeViews)
	}

	private func createFoodViews(points: [CGPoint], color: UIColor) {
		let aFoodViews = createViews(points: points, color: color)
		foodViews.append(contentsOf: aFoodViews)
	}

	private func showSnakeViews() {
		snakeViews.forEach { gameView.addSubview($0) }
	}

	private func showFoodViews() {
		foodViews.forEach { gameView.addSubview($0) }
	}

	private func createViews(points: [CGPoint], color: UIColor) -> [UIView] {
		var views = [UIView]()
		let width = gameView.frame.size.width / CGFloat(Constants.lines)

		points.forEach { (point) in
			let aView = UIView(frame: CGRect(x: point.x * width,
											y: point.y * width,
											width: width,
											height: width))
			aView.backgroundColor = color
			views.append(aView)
		}
		return views
	}
	
}

extension BaseLevelSceneViewController: UIAdaptivePresentationControllerDelegate {
	func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
		return false
	}
}

extension BaseLevelSceneViewController: BaseLevelSceneViewControllerInput {

}
