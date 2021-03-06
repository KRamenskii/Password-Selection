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
    private var isHacking = false
    private var isPasswordCracked = false
    
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
            activityIndicator.color = .white
        } else {
            view.backgroundColor = .white
            lightButton.backgroundColor = .lightGray
            darkButton.backgroundColor = .white
            appearanceLabel.textColor = .black
            passwordLabel.textColor = .black
            activityIndicator.color = .black
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
        isPasswordCracked = false
    }
    
    @IBAction func resetPassword(_ sender: UIButton) {
        textField.text = ""
        textField.isSecureTextEntry = false
    }
    
    @IBAction func startGuessPassword(_ sender: UIButton) {
        isHacking = true
        if isHacking {
            let concurrentQueue = DispatchQueue(label: "myConcurrentQueue",
                                                qos: .default, attributes: .concurrent,
                                                autoreleaseFrequency: .inherit,
                                                target: nil)
            concurrentQueue.async {
                self.bruteForce(passwordToUnlock: self.password)
                self.isHacking = false
            }
        }
    }
    
    @IBAction func stopGuessPassword(_ sender: UIButton) {
        if self.isHacking {
            isHacking = false
            isPasswordCracked = false
            passwordLabel.text = "???????????? ???????????? ??????????????!"
            activityIndicator.startAnimating()
            activityIndicator.isHidden = true
            password = ""
        } else if isPasswordCracked {
            password = ""
            passwordLabel.text = "???????????????????? ?????????? ????????????!"
        }
    }
    
    @IBAction func onLight(_ sender: UIButton) {
        isDark = false
        createAppearance(isDark)
    }
    
    @IBAction func onDark(_ sender: UIButton) {
        isDark = true
        createAppearance(isDark)
    }
    
    private func createPassword(_ amount: Int) {
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
    
    private func bruteForce(passwordToUnlock: String) {
        let ALLOWED_CHARACTERS:   [String] = String().printable.map { String($0) }

        var password: String = ""

        while password != passwordToUnlock && isHacking {
            password = generateBruteForce(password, fromArray: ALLOWED_CHARACTERS)
            
            print(password)
            // Your stuff here
            DispatchQueue.main.async {
                self.checkPasswordCrackingStatus(password)
            }
        }
        print(password)
    }
    
    private func checkPasswordCrackingStatus(_ currentPassword: String) {
        if self.password == currentPassword {
            isPasswordCracked = true
            self.passwordLabel.text = "????????????: \(currentPassword) ??????????????!"
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            textField.isSecureTextEntry = false
        } else if isHacking && !isPasswordCracked {
            self.passwordLabel.text = "???????????? ??????????????????????... \(currentPassword)"
            activityIndicator.startAnimating()
            activityIndicator.isHidden = false
        }
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

// MARK: - Setting BruteForce

func indexOf(character: Character, _ array: [String]) -> Int {
    return array.firstIndex(of: String(character))!
}

func characterAt(index: Int, _ array: [String]) -> Character {
    return index < array.count ? Character(array[index])
    : Character("")
}

func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
    var str: String = string
    
    if str.count <= 0 {
        str.append(characterAt(index: 0, array))
    }
    else {
        str.replace(at: str.count - 1,
                    with: characterAt(index: (indexOf(character: str.last!, array) + 1) % array.count, array))
        
        if indexOf(character: str.last!, array) == 0 {
            str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last!)
        }
    }
    
    return str
}
