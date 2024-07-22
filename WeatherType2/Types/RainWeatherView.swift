//
//  RainWeatherView.swift
//  WeatherType
//
//  Created by Тася Галкина on 22.07.2024.
//

import Foundation
import UIKit

class RainWeatherView: UIView {
    private var cloudImageViews: [UIImageView] = []
    private var cloudVelocities: [CGPoint] = []
    private let cloudSize = CGSize(width: 200, height: 100)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 0.5, green: 0.6, blue: 0.7, alpha: 1.0)
        setupClouds()
        setupRainDrops()
        startCloudAnimation()
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupClouds() {
        let numberOfClouds = 5
        for _ in 0..<numberOfClouds {
            let cloudImageView = createCloudImageView()
            let cloudVelocity = createRandomCloudVelocity()
            cloudVelocities.append(cloudVelocity)
            cloudImageViews.append(cloudImageView)
            scaleCloudImageView(cloudImageView)
        }
    }
    
    private func setupRainDrops() {
        let numberOfDrops = 250
        for _ in 0..<numberOfDrops {
            let dropLayer = createDropLayer()
            addDropLayer(dropLayer)
        }
    }
    
    private func startCloudAnimation() {
        let displayLink = CADisplayLink(target: self, selector: #selector(updateCloudPositions))
        displayLink.add(to: .main, forMode: .default)
    }
    
    private func createCloudImageView() -> UIImageView {
        let cloudImageView = UIImageView(image: UIImage(named: "cloud"))
        addSubview(cloudImageView)
        cloudImageView.contentMode = .scaleAspectFit
        cloudImageView.frame = CGRect(
            x: CGFloat.random(in: -cloudSize.width...bounds.width),
            y: CGFloat.random(in: -cloudSize.height...bounds.height),
            width: cloudSize.width,
            height: cloudSize.height
        )
        
        cloudImageView.translatesAutoresizingMaskIntoConstraints = false
        return cloudImageView
    }
    
    private func createRandomCloudVelocity() -> CGPoint {
        return CGPoint(x: CGFloat.random(in: 2...3), y: CGFloat.random(in: 0.5...1.5))
    }
    
    private func scaleCloudImageView(_ cloudImageView: UIImageView) {
        guard let imageSize = cloudImageView.image?.size else { return }
        let scale = min(cloudSize.width / imageSize.width, cloudSize.height / imageSize.height)
        cloudImageView.transform = CGAffineTransform(scaleX: scale, y: scale)
    }
    
    private func createDropLayer() -> CALayer {
        let dropLayer = CALayer()
        let dropWidth: CGFloat = 4
        let dropHeight: CGFloat = 25
        dropLayer.bounds = CGRect(x: 0, y: 0, width: dropWidth, height: dropHeight)
        dropLayer.position = CGPoint(
            x: CGFloat.random(in: 0...bounds.width),
            y: CGFloat.random(in: -dropHeight...bounds.height)
        )
        dropLayer.transform = CATransform3DMakeRotation(CGFloat.pi / 6, 0, 0, 1)
        return dropLayer
    }
    
    private func addDropLayer(_ dropLayer: CALayer) {
        let blurLayer = createBlurLayer(for: dropLayer)
        dropLayer.addSublayer(blurLayer)
        layer.addSublayer(dropLayer)
        animateDropLayer(dropLayer)
    }
    
    private func createBlurLayer(for dropLayer: CALayer) -> CALayer {
        let blurLayer = CALayer()
        blurLayer.frame = dropLayer.bounds
        blurLayer.backgroundColor = UIColor.blue.withAlphaComponent(0.5).cgColor
        blurLayer.cornerRadius = dropLayer.bounds.width / 2
        blurLayer.masksToBounds = true
        return blurLayer
    }
    
    private func animateDropLayer(_ dropLayer: CALayer) {
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.fromValue = -dropLayer.bounds.height
        animation.toValue = bounds.height + dropLayer.bounds.height
        animation.duration = Double.random(in: 1.5...5.0)
        animation.repeatCount = .infinity
        dropLayer.add(animation, forKey: "rainAnimation")
    }
    
    @objc private func updateCloudPositions() {
        for (index, cloudImageView) in cloudImageViews.enumerated() {
            updateCloudPosition(for: cloudImageView, at: index)
        }
    }
    
    private func updateCloudPosition(for cloudImageView: UIImageView, at index: Int) {
        var newPosition = cloudImageView.center
        newPosition.x += cloudVelocities[index].x
        newPosition.y += cloudVelocities[index].y
        
        if newPosition.x <= cloudSize.width / 2 || newPosition.x >= bounds.width - cloudSize.width / 2 {
            cloudVelocities[index].x = -cloudVelocities[index].x
        }
        
        if newPosition.y <= cloudSize.height / 2 || newPosition.y >= bounds.height - cloudSize.height / 2 {
            cloudVelocities[index].y = -cloudVelocities[index].y
        }
        
        cloudImageView.center = newPosition
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateDropLayerPositions()
    }
    
    private func updateDropLayerPositions() {
        for layer in layer.sublayers ?? [] {
            if let animation = layer.animation(forKey: "rainAnimation") {
                layer.position.x = CGFloat.random(in: 0...bounds.width)
                layer.position.y = -80
                layer.removeAnimation(forKey: "rainAnimation")
                layer.add(animation, forKey: "rainAnimation")
            }
        }
    }
}

