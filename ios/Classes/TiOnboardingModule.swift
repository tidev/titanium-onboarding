//
//  TiOnboardingModule.swift
//  titanium-onboarding
//
//  Created by Jan Vennemann
//  Copyright (c) 2019 Axway Appcelerator. All rights reserved.
//

import UIKit
import TitaniumKit

/**
 
 Titanium Swift Module Requirements
 ---
 
 1. Use the @objc annotation to expose your class to Objective-C (used by the Titanium core)
 2. Use the @objc annotation to expose your method to Objective-C as well.
 3. Method arguments always have the "[Any]" type, specifying a various number of arguments.
 Unwrap them like you would do in Swift, e.g. "guard let arguments = arguments, let message = arguments.first"
 4. You can use any public Titanium API like before, e.g. TiUtils. Remember the type safety of Swift, like Int vs Int32
 and NSString vs. String.
 
 */

@objc(TiOnboardingModule)
public class TiOnboardingModule: TiModule {
  
  func moduleGUID() -> String {
    return "21f6c8e0-7d8f-4b96-b834-6ad386022fc7"
  }
  
  override public func moduleId() -> String! {
    return "ti.onboarding"
  }

  override open func startup() {
    super.startup()
    print("[DEBUG] \(self) loaded")
  }
  
  @objc(createView:)
  public func createView(args: Array<Any>?) -> TiOnboardingViewProxy {
    let proxy = TiOnboardingViewProxy()
    proxy._init(withPageContext: self.pageContext, args: args)
    return proxy
  }
}
