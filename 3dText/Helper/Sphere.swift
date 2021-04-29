//
//  Sphere.swift
//  3dText
//
//  Created by Shashank Pandya on 27/04/21.
//
 
import Foundation
import ARKit
 
class Sphere: SCNNode {
 
    static let radius: CGFloat = 0.1
 
    let sphereGeometry: SCNSphere
 
    // Required but unused
    required init?(coder aDecoder: NSCoder) {
        sphereGeometry = SCNSphere(radius: Sphere.radius)
        super.init(coder: aDecoder)
    }
 
    // The real action happens here
    init(distance:Float, sceneView:ARSCNView, scale:CGFloat) {
        self.sphereGeometry = SCNSphere(radius: Sphere.radius)
 
        super.init()
 
        let sphereNode = SCNNode(geometry: self.sphereGeometry)
        
        guard let pointOfView = sceneView.pointOfView else { return }
        
        let mat = pointOfView.transform
        let dir = SCNVector3(-1 * mat.m31, -1 * mat.m32, -1 * mat.m33)
        
        var currentPosition = SCNVector3(pointOfView.position.x, (pointOfView.position.y + 0.06),pointOfView.position.z) + (dir * distance)//pointOfView.position + (dir * distance)
        
        
        
        sphereNode.position = currentPosition
 
        self.addChildNode(sphereNode)
    }
 
    func clear() {
        self.removeFromParentNode()
    }
 
}
