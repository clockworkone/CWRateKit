//
//  CWRateViewController.swift
//  CWRateKit
//
//  Created by Ilia Aparin on 01.04.2020.
//  Copyright © 2020 Clockwork, LLC. All rights reserved.
//

import UIKit

open class CWRateKitViewController: UIViewController {
    
    // MARK: - delegate
    public var delegate: CWRateKitViewControllerDelegate?
    
    // MARK: - overlay
    public var overlayOpacity: CGFloat = 0.0
    
    // MARK: - rate view
    public var backgroundColor: UIColor = .white
    public var cornerRadius: CGFloat = 16.0
    public var showShadow: Bool = true
    public var tintColor: UIColor = UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1.0)
    
    // MARK: - animation
    public var animationType: CWRateKitAnimationType = .bounce
    public var animationDuration: Float = 0.5
    
    // MARK: - haptic
    public var hapticMoments: [CWRateKitHapticMoments] = [.willChange, .willSubmit]
    
    // MARK: - rating
    public var unselectedMarkImage: UIImage? = UIImage(named: "star_unselected.png", in: Bundle(for: CWRateKitViewController.self), compatibleWith: nil)
    public var selectedMarkImage: UIImage? = UIImage(named: "star_selected.png", in: Bundle(for: CWRateKitViewController.self), compatibleWith: nil)
    public var sizeMarkImage: CGSize = CGSize(width: 36.0, height: 36.0)
    
    // MARK: - header image
    public var showHeaderImage: Bool = false
    public var headerImageIsStatic: Bool = true
    public var headerImage: UIImage?
    public var headerImageSize: CGSize = CGSize(width: 72.0, height: 72.0)
    public var headerImages: [UIImage?] = []
    
    // MARK: - submit button
    public var submitText: String = "Submit"
    public var submitTextColor: UIColor?
    public var submitFont: UIFont = .systemFont(ofSize: 18.0, weight: .medium)
    
    // MARK: - success rated
    public var successText: String = "Thank You!"
    public var successTextColor: UIColor?
    public var successFont: UIFont = .systemFont(ofSize: 20.0, weight: .regular)
    
    // MARK: - dismissing
    public var confirmRateEnabled: Bool = false
    public var showCloseButton: Bool = true
    
    // MARK: - private
    private let rateView = UIView(frame: .zero)
    private var markButtons: [UIButton] = []
    private var tintedUnselectedMarkImage: UIImage?
    private var headerImageView: UIImageView = UIImageView()
    private let stackView = UIStackView()
    private let successRatedLabel = UILabel()
    private let submitRateButton = UIButton(type: .system)
    
    private var rate: Int = 0 {
        didSet {
            delegate?.didChange(rate: rate)
        }
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        view.addSubview(rateView)
        rateView.translatesAutoresizingMaskIntoConstraints = false
        rateView.backgroundColor = backgroundColor
        rateView.layer.opacity = 0.0
        rateView.layer.cornerRadius = cornerRadius
        
        tintedUnselectedMarkImage = unselectedMarkImage?.withRenderingMode(.alwaysTemplate)
        markButtons = [
            unselectedMarkButton(id: 1001, image: tintedUnselectedMarkImage, size: sizeMarkImage),
            unselectedMarkButton(id: 1002, image: tintedUnselectedMarkImage, size: sizeMarkImage),
            unselectedMarkButton(id: 1003, image: tintedUnselectedMarkImage, size: sizeMarkImage),
            unselectedMarkButton(id: 1004, image: tintedUnselectedMarkImage, size: sizeMarkImage),
            unselectedMarkButton(id: 1005, image: tintedUnselectedMarkImage, size: sizeMarkImage)
        ]
        
        if showCloseButton {
            let closeButtonImage = UIImage(named: "close.png", in: Bundle(for: CWRateKitViewController.self), compatibleWith: nil)
            let tintedCloseButtonImage = closeButtonImage?.withRenderingMode(.alwaysTemplate)
            let closeButton = UIButton(type: .system)
            rateView.addSubview(closeButton)
            
            closeButton.translatesAutoresizingMaskIntoConstraints = false
            closeButton.setImage(tintedCloseButtonImage, for: .normal)
            closeButton.tintColor = tintColor
            closeButton.addTarget(self, action: #selector(closeRateView), for: .touchUpInside)
            
            closeButton.widthAnchor.constraint(equalToConstant: 20.0).isActive = true
            closeButton.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
            closeButton.topAnchor.constraint(equalTo: rateView.topAnchor, constant: 8.0).isActive = true
            closeButton.rightAnchor.constraint(equalTo: rateView.rightAnchor, constant: -8.0).isActive = true
        }
        
        rateView.addSubview(stackView)
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 24.0, bottom: 0, right: 24.0)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        stackView.addArrangedSubview(markButtons[0])
        stackView.addArrangedSubview(markButtons[1])
        stackView.addArrangedSubview(markButtons[2])
        stackView.addArrangedSubview(markButtons[3])
        stackView.addArrangedSubview(markButtons[4])
        
        rateView.addSubview(successRatedLabel)
        successRatedLabel.translatesAutoresizingMaskIntoConstraints = false
        successRatedLabel.text = successText
        successRatedLabel.font = successFont
        successRatedLabel.textColor = successTextColor ?? .lightGray
        successRatedLabel.alpha = 0
        successRatedLabel.textAlignment = .center
        successRatedLabel.adjustsFontSizeToFitWidth = true
        
        if showHeaderImage {
            headerImageView = UIImageView(image: headerImage)
            headerImageView.translatesAutoresizingMaskIntoConstraints = false
            rateView.addSubview(headerImageView)
            
            headerImageView.widthAnchor.constraint(equalToConstant: headerImageSize.width).isActive = true
            headerImageView.heightAnchor.constraint(equalToConstant: headerImageSize.height).isActive = true
            headerImageView.topAnchor.constraint(equalTo: rateView.topAnchor, constant: 32.0).isActive = true
            headerImageView.centerXAnchor.constraint(equalTo: rateView.centerXAnchor).isActive = true
            
            stackView.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 40.0).isActive = true
            
            successRatedLabel.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 40.0).isActive = true
        } else {
            stackView.topAnchor.constraint(equalTo: rateView.topAnchor, constant: 32.0).isActive = true
            successRatedLabel.topAnchor.constraint(equalTo: rateView.topAnchor, constant: 32.0).isActive = true
        }
        
        if confirmRateEnabled {
            rateView.addSubview(submitRateButton)
            submitRateButton.translatesAutoresizingMaskIntoConstraints = false
            submitRateButton.setTitle(submitText, for: .normal)
            submitRateButton.tintColor = submitTextColor ?? view.tintColor
            submitRateButton.titleLabel?.font = submitFont
            submitRateButton.addTarget(self, action: #selector(submitRate), for: .touchUpInside)
            
            submitRateButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 32.0).isActive = true
            submitRateButton.bottomAnchor.constraint(equalTo: rateView.bottomAnchor, constant: -16.0).isActive = true
            submitRateButton.centerXAnchor.constraint(equalTo: rateView.centerXAnchor).isActive = true
        } else {
            stackView.bottomAnchor.constraint(equalTo: rateView.bottomAnchor, constant: -32.0).isActive = true
            successRatedLabel.bottomAnchor.constraint(equalTo: rateView.bottomAnchor, constant: -32.0).isActive = true
        }
        
        NSLayoutConstraint.activate([
            rateView.widthAnchor.constraint(equalToConstant: view.frame.size.width - 32.0),
            rateView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100.0),
            rateView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            rateView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.leftAnchor.constraint(equalTo: rateView.leftAnchor, constant: 16.0),
            stackView.rightAnchor.constraint(equalTo: rateView.rightAnchor, constant: -16.0),
            
            successRatedLabel.leftAnchor.constraint(equalTo: rateView.leftAnchor, constant: 16.0),
            successRatedLabel.rightAnchor.constraint(equalTo: rateView.rightAnchor, constant: -16.0)
        ])
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if showShadow {
            rateView.layer.shadowColor = UIColor.black.cgColor
            rateView.layer.shadowOpacity = 0.25
            rateView.layer.shadowOffset = CGSize(width: 6, height: 6)
            rateView.layer.shadowRadius = 7
            rateView.layer.shadowPath = UIBezierPath(rect: rateView.bounds).cgPath
            rateView.layer.shouldRasterize = true
            rateView.layer.rasterizationScale = UIScreen.main.scale
            rateView.layer.masksToBounds = false
        }
        
        UIView.animate(withDuration: TimeInterval(animationDuration), animations: {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(self.overlayOpacity)
            self.rateView.layer.opacity = 1.0
        })
    }
    
    private func dismissRateView() {
        UIView.animate(withDuration: TimeInterval(animationDuration), animations: {
            self.view.backgroundColor = .clear
            self.rateView.layer.opacity = 0.0
        }) { _ in
            self.delegate?.didDismiss()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc private func closeRateView(_ sender: UIButton) {
        dismissRateView()
    }
    
    @objc private func submitRate(_ sender: UIButton) {
        if hapticMoments.contains(.willSubmit) {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        }
        
        submit()
    }
    
    @objc private func didTapMark(_ sender: UIButton) {
        if !confirmRateEnabled && rate > 0 {
            return
        }
        
        markButtons[0].setImage(tintedUnselectedMarkImage, for: .normal)
        markButtons[1].setImage(tintedUnselectedMarkImage, for: .normal)
        markButtons[2].setImage(tintedUnselectedMarkImage, for: .normal)
        markButtons[3].setImage(tintedUnselectedMarkImage, for: .normal)
        markButtons[4].setImage(tintedUnselectedMarkImage, for: .normal)
        
        if hapticMoments.contains(.willChange) {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        }
        
        switch sender.tag {
        case 1001:
            if let imageView = markButtons[0].imageView {
                UIView.transition(with: imageView, duration: 0.5, options: .transitionCrossDissolve, animations: {
                    self.markButtons[0].setImage(self.selectedMarkImage, for: .normal)
                }, completion: nil)
                changeHeaderImage(image: headerImages[0])
                rate = 1
            }
        case 1002:
            markButtons[0].setImage(selectedMarkImage, for: .normal)
            if let imageView = markButtons[1].imageView {
                UIView.transition(with: imageView, duration: 0.5, options: .transitionCrossDissolve, animations: {
                    self.markButtons[1].setImage(self.selectedMarkImage, for: .normal)
                }, completion: nil)
            }
            changeHeaderImage(image: headerImages[1])
            rate = 2
        case 1003:
            markButtons[0].setImage(selectedMarkImage, for: .normal)
            markButtons[1].setImage(selectedMarkImage, for: .normal)
            if let imageView = markButtons[2].imageView {
                UIView.transition(with: imageView, duration: 0.5, options: .transitionCrossDissolve, animations: {
                    self.markButtons[2].setImage(self.selectedMarkImage, for: .normal)
                }, completion: nil)
            }
            changeHeaderImage(image: headerImages[2])
            rate = 3
        case 1004:
            markButtons[0].setImage(selectedMarkImage, for: .normal)
            markButtons[1].setImage(selectedMarkImage, for: .normal)
            markButtons[2].setImage(selectedMarkImage, for: .normal)
            if let imageView = markButtons[3].imageView {
                UIView.transition(with: imageView, duration: 0.5, options: .transitionCrossDissolve, animations: {
                    self.markButtons[3].setImage(self.selectedMarkImage, for: .normal)
                }, completion: nil)
            }
            changeHeaderImage(image: headerImages[3])
            rate = 4
        case 1005:
            markButtons[0].setImage(selectedMarkImage, for: .normal)
            markButtons[1].setImage(selectedMarkImage, for: .normal)
            markButtons[2].setImage(selectedMarkImage, for: .normal)
            markButtons[3].setImage(selectedMarkImage, for: .normal)
            if let imageView = markButtons[4].imageView {
                UIView.transition(with: imageView, duration: 0.5, options: .transitionCrossDissolve, animations: {
                    self.markButtons[4].setImage(self.selectedMarkImage, for: .normal)
                }, completion: nil)
            }
            changeHeaderImage(image: headerImages[4])
            rate = 5
        default:
            break
        }
        
        if !confirmRateEnabled {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.submit()
            }
        }
    }
    
    private func submit() {
        self.delegate?.didSubmit(rate: self.rate)
        UIView.transition(with: self.rateView, duration: 0.75, options: .transitionCrossDissolve, animations: {
            self.stackView.alpha = 0
            self.successRatedLabel.alpha = 1
        }) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.dismissRateView()
            }
        }
    }
    
    private func changeHeaderImage(image: UIImage?) {
        if !headerImageIsStatic {
            switch animationType {
            case .bounce:
                headerImageView.transform = CGAffineTransform.identity.scaledBy(x: 0.001, y: 0.001)
                headerImageView.image = image
                UIView.animate(withDuration: 0.25, animations: {
                    self.headerImageView.transform = CGAffineTransform.identity
                }) { _ in
                    UIView.animate(withDuration: 0.2, animations: {
                        self.headerImageView.transform = CGAffineTransform.identity.scaledBy(x: 0.85, y: 0.85)
                    }) { _ in
                        UIView.animate(withDuration: 0.2, animations: {
                            self.headerImageView.transform = CGAffineTransform.identity
                        })
                    }
                }
                break
            }
        }
    }
    
    private func unselectedMarkButton(id: Int, image: UIImage?, size: CGSize) -> UIButton {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = id
        button.setImage(image, for: .normal)
        button.tintColor = tintColor
        button.addTarget(self, action: #selector(didTapMark), for: .touchUpInside)
        
        button.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        button.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        
        return button
    }
    
}
