//
//  TiOnboardingView.swift
//  TiOnboarding
//
//  Created by Jan Vennemann on 15.01.19.
//

import Foundation
import TitaniumKit
import PaperOnboarding

class TiOnboardingOnboardingView : TiUIView {
  var onboardingView: PaperOnboarding
  
  override init(frame: CGRect) {
    self.onboardingView = PaperOnboarding()
    
    super.init(frame: frame)
    
    self.initializeOnboardingView()
    self.addSubview(self.onboardingView)
  }
  
  required init?(coder aDecoder: NSCoder) {
    self.onboardingView = PaperOnboarding()
    
    super.init(coder: aDecoder)
    
    self.initializeOnboardingView()
  }
  
  private func initializeOnboardingView() {
    self.onboardingView.delegate = self.proxy
    self.onboardingView.dataSource = self.proxy
    
    self.onboardingView.translatesAutoresizingMaskIntoConstraints = false
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
