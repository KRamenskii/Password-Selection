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
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var appearanceLabel: UILabel!
    @IBOutlet weak var lightButton: UIButton!
    @IBOutlet weak var darkButton: UIButton!
    
    private var password = ""
    private var symbolsAmount = 0
    private var isDark = false
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    // MARK: - Settings
    
    private func setupLayout() {
        createLayoutButtons([generatePasswordButton, guessThePasswordButton, resetButton, stopButton, lightButton, darkButton])
        createAppearance(isDark)
    }
    
    private func createLayoutButtons(_ buttons: [UIButton]) {
        for index in 0..<buttons.count {
            buttons[index].layer.cornerRadius = Metric.cornerRadius
            buttons[index].layer.shadowOpacity = Metric.shadowOpacity
            buttons[index].layer.shadowColor = CGColor(red: Metric.indexColor, green: Metric.indexColor, blue: Metric.indexColor, alpha: Metric.alpha)
            buttons[index].layer.shadowOffset = CGSize(width: Metric.widthShadow, height: Metric.heightShadow)
        }
    }
    
    private func createAppearance(_ isDark: Bool) {
        if isDark {
            view.backgroundColor = .black
            lightButton.backgroundColor = .white
            darkButton.backgroundColor = .lightGray
            appearanceLabel.textColor = .white
            passwordLabel.textColor = .white
        } else {
            view.backgroundColor = .white
            lightButton.backgroundColor = .lightGray
            darkButton.backgroundColor = .white
            appearanceLabel.textColor = .black
            passwordLabel.textColor = .black
        }
    }
    
    // MARK: - Actions
    
    @IBAction func startSelection(_ sender: UIButton) {
        let amount = textField.text ?? ""
        symbolsAmount = Int(amount) ?? 0
        guard symbolsAmount != 0 else { return }
        createPassword(symbolsAmount)
        textField.text = password
        textField.isSecureTextEntry = true
    }
    
    @IBAction func resetPassword(_ sender: UIButton) {
        textField.text = ""
        textField.isSecureTextEntry = false
    }
    
    @IBAction func startGuessPassword(_ sender: UIButton) {
        
    }
    
    @IBAction func stopGuessPassword(_ sender: UIButton) {
        
    }
    
    @IBAction func onLight(_ sender: UIButton) {
        isDark = false
        createAppearance(isDark)
    }
    
    @IBAction func onDark(_ sender: UIButton) {
        isDark = true
        createAppearance(isDark)
    }
    
    func createPassword(_ amount: Int) {
        let symbols = password.printable
        var arrayString: [Character] = []
        var index = 0
        while index < amount {
            let symbol = Array(symbols).randomElement()
            arrayString.append(symbol ?? "0")
            index += 1
        }
        password = String(arrayString)
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
