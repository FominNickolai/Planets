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
        
        //Sun
        let sun = planet(geometry: SCNSphere(radius: 0.35), diffuse: #imageLiteral(resourceName: "Sun"), position: SCNVector3(0, 0, -1))
        rotatePlanet(planet: sun, degrees: 360, duration: 8)
        
        
        let earthParent = SCNNode()
        earthParent.position = SCNVector3(0, 0, -1)
        rotatePlanet(planet: earthParent, degrees: 360, duration: 14)
        
        let venusParent = SCNNode()
        venusParent.position = SCNVector3(0, 0, -1)
        rotatePlanet(planet: venusParent, degrees: 360, duration: 10)
        
        self.sceneView.scene.rootNode.addChildNode(sun)
        self.sceneView.scene.rootNode.addChildNode(earthParent)
        self.sceneView.scene.rootNode.addChildNode(venusParent)
        
        //Earth
        let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "EarthDay"), specular: #imageLiteral(resourceName: "EarthSpecular"), emission: #imageLiteral(resourceName: "EarthEmission"), normal: #imageLiteral(resourceName: "EarthNormal"), position: SCNVector3(1.2, 0, 0))
        rotatePlanet(planet: earth, degrees: 360, duration: 25)
        
        //Venus
        let venus = planet(geometry: SCNSphere(radius: 0.1), diffuse: #imageLiteral(resourceName: "Venus Day"), emission: #imageLiteral(resourceName: "Venus Emission"), position: SCNVector3(0.7, 0, 0))
        rotatePlanet(planet: venus, degrees: 360, duration: 40)
        
        earthParent.addChildNode(earth)
        venusParent.addChildNode(venus)
        
        
    }
    
    func planet(geometry: SCNGeometry, diffuse: UIImage, specular: UIImage? = nil, emission: UIImage? = nil, normal: UIImage? = nil, position: SCNVector3) -> SCNNode {
        let planet = SCNNode(geometry: geometry)
        planet.geometry?.firstMaterial?.diffuse.contents = diffuse
        planet.geometry?.firstMaterial?.specular.contents = specular
        planet.geometry?.firstMaterial?.emission.contents = emission
        planet.geometry?.firstMaterial?.normal.contents = normal
        planet.position = position
        
        return planet
    }
    
    func rotatePlanet(planet: SCNNode, degrees: Int, duration: Double) {
        let planetRotation = SCNAction.rotateBy(x: 0, y: CGFloat(degrees.degreesToRadians), z: 0, duration: duration)
        let planetForeverRotation = SCNAction.repeatForever(planetRotation)
        planet.runAction(planetForeverRotation)
    }

}

extension Int {
    var degreesToRadians: Double {
        return Double(self) * .pi / 180
    }
}

