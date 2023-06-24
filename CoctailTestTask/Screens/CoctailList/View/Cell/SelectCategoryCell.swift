//
//  SelectCategoryCell.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import UIKit

final class SelectCategoryCell: UICollectionViewCell {
    
    static let identifire = "SelectCategoryCell"
    
    private let indentY: CGFloat = 8
    
    private let indentX: CGFloat = 20
    
    private let nameCategoryLabel: UILabel = UILabel()
        .setMyStyle(numberOfLines: 1,
                    textAlignment: .center,
                    font: Fonts.selectedCategory)
        .setTextColor(color: Colors.selectCategoryTextNoSelected)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setViewHierarhies()
        setupConstaints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.layer.borderColor = Colors.selectCategoryBorder.cgColor
        contentView.layer.borderWidth = 1
    }
    
    private func setViewHierarhies() {
        contentView.addSubview(nameCategoryLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = contentView.frame.height / 2
    }
    
    private func setupConstaints() {
        NSLayoutConstraint.activate([
            nameCategoryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: indentY),
            nameCategoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: indentX),
            nameCategoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -indentX),
            nameCategoryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -indentY)
        ])
    }
    
    private func stateCell(isSelected: Bool) {
        
        if isSelected  {
            contentView.backgroundColor = Colors.selectCategoryIsSelected
            nameCategoryLabel.textColor = Colors.selectCategoryTextSelected
            contentView.layer.borderWidth = 0
        } else {
            contentView.backgroundColor = Colors.mainBackGroundColor
            nameCategoryLabel.textColor = Colors.selectCategoryTextNoSelected
            contentView.layer.borderWidth = 1
        }
    }
 
    override var isSelected: Bool {
        didSet {
            stateCell(isSelected: isSelected)
        }
    }
    
}
extension SelectCategoryCell: ConfigurableView {
    func configure(with model: ModelSelectCatgoryCell) {
        self.nameCategoryLabel.text = model.nameCategory
    }
    
    typealias Model = ModelSelectCatgoryCell
}
