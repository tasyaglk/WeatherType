//
//  FogWeatherView.swift
//  WeatherType2
//
//  Created by Тася Галкина on 22.07.2024.
//

import Foundation
import UIKit

class FogWeatherView: UIView {
    private var fogImageViews = [UIImageView]()
    private let fogImageCount = 3

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 0.68, green: 0.85, blue: 0.90, alpha: 1.0)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        setupFogImageViews()
        startFogAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupFogImageViews() {
        for i in 0..<fogImageCount {
            let fogImageView = UIImageView(image: UIImage(named: "fog"))
            fogImageView.contentMode = .scaleAspectFit
            fogImageView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(fogImageView)
            fogImageViews.append(fogImageView)
            
            let offset = CGFloat(i) * 200
            NSLayoutConstraint.activate([
                fogImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: offset),
                fogImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                fogImageView.heightAnchor.constraint(equalToConstant: 200),
                fogImageView.widthAnchor.constraint(equalToConstant: 200)  
            ])
        }
    }
    
    private func startFogAnimation() {
        let animationDuration: TimeInterval = 20.0
        let animationOffset: CGFloat = 200.0
        
        for fogImageView in fogImageViews {
            UIView.animate(withDuration: animationDuration, delay: 0, options: [.repeat, .autoreverse, .curveLinear], animations: {
                fogImageView.transform = CGAffineTransform(translationX: animationOffset, y: 0)
            }, completion: nil)
        }
    }
}
