//
//  Brightness Slider.swift
//  CYOATemplate
//
//  Created by Dai Jiaze on 2023-06-05.
//

import UIKit

class ViewController:UIViewController {
    @IBOutlet var slider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func sliderChanged(sender:Any){
        UIScreen.main.brightness = CGFloat(slider.value)
    }
}
