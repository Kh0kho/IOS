//
//  ViewController.swift
//  Assignment 2 - Passcode
//
//  Created by Luka Khokhiashvili on 06.06.
    
import UIKit

class ViewController: UIViewController {

    private let passwordFieldStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.backgroundColor = .clear
//        stack.border()
        return stack
    }()
    private let enterPasscodeLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter Passcode"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    private let passwordCirclesStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 15
        return stack
    }()
    
    private let numPadSpacing = 20.0
    private let numPadStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private var numPadRowStackViews: [UIStackView] = []
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(UIImage(systemName: "delete.left", withConfiguration: UIImage.SymbolConfiguration(scale: .large)), for: .normal)
        button.tintColor = .white
        return button
    }()
    private let buttonText: [String] = ["","A B C","D E F","G H I","J K L","M N O","P Q R S","T U V","W X Y Z","clear",""]
    
    private var buttonArray: [UIButton] = []
    
    private var circleArray: [PasscodeCircle] = []
    
    private let correctPasscode = "111111"
    
    private var enteredPasscode = ""
    
    var inputCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(red: 31/255, green: 33/255, blue: 36/255, alpha: 1)

        designPasswordFieldStack()
        designNumPadStackView()
        
        
    }
    
    
    
    //Passcode Field
    
    
    private func designPasswordFieldStack() {
        initPasswcodeFieldStack()
        designPasswordCirclesStack()
        
        
    }
    
    private func initPasswcodeFieldStack () {
        view.addSubview(passwordFieldStack)
        passwordFieldStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordFieldStack.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height/5),
            passwordFieldStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/3.5),
            passwordFieldStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/3.5),
            passwordFieldStack.heightAnchor.constraint(equalToConstant: view.frame.height/9)
            
        ])
        
        passwordFieldStack.addArrangedSubview(enterPasscodeLabel)
        passwordFieldStack.addArrangedSubview(passwordCirclesStack)
        
    }
    
    private func designPasswordCirclesStack() {
        for _ in 0...5 {
            let singleCircle = PasscodeCircle()
            passwordCirclesStack.addArrangedSubview(singleCircle)
            circleArray.append(singleCircle)
        }
        
        
    }
    
    
    //Number Pad
   
    private func designNumPadStackView() {
        view.addSubview(numPadStackView)
        numPadStackView.spacing = numPadSpacing*8/9
        numPadStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            numPadStackView.topAnchor.constraint(equalTo: passwordFieldStack.bottomAnchor, constant: 60),
            numPadStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65),
            numPadStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            numPadStackView.heightAnchor.constraint(equalTo: numPadStackView.widthAnchor, multiplier: 4/3)
        ])
        
        for _ in 0...3 {
            let tempStackView: UIStackView = {
                let stackView = UIStackView()
                stackView.axis = .horizontal
                stackView.spacing = numPadSpacing
                stackView.distribution = .fillEqually
                stackView.backgroundColor = .clear
                return stackView
            }()
            numPadRowStackViews.append(tempStackView)
            numPadStackView.addArrangedSubview(tempStackView)
        }
        
        designNumPadRows()
        
    }
    
    private func designNumPadRows() {
        for i in 1...12 {
            switch i  {
            case 1...9, 11:
                let number = i%11
                let letters = buttonText[i-1]
                let button = numberPadButton(num: number.codingKey.stringValue, letters: letters)
                button.addTarget(self, action: #selector(buttonHandler) , for: .touchUpInside)
                button.addTarget(self, action: #selector(buttonColorChange) , for: .touchDown)
                numPadRowStackViews[(i-1)/3].addArrangedSubview(button)
                buttonArray.append(button)
            case 12:
                deleteButton.addTarget(self, action: #selector(deleteHandler) , for: .touchUpInside)
                numPadRowStackViews[(i-1)/3].addArrangedSubview(deleteButton)
                buttonArray.append(deleteButton)
            default:
                numPadRowStackViews[(i-1)/3].addArrangedSubview(UIView(frame: .zero))
            }
        }
        
    }
    
    @objc
    private func buttonHandler(sender: numberPadButton) {
        sender.backgroundColor = .clear
        if inputCounter >= 0 && inputCounter < 6 {
            inputCounter += 1
            enteredPasscode.append(sender.num)
            updateCircles()
        }
        
    }
    @objc
    private func buttonColorChange(sender: numberPadButton) {
        sender.backgroundColor = UIColor(white: 1, alpha: 0.2)
    }
    @objc
    private func deleteHandler(sender: numberPadButton) {
        if inputCounter > 0 && inputCounter <= 6 {
            inputCounter -= 1
            enteredPasscode.removeLast()
            updateCircles()
        }
    }
    
    private func updateCircles() {
        if inputCounter == 6 {
            switch checkPasscode() {
            case true:
                changeAllCircleColor(color: .green)
            default:
                changeAllCircleColor(color: .red)
            }
        }
        else{
            for i in 0...5 {
                if i < inputCounter {
                    circleArray[i].backgroundColor = .white
                } else {
                    circleArray[i].backgroundColor = .clear
                }
                
            }
        }
    }
    private func changeAllCircleColor(color: UIColor){
        for circle in circleArray{
            circle.backgroundColor = color
        }
    }
    
    private func checkPasscode()->Bool{
        if correctPasscode == enteredPasscode {
            return true
        }
        return false
    }
    
    override func viewDidLayoutSubviews() {
        for tempButton in buttonArray{
            tempButton.roundCourner()
        }
        for tempCircle in circleArray{
            tempCircle.roundCourner()
        }
    }
    

}


extension UIView {
    func roundCourner() {
        let cornerRadius = min(self.frame.size.width, self.frame.size.height) / 2
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
    func border() {
        self.layer.borderWidth = 1
        self.layer.borderColor =  CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        self.layer.masksToBounds = true
    }
}


