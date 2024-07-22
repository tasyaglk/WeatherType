//
//  CloudyWeatherView.swift
//  WeatherType
//
//  Created by Тася Галкина on 22.07.2024.
//

import Foundation
import UIKit

class CloudyWeatherView: UIView {
    private var cloudImageViews: [UIImageView] = []
    private var cloudVelocities: [CGPoint] = []
    private let cloudSize = CGSize(width: 200, height: 100)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 0.5, green: 0.6, blue: 0.7, alpha: 1.0)
        setupClouds()
        startCloudAnimation()
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupClouds() {
        let numberOfClouds = 10
        for _ in 0..<numberOfClouds {
            let cloudImageView = createCloudImageView()
            let cloudVelocity = createRandomCloudVelocity()
            cloudVelocities.append(cloudVelocity)
            cloudImageViews.append(cloudImageView)
            scaleCloudImageView(cloudImageView)
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
}

