//
//  DogBreedImagePageView.swift
//  VIPER-testing
//
//  Created by Nathaniel Putera on 14/09/23.
//

import Foundation
import UIKit

protocol DogBreedImagePageView: AnyObject {
    
}

final class DefaultDogBreedImagePageView: UIViewController, DogBreedImagePageView {
    var breedList: [DogBreedModel] = []
    var i = 0
    let presenter: DogBreedImagePagePresenter
    let spinnerView = UIView()
    let dogType: String
    
    lazy var imageDisplay: UIImageView = {
        let i = UIImageView()
        i.translatesAutoresizingMaskIntoConstraints = false
        i.backgroundColor = .clear
        return i
    }()
    
    lazy var imageName: UILabel = {
        let l = UILabel()
        l.text = "Dog name here"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    lazy var nextButton: UIButton = {
        let b = UIButton()
        b.setImage(UIImage(named: "icons8-next-50"), for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    lazy var likeButton: UIButton = {
        let b = UIButton()
        b.setImage(UIImage(named: "like_button"), for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    lazy var prevButton: UIButton = {
        let b = UIButton()
        b.setImage(UIImage(named: "icons8-previous-50"), for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    init(presenter: DogBreedImagePagePresenter, dogType: String) {
        self.presenter = presenter
        self.dogType = dogType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        lock()
        presenter.fetchImage(completion: { [weak self] list in
            DispatchQueue.main.async {
                self?.unlock()
                self?.breedList = list
                if let data = list.first?.image {
                    self?.imageDisplay.image = UIImage(data: data)
                }
                self?.updateButtonState()
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        presenter.updateFavList()
        super.viewWillDisappear(animated)
    }
    
    private func setupView() {
        view.addSubview(imageDisplay)
        view.addSubview(nextButton)
        view.addSubview(prevButton)
        view.addSubview(likeButton)
        view.addSubview(imageName)
        
        imageName.text = dogType
        
        setupButtonAction()
        setupConstraint()
    }
    
    private func setupButtonAction() {
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        prevButton.addTarget(self, action: #selector(prevButtonTapped), for: .touchUpInside)
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }
    
    private func setupConstraint() {
        let buttonSize = 64
        var constraints: [NSLayoutConstraint] = []
        constraints.append(imageDisplay.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75))
        constraints.append(imageDisplay.heightAnchor.constraint(equalTo: imageDisplay.widthAnchor))
        constraints.append(imageDisplay.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(prevButton.centerYAnchor.constraint(equalTo: nextButton.centerYAnchor))
        constraints.append(likeButton.centerYAnchor.constraint(equalTo: nextButton.centerYAnchor))
        constraints.append(likeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(imageName.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(contentsOf: NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-(>=8)-[p(\(buttonSize))]-[l(\(buttonSize))]-[n(\(buttonSize))]-(>=8)-|",
            metrics: nil,
            views: ["n": nextButton, "p": prevButton, "l": likeButton]
        ))
        constraints.append(contentsOf: NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-[i]-[t]-[l(\(buttonSize))]",
            metrics: nil,
            views: ["i": imageDisplay, "t": imageName, "l": likeButton]
        ))
        NSLayoutConstraint.activate(constraints)
    }
    
    private func updateButtonState() {
        nextButton.isEnabled = !(i == breedList.count - 1)
        prevButton.isEnabled = !(i == breedList.count || i == 0)
        nextButton.alpha = nextButton.isEnabled ? 1.0 : 0.5
        prevButton.alpha = prevButton.isEnabled ? 1.0 : 0.5
        let likeImage = UIImage(named: breedList[i].isLiked ? "liked_image" : "like_button")
        likeButton.setImage(likeImage, for: .normal)
    }
    
    @objc private func likeButtonTapped() {
        breedList[i].isLiked = !breedList[i].isLiked
        presenter.likeImage(model: breedList[i])
        updateButtonState()
    }
    
    @objc private func nextButtonTapped() {
        imageDisplay.image = UIImage(data: breedList[i+1].image)
        i += 1
        updateButtonState()
    }
    
    @objc private func prevButtonTapped() {
        imageDisplay.image = UIImage(data: breedList[i-1].image)
        i -= 1
        updateButtonState()
    }
    
    private func lock() {
        let spinner = UIActivityIndicatorView(style: .large)
        spinnerView.backgroundColor = .black
        spinnerView.alpha = 0.7
        spinnerView.translatesAutoresizingMaskIntoConstraints = false
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinnerView)
        spinnerView.addSubview(spinner)
        view.bringSubviewToFront(spinnerView)

        spinnerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        spinnerView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: spinnerView.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: spinnerView.centerYAnchor).isActive = true
    }
    
    private func unlock() {
        spinnerView.removeFromSuperview()
    }

}
    
