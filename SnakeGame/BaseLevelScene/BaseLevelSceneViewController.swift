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
	private var anabolicsViews = [UIView]()

	let gameView = UIView()
	let restartButton = UIButton()

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
			gameView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20),
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

		setupRestartButton()

		interactor?.start()

	}

	func setupRestartButton() {
		view.addSubview(restartButton)
		restartButton.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			restartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			restartButton.topAnchor.constraint(equalTo: gameView.bottomAnchor, constant: 40),
			restartButton.widthAnchor.constraint(equalToConstant: 100),
			restartButton.heightAnchor.constraint(equalToConstant: 40)
		])
		restartButton.backgroundColor = .clear
		restartButton.setTitle("Restart", for: .normal)
		restartButton.setTitleColor(.black, for: .normal)
		restartButton.addTarget(self, action: #selector(restartDidTap), for: .touchUpInside)
	}

	@objc func restartDidTap() {
		interactor?.stop()

		snakeViews.forEach { $0.removeFromSuperview() }
		snakeViews = []
		foodViews.forEach { $0.removeFromSuperview() }
		foodViews = []
		anabolicsViews.forEach { $0.removeFromSuperview() }
		anabolicsViews = []
		
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

extension BaseLevelSceneViewController: BaseLevelSceneInteractorOutput {

// MARK: public

	func lost() {
		snakeViews.forEach { $0.backgroundColor = .red }
	}
	
	func updateSnake(points: [CGPoint], color: UIColor) {
		snakeViews.forEach { $0.removeFromSuperview() }
		snakeViews = []
		snakeViews.append(contentsOf: createViews(points: points, color: color))
		snakeViews.forEach { gameView.addSubview($0) }
	}

	func updateFood(points: [CGPoint], color: UIColor) {
		foodViews.forEach { $0.removeFromSuperview() }
		foodViews = []
		foodViews.append(contentsOf: createViews(points: points, color: color))
		foodViews.forEach { gameView.addSubview($0) }
	}

	func updateAnabolic(points: [CGPoint], color: UIColor) {
		anabolicsViews.forEach { $0.removeFromSuperview() }
		anabolicsViews = []
		anabolicsViews.append(contentsOf: createViews(points: points, color: color))
		anabolicsViews.forEach { gameView.addSubview($0) }
	}
	
}

extension BaseLevelSceneViewController: BaseLevelSceneViewControllerInput {

}
