//
//  TiOnboardingViewProxy.swift
//  TiOnboarding
//
//  Created by Jan Vennemann on 15.01.19.
//

import Foundation
import TitaniumKit
import PaperOnboarding

class TiOnboardingView : TiUIView {
  
  var onboardingView: PaperOnboarding
  
  override init(frame: CGRect) {
    onboardingView = PaperOnboarding()
    
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    onboardingView = PaperOnboarding()
    
    super.init(coder: aDecoder)
  }
  
  override func initializeState() {
    super.initializeState()
    
    guard (proxy as! TiOnboardingViewProxy).items.count > 0 else {
      return
    }
    
    self.initializeOnboardingView()
    onboardingView.delegate = self.proxy
    onboardingView.dataSource = self.proxy
  }
  
  private func initializeOnboardingView() {
    onboardingView.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(onboardingView)
    for attribute: NSLayoutConstraint.Attribute in [.left, .right, .top, .bottom] {
      let constraint = NSLayoutConstraint(item: onboardingView,
                                          attribute: attribute,
                                          relatedBy: .equal,
                                          toItem: self,
                                          attribute: attribute,
                                          multiplier: 1,
                                          constant: 0)
      self.addConstraint(constraint)
    }
  }
}
