//
//  ViewController.swift
//  SnakeGame
//
//  Created by Dotsenko Dmitriy on 03.01.2021.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}

	private var baseLevelViewController: UIViewController {
		BaseLevelSceneConfigurator().configuredModule()
	}

	@IBAction func startGame(_ sender: Any) {
		let aViewController = baseLevelViewController
		aViewController.modalPresentationStyle = .fullScreen
		present(aViewController, animated: true, completion: nil)
	}
}

