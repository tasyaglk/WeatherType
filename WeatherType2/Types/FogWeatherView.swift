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
    private let fogImageCount = 5
    private let imageSize: CGFloat = 200
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 0.68, green: 0.85, blue: 0.90, alpha: 1.0)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        setupFogImageViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupFogImageViews() {
        for _ in 0..<fogImageCount {
            let fogImageView = UIImageView(image: UIImage(named: "fog"))
            fogImageView.contentMode = .scaleAspectFill
            fogImageView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(fogImageView)
            fogImageViews.append(fogImageView)
        }
        
        DispatchQueue.main.async {
            self.startFogAnimation()
        }
    }
    
    private func startFogAnimation() {
        let animationDuration: TimeInterval = 30.0
        let animationOffset: CGFloat = 200.0
        
        guard self.bounds.width >= imageSize else {
            print("Ошибка: ширина view меньше ширины изображения.")
            return
        }
        
        for (index, fogImageView) in fogImageViews.enumerated() {
            let maxXOffset = max(0, self.bounds.width - imageSize)
            let randomXOffset = CGFloat.random(in: 0...maxXOffset)
            fogImageView.frame = CGRect(x: randomXOffset, y: self.bounds.height - imageSize, width: imageSize, height: imageSize)
            
            let delay = Double(index) * 3.0
            let duration = animationDuration + Double.random(in: 0...10.0)
            
            UIView.animate(withDuration: duration, delay: delay, options: [.repeat, .autoreverse, .curveLinear], animations: {
                fogImageView.transform = CGAffineTransform(translationX: animationOffset, y: 0)
            }, completion: nil)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for fogImageView in fogImageViews {
            let maxXOffset = max(0, self.bounds.width - imageSize)
            let randomXOffset = CGFloat.random(in: 0...maxXOffset)
            fogImageView.frame.origin.x = randomXOffset
        }
        
        startFogAnimation()
    }
}

