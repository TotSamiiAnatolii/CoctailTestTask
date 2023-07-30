//
//  CitySelectionButton.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import UIKit

final class CitySelectionButton: UIButton {
    
    private let nameCity: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.citySelection
        label.textColor = Colors.textColor
        return label
    }()
    
    private let imageArrowDown: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = Images.arrowDown
        return image
    }()
    
    private let stackView = UIStackView()
        .myStyleStack(
            spacing: 8,
            alignment: .center,
            axis: .horizontal,
            distribution: .fill,
            userInteraction: false)
    
    override var isHighlighted: Bool {
        
        didSet {
            if isHighlighted {
                touchDown()
            } else {
                touchUp()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        setViewHierarhies()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewHierarhies() {
        self.addSubview(stackView)
        stackView.addArrangedSubview(nameCity)
        stackView.addArrangedSubview(imageArrowDown)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func touchDown() {
        self.nameCity.alpha = 0.5
        self.imageArrowDown.alpha = 0.5
    }
    
    private func  touchUp() {
        UIView.animateKeyframes(withDuration: 0.4,
                                delay: 0,
                                options: [.beginFromCurrentState,
                                          .allowUserInteraction],
                                animations: {
            self.nameCity.alpha = 1
            self.imageArrowDown.alpha = 1
        })
    }
}
extension CitySelectionButton: ConfigurableView {
    
    typealias Model = String
    
    func configure(with model: String) {
        self.nameCity.text = model
    }
}
