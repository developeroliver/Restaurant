//
//  RatingView.swift
//  Restaurant
//
//  Created by olivier geiger on 30/03/2024.
//

import UIKit

protocol RatingViewDelegate: AnyObject {
    func ratingView(_ ratingView: RatingView, didUpdateRating rating: Int)
}

class RatingView: UIView {
    
    weak var delegate: RatingViewDelegate?
    
    private var buttons = [UIButton]()
    private let spacing: CGFloat = 8.0
    private let starCount = 5
    private var rating = 0 {
        didSet {
            updateButtonSelectionStates()
            delegate?.ratingView(self, didUpdateRating: rating)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
     func setupButtons() {
        for _ in 0..<starCount {
            let button = UIButton()
            button.setImage(UIImage(systemName: "star"), for: .normal)
            button.setImage(UIImage(systemName: "star.fill"), for: .selected)
            button.tintColor = .systemYellow
            button.addTarget(self, action: #selector(ratingButtonTapped(_:)), for: .touchUpInside)
            buttons.append(button)
            addSubview(button)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let buttonSize = CGSize(width: 44.0, height: 44.0)
        var buttonFrame = CGRect(origin: .zero, size: buttonSize)
        for (index, button) in buttons.enumerated() {
            buttonFrame.origin.x = CGFloat(index) * (buttonSize.width + spacing)
            button.frame = buttonFrame
        }
        updateButtonSelectionStates()
    }
    
    @objc private func ratingButtonTapped(_ sender: UIButton) {
        guard let index = buttons.firstIndex(of: sender) else { return }
        let selectedRating = index + 1
        if selectedRating == rating {
            rating = 0
        } else {
            rating = selectedRating
        }
    }
    
     func updateButtonSelectionStates() {
        for (index, button) in buttons.enumerated() {
            button.isSelected = index < rating
        }
    }
}
