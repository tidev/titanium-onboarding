//
//  TiOnboardingViewProxy.swift
//  TiOnboarding
//
//  Created by Jan Vennemann on 15.01.19.
//

import Foundation
import TitaniumKit
import PaperOnboarding

public class TiOnboardingViewProxy : TiViewProxy {
  @objc public var beforeTransition: KrollCallback?

  @objc public var afterTransition: KrollCallback?

  private var _defaultItemColor: TiColor
  @objc public var defaultItemColor: String {
    get { return _defaultItemColor.name }
    set {
      _defaultItemColor = TiUtils.colorValue(newValue)
      self.replaceValue(newValue, forKey: "defaultItemColor", notification: false)
    }
  }

  private var _defaultItemTitleColor: TiColor
  @objc public var defaultItemTitleColor: String {
    get { return _defaultItemTitleColor.name }
    set {
      _defaultItemTitleColor = TiUtils.colorValue(newValue)
      self.replaceValue(newValue, forKey: "defaultItemTitleColor", notification: false)
    }
  }

  private var _defaultItemDescriptionColor: TiColor
  @objc public var defaultItemDescriptionColor: String {
    get { return _defaultItemDescriptionColor.name }
    set {
      _defaultItemDescriptionColor = TiUtils.colorValue(newValue)
      self.replaceValue(newValue, forKey: "defaultItemDescriptionColor", notification: false)
    }
  }

  private var _defaultItemTitleFont: WebFont
  @objc public var defaultItemTitleFont: Any? {
    get { return self.value(forUndefinedKey: "defaultItemTitleFont") }
    set {
      _defaultItemTitleFont = TiUtils.fontValue(newValue)
      self.replaceValue(newValue, forKey: "defaultItemTitleFont", notification: false)
    }
  }

  private var _defaultItemDescriptionFont: WebFont
  @objc public var defaultItemDescriptionFont: Any? {
    get { return _defaultItemDescriptionFont }
    set {
      _defaultItemDescriptionFont = TiUtils.fontValue(newValue)
      self.replaceValue(newValue, forKey: "defaultItemDescriptionFont", notification: false)
    }
  }

  @objc public var pageItemRadius: NSNumber

  @objc public var pageItemSelectedRadius: NSNumber

  @objc public var pageItemColor: KrollCallback?

  @objc public var currentIndex: NSNumber {
    return NSNumber(value: (self.view as! TiOnboardingView).onboardingView.currentIndex)
  }

  var items = [OnboardingItemInfo]()

  override init() {
    _defaultItemColor = TiColor(color: UIColor.white, name: "white");
    _defaultItemTitleColor = TiColor(color: UIColor.black, name: "black");
    _defaultItemDescriptionColor = TiColor(color: UIColor.gray, name: "gray")

    _defaultItemTitleFont = WebFont.defaultBold()
    _defaultItemTitleFont.size = 36.0
    _defaultItemDescriptionFont = WebFont.default()
    _defaultItemDescriptionFont.size = 14.0

    pageItemRadius = NSNumber(value: 8)
    pageItemSelectedRadius = NSNumber(value: 22)

    super.init()
  }

  override public func _init(withProperties properties: [AnyHashable : Any]!) {
    guard let onboardingItems = properties["items"] as? NSArray else {
      return
    }

    var stripedProperties = properties
    stripedProperties?["items"] = nil
    super._init(withProperties: stripedProperties)

    for item in (onboardingItems as! [NSDictionary]) {
      guard let informationImageArg = item.value(forKey: "informationImage"), let informationImage = TiUtils.toImage(informationImageArg, proxy: self) else {
        self.throwException("InvalidItemException", subreason: "Could not load information image", location: CODELOCATION)
        return
      }
      guard let pageIconArg = item.value(forKey: "pageIcon"), let pageIcon = TiUtils.toImage(pageIconArg, proxy: self) else {
        self.throwException("InvalidItemException", subreason: "Could not load page icon", location: CODELOCATION)
        return
      }

      items.append(OnboardingItemInfo(
        informationImage: informationImage,
        title: item.value(forKey: "title") as? String ?? "",
        description: item.value(forKey: "description") as? String ?? "",
        pageIcon: pageIcon,
        color: TiUtils.colorValue(item.value(forKey: "color"))?.color ?? _defaultItemColor.color,
        titleColor: TiUtils.colorValue(item.value(forKey: "titleColor"))?.color ?? _defaultItemTitleColor.color,
        descriptionColor: TiUtils.colorValue(item.value(forKey: "descriptionColor"))?.color ?? _defaultItemDescriptionColor.color,
        titleFont: getFont(item.value(forKey: "titleFont"), defaultFont: _defaultItemTitleFont),
        descriptionFont: getFont(item.value(forKey: "descriptionFont"), defaultFont: _defaultItemDescriptionFont)
      ))
    }
  }

  @objc(transitionToIndex:)
  public func transitionToIndex(args: Array<Any>?) {
    guard let args = args, let index = args.first as? NSNumber else {
      return;
    }

    var animated = NSNumber(value: true)
    if args.count > 1 {
      animated = args[1] as? NSNumber ?? animated
    }
    (self.view as! TiOnboardingView).onboardingView.currentIndex(index.intValue, animated: animated.boolValue)
  }

  func getFont(_ value: Any?, defaultFont: WebFont) -> UIFont {
    var font = defaultFont
    if let fontValue = value {
      if fontValue is NSDictionary {
        font = TiUtils.fontValue(fontValue)
      } else if fontValue is NSString {
        font = TiUtils.fontValue(fontValue)
      }
    }
    return font.font()
  }
}

// MARK: PaperOnboardingDelegate

extension TiOnboardingViewProxy : PaperOnboardingDelegate {
  public func onboardingWillTransitonToIndex(_ index: Int) {
    guard let callback = beforeTransition else { return };
    callback.call([index], thisObject: nil)
  }

  public func onboardingDidTransitonToIndex(_ index: Int) {
    guard let callback = afterTransition else { return };
    callback.call([index], thisObject: nil)
  }

  public func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
    // @todo allow additional configuration?
  }
}

// MARK: PaperOnboardingDataSource

extension TiOnboardingViewProxy : PaperOnboardingDataSource {
  public func onboardingItemsCount() -> Int {
    return items.count
  }

  public func onboardingItem(at index: Int) -> OnboardingItemInfo {
    return items[index]
  }

  public func onboardinPageItemRadius() -> CGFloat {
    return CGFloat(pageItemRadius.floatValue)
  }

  public func onboardingPageItemSelectedRadius() -> CGFloat {
    return CGFloat(pageItemSelectedRadius.floatValue)
  }

  public func onboardingPageItemColor(at index: Int) -> UIColor {
    guard let callback = pageItemColor else { return _defaultItemColor.color };
    let result = callback.call([index], thisObject: nil)
    return TiUtils.colorValue(result)?.color ?? _defaultItemColor.color;
  }
}
