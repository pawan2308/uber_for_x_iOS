//
//  LookingForRideUseCase.swift
//  DriverSampleApp
//
//  Created by Ashish Asawa on 12/04/18.
//  Copyright © 2018 Ashish Asawa. All rights reserved.
//

import Foundation
import HyperTrack

enum WorkSansFontName: String {
    case bold       = "WorkSans-Bold"
    case medium     = "WorkSans-Medium"
    case regular    = "WorkSans-Regular"
    case semiBold   = "WorkSans-SemiBold"
}

class LookingForRideUseCase: HTBaseUseCase, HTMapViewUseCase {
    
    func update() {
        
    }
    
    required init(mapDelegate: HTMapUseCaseDelegate?) {
        
    }
    
    weak public var mapDelegate: HTMapUseCaseDelegate? {
        didSet {
            mapDelegate?.setBottomView(stackView)
        }
    }
    
    fileprivate var stackView: UIStackView!
    
    init(withDriver driver: Driver) {
        let driverContainerView = HTViewFactory.createBottomViewContainer()
        let primaryAction = HTViewFactory.createPrimaryActionButton("Finding riders near you")
        primaryAction.titleLabel?.font = UIFont(name: WorkSansFontName.semiBold.rawValue, size: 12)
        primaryAction.titleLabel?.textColor = UIColor.white
        primaryAction.heightAnchor.constraint(equalToConstant: 52).isActive = true
        primaryAction.setImage(UIImage(named: "ic_looking_for_ride"), for: .normal)
        primaryAction.imageEdgeInsets = UIEdgeInsetsMake(0, -4, 0, 0)
        primaryAction.titleEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 0)
        primaryAction.topCornerRadius = 14
        
        
        driverContainerView.isBlurEnabled = true
        driverContainerView.isShadowEnabled = true
        driverContainerView.backgroundColor = UIColor.white
        
        
        let driverView = HTUserInfoView(frame: CGRect.zero)
        driverView.titleText = driver.name ?? "Philip McCoy"
        driverView.descriptionText = "4.8 ☆" //TODO: Theming
        driverView.backgroundColor = UIColor.clear
        driverView.translatesAutoresizingMaskIntoConstraints = false
        
        driverContainerView.addSubview(driverView)
        driverView.topAnchor.constraint(equalTo: driverContainerView.topAnchor, constant: 20).isActive = true
        driverView.bottomAnchor.constraint(equalTo: driverContainerView.bottomAnchor, constant: -20).isActive = true
        driverView.leftAnchor.constraint(equalTo: driverContainerView.leftAnchor, constant: 20).isActive = true
        driverView.rightAnchor.constraint(equalTo: driverContainerView.rightAnchor, constant: 20).isActive = true
        
        stackView = UIStackView(arrangedSubviews: [HTViewFactory.createPrimaryActionView(button: primaryAction), driverContainerView])
        stackView.spacing = -10
        stackView.axis = .vertical
        super.init()
    }
    
    func cleanup() {
        mapDelegate?.cleanUp()
    }
    
}
