//
//  TextNode.swift
//  3dText
//
//  Created by Shashank Pandya on 27/04/21.
//

import UIKit
import SceneKit
import ARKit

class TextNode: SCNNode {
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(distance:Float, scntext:SCNText, sceneView:ARSCNView, scale:CGFloat){
        super.init()

    
        guard let pointOfView = sceneView.pointOfView else { return }
        
        let mat = pointOfView.transform
        let dir = SCNVector3(-1 * mat.m31, -1 * mat.m32, -1 * mat.m33)
        
        var currentPosition = SCNVector3(pointOfView.position.x, (pointOfView.position.y + 0.2),pointOfView.position.z) + (dir * distance)//pointOfView.position + (dir * distance)
        
        
        self.geometry = scntext
        self.position = currentPosition
        self.simdRotation = pointOfView.simdRotation
        self.setPivot()
        self.scale = SCNVector3(scale, scale, scale)
        
    }
    
    
}
