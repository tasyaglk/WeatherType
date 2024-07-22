//
//  WeatherTypeViewController.swift
//  WeatherType
//
//  Created by Тася Галкина on 22.07.2024.
//

import UIKit

class WeatherTypeViewController: UIViewController {
    private var currentWeatherView: UIView?
    
    private lazy var weatherCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 50)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(WeatherCell.self, forCellWithReuseIdentifier: WeatherCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupCollectionView()
        selectRandomWeatherCondition()
    }
    
    private func setupCollectionView() {
        view.addSubview(weatherCollectionView)
        NSLayoutConstraint.activate([
            weatherCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weatherCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weatherCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            weatherCollectionView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func selectRandomWeatherCondition() {
        let randomCondition = WeatherCondition.allCases.randomElement() ?? WeatherCondition.rain
        displayWeatherCondition(randomCondition)
    }
    
    private func displayWeatherCondition(_ condition: WeatherCondition) {
        currentWeatherView?.removeFromSuperview()
        currentWeatherView = condition.animationView
        view.insertSubview(currentWeatherView!, belowSubview: weatherCollectionView)
        
        NSLayoutConstraint.activate([
            currentWeatherView!.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            currentWeatherView!.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            currentWeatherView!.topAnchor.constraint(equalTo: weatherCollectionView.bottomAnchor),
            currentWeatherView!.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension WeatherTypeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return WeatherCondition.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCell.identifier, for: indexPath) as! WeatherCell
        let weatherCondition = WeatherCondition.allCases[indexPath.item]
        cell.configure(with: weatherCondition)
        return cell
    }
}

extension WeatherTypeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCondition = WeatherCondition.allCases[indexPath.item]
        UIView.transition(with: view, duration: 0.5, options: [.transitionCrossDissolve], animations: {
            self.displayWeatherCondition(selectedCondition)
        }, completion: nil)
    }
}


