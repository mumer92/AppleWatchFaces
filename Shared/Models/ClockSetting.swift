//
//  ClockSetting.swift
//  SwissClock
//
//  Created by Mike Hill on 11/12/15.
//  Copyright © 2015 Mike Hill. All rights reserved.
//

//import Cocoa
import SceneKit
import SpriteKit

class ClockSetting: NSObject {
    //model object to hold instances of a clock settings
    
    func applyColorTheme( _ theme: ClockColorTheme) {
        print("using color theme: ", theme.title)
        //set the theme title in case we want to display it in the form
        self.themeTitle = theme.title
        
        //take the them and apply it
        self.clockFaceMaterialName = theme.clockFaceMaterialName
        self.clockCasingMaterialName = theme.clockCasingMaterialName
        
        self.clockFaceSettings?.hourHandMaterialName = theme.hourHandMaterialName
        self.clockFaceSettings?.minuteHandMaterialName = theme.minuteHandMaterialName
        self.clockFaceSettings?.secondHandMaterialName = theme.secondHandMaterialName
        
        for ringSetting in (self.clockFaceSettings?.ringSettings)! {
            let desiredIndex = ringSetting.ringMaterialDesiredThemeColorIndex
            if theme.ringMaterials.indices.contains(desiredIndex) {
                ringSetting.ringMaterialName = theme.ringMaterials[desiredIndex]
            } else {
                ringSetting.ringMaterialName = theme.ringMaterials[0]
            }
        }
        
    }
    
    func applyDecoratorTheme ( _ theme: ClockDecoratorTheme ) {
        print("using face theme: ", theme.title)
        self.decoratorThemeTitle = theme.title
        
        self.clockFaceSettings?.applyDecoratorTheme( theme )
    }
    
    func toJSONData() -> Data? {
        let settingsDict = self.serializedSettings()
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: settingsDict, options: JSONSerialization.WritingOptions.prettyPrinted)
            return jsonData
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    func toJSON() -> JSON? {
        let settingsDict = self.serializedSettings()
        //let settingsData = NSKeyedArchiver.archivedDataWithRootObject(settingsDict)
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: settingsDict, options: JSONSerialization.WritingOptions.prettyPrinted)
            let jsonObj = try! JSON(data: jsonData)
            return jsonObj
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    func clone() -> ClockSetting? {
        // use JSON to clone it cause, you know , you can!
        
        let settingsDict = self.serializedSettings()
        //let settingsData = NSKeyedArchiver.archivedDataWithRootObject(settingsDict)
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: settingsDict, options: JSONSerialization.WritingOptions.prettyPrinted)
            let jsonObj = try! JSON(data: jsonData)
            
            if jsonObj != JSON.null {
                return ClockSetting.init(jsonObj: jsonObj)
            } else {
                print("could not get json from clone, make sure that contains valid json.")
            }
        } catch let error as NSError {
            print(error)
        }
        
        print("could not get json from clone, make sure that contains valid json.")
        return nil
    }
    
    // housing types
    var housingType:HousingTypes?
    
    // face settings
    var clockFaceSettings:ClockFaceSetting?
    
    var title:String
    var themeTitle:String
    var decoratorThemeTitle:String
    
    var clockFaceMaterialName:String
    var clockCasingMaterialName:String
    
    init(clockFaceMaterialName: String,
        housingType: HousingTypes,
        
        clockCasingMaterialName: String,
        
        clockFaceSettings: ClockFaceSetting,
        title: String)
    {
        self.clockFaceMaterialName = clockFaceMaterialName
        self.housingType = housingType
        self.clockFaceSettings = clockFaceSettings
        self.title = title
        self.clockCasingMaterialName = clockCasingMaterialName
        self.themeTitle = ""
        self.decoratorThemeTitle = ""
        
        super.init()
    }
    
//    static func settingsByName( settingsName: String) -> ClockSetting {
//        let allSettings = self.allSettings()
//        
//        let theSetting = allSettings[settingsName]
//        
//        return theSetting!
//    }
    
    static func defaults() -> ClockSetting {
        return ClockSetting.init(
            clockFaceMaterialName: "#FFFFFFFF",
            housingType: HousingTypes.HousingTypeTableBell,
            
            clockCasingMaterialName: "#FF0000FF",
            
            clockFaceSettings: ClockFaceSetting.defaults(),
            title: ""
        )
    }
    
    func randomize( newColors: Bool, newScene: Bool, newFace: Bool ) {
//        if (newScene) {
//            self.housingType = HousingTypes.random()
//        }
//        if (newFace) {
//            self.applyDecoratorTheme(UserClockSetting.randomDecoratorTheme())
//        }
//        if (newColors) {
//            self.applyColorTheme(UserClockSetting.randomColorTheme())
//        }
//    
//        self.setTitleForRandomClock()
    }
    
//    static func random() -> ClockSetting {
//
//        let housingType = HousingTypes.random()
//        let clockSetting = ClockSetting.init(
//            clockFaceMaterialName: "#FFFFFFFF",
//            housingType: housingType,
//
//            clockCasingMaterialName: "#FF0000FF",
//
//            clockFaceSettings: ClockFaceSetting.random(),
//            title: "random"
//        )
//
//        //add a random theme
//        let randoDecoTheme = UserClockSetting.randomDecoratorTheme() //UserClockSetting.sharedDecoratorThemeSettings[1]
//        clockSetting.applyDecoratorTheme(randoDecoTheme)
//
//        //add a random theme
//        let randoTheme =  UserClockSetting.randomColorTheme() //UserClockSetting.sharedColorThemeSettings[0]
//        clockSetting.applyColorTheme(randoTheme)
//
//        clockSetting.setTitleForRandomClock()
//
//        return clockSetting
//    }
    
    //init from serialized
    convenience init( jsonObj: JSON ) {
        
        let housingType = HousingTypes(rawValue: jsonObj["housingType"].stringValue)!
        
        self.init(
            clockFaceMaterialName: jsonObj["clockFaceMaterialName"].stringValue,
            housingType: housingType,
            
            clockCasingMaterialName: jsonObj["clockCasingMaterialName"].stringValue,
            
            clockFaceSettings: ClockFaceSetting.init(jsonObj: jsonObj["clockFaceSettings"]),
            title: jsonObj["title"].stringValue
        )
    
    }
    
//    func setTitleForRandomClock() {
//        self.title = "randomClock-" + String.random(20)
//    }
//
//    func uniqueID() -> String {
//        let okayChars : Set<Character> =
//            Set("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890".characters)
//        return String(self.title.characters.filter {okayChars.contains($0) })
//    }
    
    //returns a JSON serializable safe version ( 
    
    /*
    - Top level object is an NSArray or NSDictionary
    - All objects are NSString, NSNumber, NSArray, NSDictionary, or NSNull
    - All dictionary keys are NSStrings
    */
    
    //floats to a string (description) feels safest since we have cross platform floats w/ NSNumber to worry about

    func serializedSettings() -> NSDictionary {
        var serializedDict = [String:AnyObject]()
        
        serializedDict[ "title" ] = self.title as AnyObject
        serializedDict[ "clockFaceMaterialName" ] = self.clockFaceMaterialName as AnyObject
        serializedDict[ "housingType" ] = self.housingType?.rawValue as AnyObject
        serializedDict[ "clockFaceSettings" ] = self.clockFaceSettings!.serializedSettings()
        
        serializedDict[ "clockCasingMaterialName" ] = self.clockCasingMaterialName as AnyObject
        
        
        return serializedDict as NSDictionary
    }

}

//TODO: Delete this once its not needed anymore
enum HousingTypes: String {
    case HousingTypePreview, HousingTypeRail, HousingTypeWall, HousingTypeBall, HousingTypeGrandfather, HousingTypeTableBell, HousingTypeSquare,
    HousingTypeFireWorks, HousingTypePushButton, HousingTypeWood, HousingTypeRecord, HousingTypeBoxy, HousingTypeArtDeco
    
    static let randomizableValues = [HousingTypeRail, HousingTypeWall, HousingTypeBall, HousingTypeTableBell, HousingTypeSquare, HousingTypeFireWorks, HousingTypePushButton, HousingTypeWood, HousingTypeRecord, HousingTypeBoxy]
    static let userSelectableValues = [HousingTypeRail, HousingTypeWall, HousingTypeBall, HousingTypeGrandfather, HousingTypeTableBell, HousingTypeSquare, HousingTypeFireWorks, HousingTypePushButton, HousingTypeWood, HousingTypeRecord, HousingTypeBoxy]
    
    static func random() -> HousingTypes {
        let randomIndex = Int(arc4random_uniform(UInt32(randomizableValues.count)))
        return randomizableValues[randomIndex]
    }
}
