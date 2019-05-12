//
//  FaceLayerShapeTableViewCell.swift
//  AppleWatchFaces
//
//  Created by Michael Hill on 5/5/19
//  Copyright © 2018 Michael Hill. All rights reserved.
//

import UIKit

class FaceLayerShapeTableViewCell: FaceLayerTableViewCell {

    @IBOutlet var colorButton: UIButton!
    @IBOutlet var materialSegment: UISegmentedControl!
    @IBOutlet var totalNumbersSegment: UISegmentedControl!
    @IBOutlet var valueSlider: UISlider!
    
    let settingTypeString = "shapeRing"
    
    @IBAction func colorButtonTapped( colorButton: UIButton, event: UIEvent) {
        super.handleColorButton( colorButton: colorButton, event: event, settingType: settingTypeString )
    }
    
//    func shapeChosen( shapeType: FaceIndicatorTypes ) {
//        //debugPrint("fontChosen" + NumberTextNode.descriptionForType(textType))
//
//        let faceLayerSetting = myFaceLayer()
//        faceLayerSetting.
//        self.titleLabel.text = titleText(clockRingSetting: clockRingSetting)
//
//        NotificationCenter.default.post(name: DecoratorPreviewController.ringSettingsChangedNotificationName, object: nil,
//                                        userInfo:["settingType":"indicatorType" ])
//    }
//
//    @IBAction func editShape(sender: UIButton ) {
//        self.selectThisCell()
//
//        NotificationCenter.default.post(name: DecoratorPreviewController.ringSettingsEditDetailNotificationName, object: nil,
//                                        userInfo:["settingType":"indicatorType", "decoratorShapeTableViewCell":self ])
//    }
//
//    @IBAction func totalSegmentDidChange(sender: UISegmentedControl ) {
//        self.selectThisCell()
//
//        let clockRingSetting = myClockRingSetting()
//        clockRingSetting.ringPatternTotal = Int(ClockRingSetting.ringTotalOptions()[sender.selectedSegmentIndex])!
//        clockRingSetting.ringPattern = [1] // all on for now
//        NotificationCenter.default.post(name: DecoratorPreviewController.ringSettingsChangedNotificationName, object: nil,
//                                        userInfo:["settingType":"ringPatternTotal" ])
//    }
//
//    @IBAction func segmentDidChange(sender: UISegmentedControl ) {
//        self.selectThisCell()
//
//        //debugPrint("segment value:" + String( sender.selectedSegmentIndex ) )
//        let clockRingSetting = myClockRingSetting()
//        clockRingSetting.ringMaterialDesiredThemeColorIndex = sender.selectedSegmentIndex
//        NotificationCenter.default.post(name: DecoratorPreviewController.ringSettingsChangedNotificationName, object: nil,
//                                        userInfo:["settingType":"ringMaterialDesiredThemeColorIndex" ])
//    }
    
    @IBAction func sliderValueDidChange(sender: UISlider ) {
        let faceLayer = myFaceLayer()
        guard let shapeOptions = faceLayer.layerOptions as? ShapeLayerOptions else { return }
        
        let roundedValue = Float(round(50*sender.value)/50)
        if roundedValue != shapeOptions.indicatorSize {
            self.selectThisCell()
            debugPrint("slider value:" + String( roundedValue ) )
            shapeOptions.indicatorSize = roundedValue
            let layerIndex = myLayerIndex() ?? 0
            NotificationCenter.default.post(name: SettingsViewController.settingsChangedNotificationName, object: nil,
                                            userInfo:["settingType":settingTypeString ,"layerIndex":layerIndex])
        }
    }
    
    override func setupUIForFaceLayer(faceLayer: FaceLayer) {
        super.setupUIForFaceLayer(faceLayer: faceLayer)
        
        setupButtonBackgroundForColors(button: colorButton)
        
        valueSlider.minimumValue = AppUISettings.ringSettigsSliderShapeMin
        valueSlider.maximumValue = AppUISettings.ringSettigsSliderShapeMax
        
        if let shapeOptions = faceLayer.layerOptions as? ShapeLayerOptions {
            valueSlider.value = shapeOptions.indicatorSize
//            let totalString = String(shapeOptions.patternTotal)
//            if let segmentIndex = ShapeLayerOptions.ringTotalOptions().index(of: totalString) {
//                self.totalNumbersSegment.selectedSegmentIndex = segmentIndex
//            }
        }
            
//
//        self.materialSegment.selectedSegmentIndex = clockRingSetting.ringMaterialDesiredThemeColorIndex
//

        
    }

    
}
