//
//  ViewController.swift
//  Assignment 1 - Traffic Light
//
//  Created by Luka Khokhiashvili on 10.05.24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var traficFrame: UIView!
    @IBOutlet var redCircle: UIView!
    @IBOutlet var yellowCircle: UIView!
    @IBOutlet var greenCircle: UIView!
    
    @IBOutlet var circles: [UIView]!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .black
        traficFrame.backgroundColor = .white
        traficFrame.layer.cornerRadius = 50
        traficFrame.layer.borderWidth = 10
        traficFrame.layer.borderColor = UIColor.gray.cgColor
        
        
        for viewCircle in circles{
            viewCircle.backgroundColor = .darkGray
            viewCircle.layer.cornerRadius = 60
            viewCircle.layer.borderWidth = 2
            viewCircle.layer.borderColor = UIColor.black.cgColor
        }
        
        
       
    }

    func trafLight(second:Int){
        let colors: [UIColor] = [.red, .yellow, .green]

        for (index, circle) in self.circles.enumerated() {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(second*index)) {
                print(index)
                circle.backgroundColor = colors[index]
                
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(second*index+second)) {
                print("meore")

                circle.backgroundColor = .darkGray
            }
            

        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let second = 1
        let n = 4
        for i in 0..<n{
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3*second*i)) {
                self.trafLight(second: second)
            }
        }
    }
    
}

