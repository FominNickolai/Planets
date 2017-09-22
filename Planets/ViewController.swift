//
//  ViewController.swift
//  Planets
//
//  Created by Fomin Nickolai on 22.09.17.
//  Copyright © 2017 Fomin Nickolai. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(configuration, options: [])
        self.sceneView.autoenablesDefaultLighting = true
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let earth = SCNNode()
        earth.geometry = SCNSphere(radius: 0.2)
        earth.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "EarthDay")
        earth.geometry?.firstMaterial?.specular.contents = #imageLiteral(resourceName: "EarthSpecular")
        earth.geometry?.firstMaterial?.emission.contents = #imageLiteral(resourceName: "EarthEmission")
        earth.geometry?.firstMaterial?.normal.contents = #imageLiteral(resourceName: "EarthNormal")
        earth.position = SCNVector3(0, 0, -1)
        
        self.sceneView.scene.rootNode.addChildNode(earth)
        
        let action = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: 8)
        let forever = SCNAction.repeatForever(action)
        earth.runAction(forever)
        
    }

}

extension Int {
    var degreesToRadians: Double {
        return Double(self) * .pi / 180
    }
}

