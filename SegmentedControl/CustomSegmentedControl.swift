//
//  CustomSegmentedControl.swift
//  SegmentedControl
//
//  Created by FAP on 14/01/2018.
//  Copyright © 2018 Filipe Souza. All rights reserved.
//

import UIKit

@IBDesignable
class CustomSegmentedControl: UIControl {
    
    var buttons = [UIButton]()
    var selector: UIView!
    var triangle: TriangleView!
    var selectedSegmentIndex = 0
    
    @IBInspectable
    var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            updateView()
        }
    }
    
    @IBInspectable
    var commaSeparatedButtonTitles: String = "" {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var textColor: UIColor = .lightGray {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var selectorColor: UIColor = .darkGray {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var selectorTextColor: UIColor = .white {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        buttons.removeAll()
        subviews.forEach { $0.removeFromSuperview() }
        
        let buttonTitles = commaSeparatedButtonTitles.components(separatedBy: ",")
        
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.setTitleColor(textColor, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            buttons.append(button)
        }
        
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
        
        let selectorWidth = frame.width / CGFloat(buttonTitles.count)
        selector = UIView(frame: CGRect(x: 0, y: 0, width: selectorWidth, height: frame.height))
        selector.layer.cornerRadius = cornerRadius
        selector.backgroundColor = selectorColor
        addSubview(selector)
        
        let triangleX = selector.frame.width / 2 - 5
        triangle = TriangleView(frame: CGRect(x: triangleX, y: frame.height, width: 10 , height: 5))
        triangle.backgroundColor = UIColor.clear
        addSubview(triangle)

        // MARK: iOS 9.0+
//        let sv = UIStackView(arrangedSubviews: buttons)
//        sv.axis = .horizontal
//        sv.alignment = .fill
//        sv.distribution = .fillProportionally
//
//        addSubview(sv)
//
//        sv.translatesAutoresizingMaskIntoConstraints = false
//        sv.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        sv.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
//        sv.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//        sv.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        // MARK: iOS 8.0-
        for (buttonIndex,button) in buttons.enumerated() {
            let buttonStartPosition = frame.width / CGFloat(buttons.count) * CGFloat(buttonIndex)
            let selectorWidth = frame.width / CGFloat(buttonTitles.count)
            button.frame = CGRect(x: buttonStartPosition, y: 0, width: selectorWidth, height: frame.height)
            addSubview(button)
        }
        
    }
    
    @objc func buttonTapped(_ button: UIButton) {
        for (buttonIndex, btn) in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
            if btn == button {
                selectedSegmentIndex = buttonIndex
                let selectorStartPosition = frame.width / CGFloat(buttons.count) * CGFloat(buttonIndex)
                let triangleStartPosition = selectorStartPosition + selector.frame.width / 2 - 5
                UIView.animate(withDuration: 0.3, animations: {
                    self.selector.frame.origin.x = selectorStartPosition
                    self.triangle.frame.origin.x = triangleStartPosition
                })
                btn.setTitleColor(selectorTextColor, for: .normal)
            }
        }
        
        sendActions(for: .valueChanged)
    }

}

class TriangleView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.beginPath()
        context.move(to: CGPoint(x: rect.minX, y: rect.minY))
        context.addLine(to: CGPoint(x: (rect.maxX / 2.0), y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        context.closePath()
        
        context.setFillColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        context.fillPath()
    }
    
}
