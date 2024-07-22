//
//  ThunderstormWeatherView.swift
//  WeatherType
//
//  Created by Тася Галкина on 22.07.2024.
//

import Foundation
import UIKit

class ThunderstormWeatherView: UIView {
    private var isFirstLightning = true

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        startLightningAnimation()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.3, alpha: 1.0)
        translatesAutoresizingMaskIntoConstraints = false
    }

    private func startLightningAnimation() {
        for _ in 0..<5 {
            Timer.scheduledTimer(withTimeInterval: Double.random(in: 0.5...1.5), repeats: true) { _ in
                self.showLightning()
            }
        }
    }

    private func showLightning() {
        let lightningImageView = createLightningImageView()
        self.addSubview(lightningImageView)

        let startPoint = getStartPoint()
        configureLightningImageView(lightningImageView, at: startPoint)
        
        animateLightning(lightningImageView)
    }

    private func createLightningImageView() -> UIImageView {
        let lightningImageView = UIImageView(image: UIImage(systemName: "bolt.fill"))
        lightningImageView.tintColor = .yellow
        lightningImageView.translatesAutoresizingMaskIntoConstraints = false
        lightningImageView.layer.shadowColor = UIColor.yellow.cgColor
        lightningImageView.layer.shadowRadius = 10
        lightningImageView.layer.shadowOpacity = 1.0
        lightningImageView.layer.shadowOffset = CGSize(width: 0, height: 0)
        return lightningImageView
    }

    private func getStartPoint() -> CGPoint {
        if isFirstLightning {
            return CGPoint(x: bounds.midX, y: bounds.midY)
        } else {
            return CGPoint(
                x: CGFloat.random(in: 0...bounds.width),
                y: CGFloat.random(in: 0...bounds.height)
            )
        }
    }

    private func configureLightningImageView(_ imageView: UIImageView, at point: CGPoint) {
        imageView.center = point
        imageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    }

    private func animateLightning(_ imageView: UIImageView) {
        if isFirstLightning {
            isFirstLightning = false
            UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseInOut], animations: {
                imageView.transform = CGAffineTransform(scaleX: 10.0, y: 10.0)
            }) { _ in
                UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseInOut], animations: {
                    imageView.alpha = 0
                }) { _ in
                    imageView.removeFromSuperview()
                }
            }
        } else {
            UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseInOut], animations: {
                imageView.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
            }) { _ in
                UIView.animate(withDuration: 0.5, delay: 0.1, options: [.curveEaseInOut], animations: {
                    imageView.alpha = 0
                }) { _ in
                    imageView.removeFromSuperview()
                }
            }
        }
        
    }
}
