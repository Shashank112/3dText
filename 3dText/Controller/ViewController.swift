//
//  ViewController.swift
//  3dText
//
//  Created by Shashank Pandya on 27/04/21.
//



import UIKit
import RealityKit
import ARKit
import SceneKit


class ViewController: UIViewController,ARSCNViewDelegate {

    
    @IBOutlet var sceneView: ARSCNView!
    
    let defaults = UserDefaults.standard
    
    let session = ARSession()
    
    var textNode:SCNNode?
    var textSize:CGFloat = 15
    var textDistance:Float = 10
    var showText : String?
    var sphereGlobal : Sphere?
    var txtNode : TextNode?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupScene()
      
        let fontSize = textSize//CGFloat(defaults.float(forKey: "textFont"))
//        let textDistance = textDistance//defaults.float(forKey: "textDistance")
        let textColor = UIColor.red//defaults.colorForKey(key: "textColor")
        
        let textScn = ARText(text: showText ?? "", font: UIFont .systemFont(ofSize: fontSize), color: textColor, depth: fontSize/10)
        let textNode = TextNode(distance: textDistance/10, scntext: textScn, sceneView: self.sceneView, scale: 1/100.0)
        
        txtNode = textNode
        self.sceneView.scene.rootNode.addChildNode(txtNode!)
        
        let sphere: Sphere = Sphere(distance: textDistance/10, sceneView: self.sceneView, scale: 1/100.0)
        sphereGlobal = sphere
        
        self.sceneView.scene.rootNode.addChildNode(sphereGlobal!)
        
       
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        sceneView.addGestureRecognizer(tapGesture)
    }
    
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupScene() {
        // set up sceneView
        sceneView.delegate = self
        sceneView.session = session
       // sceneView.antialiasingMode = .multisampling4X
        sceneView.automaticallyUpdatesLighting = false
        sceneView.preferredFramesPerSecond = 60
        sceneView.contentScaleFactor = 1.3
        enableEnvironmentMapWithIntensity(25.0)
        
        DispatchQueue.main.async {
            //self.screenCenter = self.sceneView.bounds.mid
        }
        
        if let camera = sceneView.pointOfView?.camera {
            camera.wantsHDR = true
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @objc func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        
        // check what nodes are tapped
        let p = gestureRecognize.location(in: sceneView)
        let hitResults = self.sceneView.hitTest(p, options: [:])
        // check that we clicked on at least one object
        if hitResults.count > 0 {
            // retrieved the first clicked object
            let result: SCNHitTestResult = hitResults[0]
            if let isContain = sphereGlobal?.childNodes.contains(result.node),isContain {
                txtNode?.isHidden = !(txtNode?.isHidden ?? true)
            }
        }
    }
   
    // On back button pop view controller
    @IBAction func onButtonBackClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func enableEnvironmentMapWithIntensity(_ intensity: CGFloat) {
        if sceneView.scene.lightingEnvironment.contents == nil {
            if let environmentMap = UIImage(named: "Models.scnassets/sharedImages/environment_blur.exr") {
                sceneView.scene.lightingEnvironment.contents = environmentMap
            }
        }
        sceneView.scene.lightingEnvironment.intensity = intensity
    }

    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
    }
    
    // MARK: - UIPopoverPresentationControllerDelegate
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        
    }

}


