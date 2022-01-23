//
//  ViewController.swift
//  Password Selection
//
//  Created by Kirill on 23.01.2022.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var generatePasswordButton: UIButton!
    @IBOutlet weak var guessThePasswordButton: UIButton!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var textField: UITextField!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    // MARK: - Settings
    
    private func setupLayout() {
        generatePasswordButton.layer.cornerRadius = Metric.cornerRadius
        generatePasswordButton.layer.shadowOpacity = Metric.shadowOpacity
        generatePasswordButton.layer.shadowColor = CGColor(red: Metric.indexColor, green: Metric.indexColor, blue: Metric.indexColor, alpha: Metric.alpha)
        generatePasswordButton.layer.shadowOffset = CGSize(width: Metric.widthShadow, height: Metric.heightShadow)
        
        guessThePasswordButton.layer.cornerRadius = Metric.cornerRadius
        guessThePasswordButton.layer.shadowOpacity = Metric.shadowOpacity
        guessThePasswordButton.layer.shadowColor = CGColor(red: Metric.indexColor, green: Metric.indexColor, blue: Metric.indexColor, alpha: Metric.alpha)
        guessThePasswordButton.layer.shadowOffset = CGSize(width: Metric.widthShadow, height: Metric.heightShadow)
    }
}

// MARK: - Constants

extension ViewController {
    enum Metric {
        static let cornerRadius: CGFloat = 5
        static let shadowOpacity: Float = 1
        static let widthShadow: CGFloat = 5
        static let heightShadow: CGFloat = 5
        static let alpha: CGFloat = 1
        static let indexColor: CGFloat = 33 / 100
    }
}
