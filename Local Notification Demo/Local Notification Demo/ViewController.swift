//
//  ViewController.swift
//  Local Notification Demo
//
//  Created by Sarika scc on 28/11/22.
//

import UIKit
import MediaPlayer


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        MPVolumeView.setVolume(0.0)
    }
   
}

extension MPVolumeView {
    static func setVolume(_ volume: Float) {
        let volumeView = MPVolumeView()
        let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
            slider?.value = volume
        }
    }
}


