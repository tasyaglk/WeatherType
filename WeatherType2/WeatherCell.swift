//
//  WeatherCell.swift
//  WeatherType
//
//  Created by Тася Галкина on 22.07.2024.
//

import UIKit

class WeatherCell: UICollectionViewCell {
    static let identifier = "WeatherCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.addSubview(titleLabel)
        contentView.backgroundColor = UIColor(red: 0.85, green: 0.93, blue: 0.98, alpha: 1.0)
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                contentView.backgroundColor = .white
                titleLabel.textColor = .black
            } else {
                contentView.backgroundColor = UIColor(red: 0.85, green: 0.93, blue: 0.98, alpha: 1.0)
                titleLabel.textColor = .black
            }
        }
    }
    
    func configure(with weatherCondition: WeatherCondition) {
        titleLabel.text = weatherCondition.localizedName
        titleLabel.textColor = .black
    }
}

