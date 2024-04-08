//
//  WalkthroughController.swift
//  Restaurant
//
//  Created by olivier geiger on 08/04/2024.
//

import UIKit
import SnapKit

class WalkthroughController: UIViewController {
    
    // MARK: - Properties
    var currentIndex = 0
    var pageHeadings = ["CRÉER VOTRE PROPRE GUIDE DE SPOTS", "MONTRER VOTRE EMPLACEMENT", "DÉCOUVRIR UN NOUVEAU LIEU OU UN BON COIN POUR MANGER"]
    var pageImages = ["onboarding-1", "onboarding-2", "onboarding-3"]
    var pageSubHeadings = ["Marquez vos meilleurs endroits et restaurants pour créer votre propre guide",
                           "Recherchez et localisez vos spots préférés sur Maps",
                           "Trouvez des endroits et partagez-les avec vos amis"]
    
    // MARK: - UI Elements
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 0
        return label
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor(named: "NavigationBarTitle")
        pageControl.pageIndicatorTintColor = .systemGray6
        return pageControl
    }()
    
    private let previousButton: UIButton = {
        let button = UIButton()
        button.setTitle("Précédent", for: .normal)
        button.setTitleColor(UIColor(named: "NavigationBarTitle"), for: .normal)
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Suivant", for: .normal)
        button.setTitleColor(UIColor(named: "NavigationBarTitle"), for: .normal)
        return button
    }()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        updateUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(pageControl)
        view.addSubview(previousButton)
        view.addSubview(nextButton)
        
        pageControl.numberOfPages = 3
        pageControl.addTarget(self, action: #selector(pageControlValueChanged(_:)), for: .valueChanged)
        previousButton.addTarget(self, action: #selector(previousButtonTapped(_:)), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(200)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(nextButton.snp.top).offset(-20)
        }
        
        previousButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    // MARK: - Update UI
    private func updateUI() {
        imageView.image = UIImage(named: pageImages[currentIndex])
        titleLabel.text = pageHeadings[currentIndex]
        subtitleLabel.text = pageSubHeadings[currentIndex]
        pageControl.currentPage = currentIndex
        
        previousButton.isHidden = currentIndex == 0
        nextButton.setTitle(currentIndex == 2 ? "Terminer" : "Suivant", for: .normal)
    }
    
    // MARK: - Button Actions
    @objc private func pageControlValueChanged(_ sender: UIPageControl) {
        currentIndex = sender.currentPage
        updateUI()
    }
    
    @objc private func previousButtonTapped(_ sender: UIButton) {
        currentIndex = max(currentIndex - 1, 0)
        updateUI()
    }
    
    @objc private func nextButtonTapped(_ sender: UIButton) {
        if currentIndex < 2 {
            currentIndex += 1
            updateUI()
        } else {
            let navigation = RestaurantViewController()
            navigationController?.pushViewController(navigation, animated: true)
            navigationController?.setViewControllers([navigation], animated: false)
        }
    }
}

