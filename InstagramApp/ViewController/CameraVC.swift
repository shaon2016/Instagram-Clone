//
//  CameraVC.swift
//  InstagramApp
//
//  Created by MacBook Pro  on 30/3/20.
//  Copyright © 2020 Gwinyai Nyatsoka. All rights reserved.
//

import UIKit

class CameraVC: UIViewController {

    @IBOutlet weak var simpleCameraView: SimpleCameraView!
    
    var simpleCamera : SimpleCamera!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        simpleCamera = SimpleCamera(cameraView: simpleCameraView)
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        simpleCamera.startSession()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        simpleCamera.stopSession()
    }

    @IBAction func startCapture(_ sender: Any) {
        
        if simpleCamera.currentCaptureMode == .photo {
            simpleCamera.takePhoto { (image, success) in
                if success {
                    print("Image Success")
                }
            }
        }
    }
}
