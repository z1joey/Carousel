//
//  ViewController.swift
//  Carousel
//
//  Created by Joey Zhang on 2022/11/16.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private var carouselView: CarouselView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let swiftLogo = UIImageView(image: UIImage(named: "swiftLogo"))
        let blackView = UIView()
        blackView.backgroundColor = .black
        let orangeView = UIView()
        orangeView.backgroundColor = .orange
        let blueView = UIView()
        blueView.backgroundColor = .black

        carouselView.setItems([swiftLogo, blackView, orangeView, blueView])
        carouselView.startAnimating()
    }
}
