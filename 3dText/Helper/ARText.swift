//
//  ARText.swift
//  3dText
//
//  Created by Shashank Pandya on 27/04/21.
//



import UIKit
import SceneKit
import ARKit


class ARText:SCNText{
    
    
    override init() {
        super.init()
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    init(text:String,
        font:UIFont,
        color:UIColor,
        depth:CGFloat
        ){
        super.init()
        
        self.string = text
        self.extrusionDepth = depth
        self.font = font
        self.alignmentMode = kCAAlignmentCenter
        self.truncationMode = kCATruncationMiddle
        self.firstMaterial?.isDoubleSided = true
        self.firstMaterial!.diffuse.contents = color
        self.flatness = 0.3
    
    }
    
}
