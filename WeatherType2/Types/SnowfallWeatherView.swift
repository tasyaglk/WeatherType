//
//  SnowfallWeatherView.swift
//  WeatherType
//
//  Created by Тася Галкина on 22.07.2024.
//

import Foundation
import UIKit

class SnowfallWeatherView: UIView {
    private var largeSnowflakeImageView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        showInitialLargeSnowflake()
        startSnowfallAnimation()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 1.0, alpha: 1.0)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func showInitialLargeSnowflake() {
        let largeSnowflakeImageView = createSnowflakeImageView()
        largeSnowflakeImageView.transform = CGAffineTransform(scaleX: 10.0, y: 10.0)
        addSubview(largeSnowflakeImageView)
        self.largeSnowflakeImageView = largeSnowflakeImageView

        centerLargeSnowflake()

        animateLargeSnowflake(largeSnowflakeImageView)
    }

    private func createSnowflakeImageView() -> UIImageView {
        let imageView = UIImageView(image: UIImage(systemName: "snowflake"))
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }

    private func centerLargeSnowflake() {
        guard let largeSnowflakeImageView = largeSnowflakeImageView else { return }
        largeSnowflakeImageView.center = CGPoint(x: bounds.midX, y: bounds.midY)
    }

    private func animateLargeSnowflake(_ imageView: UIImageView) {
        imageView.alpha = 0

        UIView.animate(withDuration: 1.0, delay: 0, options: [.curveEaseInOut], animations: {
            imageView.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 1.0, delay: 1.0, options: [.curveEaseInOut], animations: {
                imageView.alpha = 0
            }) { _ in
                imageView.removeFromSuperview()
            }
        }
    }

    private func startSnowfallAnimation() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            self.createSnowflake()
        }
    }

    private func createSnowflake() {
        let snowflakeImageView = createSnowflakeImageView()
        addSubview(snowflakeImageView)

        let startX = CGFloat.random(in: 0...bounds.width)
        snowflakeImageView.center = CGPoint(x: startX, y: -50)

        let endX = CGFloat.random(in: 0...bounds.width)
        let endY = bounds.height + 50

        let path = createSnowflakePath(startX: startX, endX: endX, endY: endY)
        
        let animation = createSnowflakeAnimation(path: path)
        snowflakeImageView.layer.add(animation, forKey: "fallingSnowflake")

        DispatchQueue.main.asyncAfter(deadline: .now() + animation.duration) {
            snowflakeImageView.removeFromSuperview()
        }
    }

    private func createSnowflakePath(startX: CGFloat, endX: CGFloat, endY: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: startX, y: -50))
        let midX = (startX + endX) / 2
        let midY = CGFloat.random(in: 0...(bounds.height / 2))
        let controlPoint1 = CGPoint(x: midX + CGFloat.random(in: -50...50), y: midY)
        let controlPoint2 = CGPoint(x: midX + CGFloat.random(in: -50...50), y: midY + CGFloat.random(in: 50...100))
        path.addCurve(to: CGPoint(x: endX, y: endY), controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        return path
    }

    private func createSnowflakeAnimation(path: UIBezierPath) -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = path.cgPath
        animation.duration = Double.random(in: 5.0...10.0)
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        return animation
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        centerLargeSnowflake()
    }
}
