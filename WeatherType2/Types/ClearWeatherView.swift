//
//  ClearWeatherView.swift
//  WeatherType
//
//  Created by Тася Галкина on 22.07.2024.
//

import Foundation
import UIKit

class ClearWeatherView: UIView {
    
    let sunImage = UIImageView()
    private let sunSize: CGSize = CGSize(width: 200, height: 200)
        private let enlargedSunSize: CGSize = CGSize(width: 300, height: 300)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = UIColor(red: 0.68, green: 0.85, blue: 0.90, alpha: 1.0)
        configureSunImage()
        setupConstraints()
        addRotationAnimation()
        addShadow()
    }
    
    private func configureSunImage() {
        addSubview(sunImage)
        sunImage.image =  UIImage(systemName: "sun.max.fill")?.withRenderingMode(.alwaysTemplate)
        sunImage.tintColor = .yellow
    }
    
    private func setupConstraints() {
        sunImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sunImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            sunImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            sunImage.widthAnchor.constraint(equalToConstant: 200),
            sunImage.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func addRotationAnimation() {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.fromValue = 0
        animation.toValue = 2 * Double.pi
        animation.duration = 20
        animation.repeatCount = .infinity
        sunImage.layer.add(animation, forKey: "rotationAnimation")
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addShadow() {
        sunImage.layer.shadowColor = UIColor.yellow.cgColor
        sunImage.layer.shadowOffset = CGSize(width: 0, height: 5)
        sunImage.layer.shadowOpacity = 0.5
        sunImage.layer.shadowRadius = 10
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if superview != nil {
            animateSunEnlargement()
        }
    }
    override func willMove(toSuperview newSuperview: UIView?) {
        if newSuperview == nil {
            animateSunReduction()
        }
        super.willMove(toSuperview: newSuperview)
    }
    
    private func animateSunEnlargement() {
        UIView.animate(withDuration: 0.5, animations: {
            self.sunImage.transform = CGAffineTransform(scaleX: self.enlargedSunSize.width / self.sunSize.width, y: self.enlargedSunSize.height / self.sunSize.height)
        })
    }
    
    private func animateSunReduction() {
        UIView.animate(withDuration: 0.5, animations: {
            self.sunImage.transform = .identity
        })
    }
}
