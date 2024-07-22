//
//  WeatherCondition.swift
//  WeatherType
//
//  Created by Тася Галкина on 22.07.2024.
//

import Foundation
import UIKit

enum WeatherCondition: String, CaseIterable {
    case clear = "Clear"
    case rain = "Rain"
    case cloudy = "Cloudy"
    case thunderstorm = "Thunderstorm"
    case fog = "Fog"
    case snow = "Snow"

    var localizedName: String {
        switch self {
        case .clear:
            return NSLocalizedString("Clear", comment: "Ясно")
        case .rain:
            return NSLocalizedString("Rain", comment: "Дождь")
        case .cloudy:
            return NSLocalizedString("Cloudy", comment: "Облачно")
        case .thunderstorm:
            return NSLocalizedString("Thunderstorm", comment: "Гроза")
        case .fog:
            return NSLocalizedString("Fog", comment: "Туман")
        case .snow:
            return NSLocalizedString("Snow", comment: "Снег")
        }
    }

    var animationView: UIView {
        switch self {
        case .clear:
            return ClearWeatherView()
        case .rain:
            return RainWeatherView()
        case .cloudy:
            return CloudyWeatherView()
        case .thunderstorm:
            return ThunderstormWeatherView()
        case .fog:
            return FogWeatherView()
        case .snow:
            return SnowfallWeatherView()
        }
    }
}
