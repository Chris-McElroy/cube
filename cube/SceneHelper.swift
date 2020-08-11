//
//  SceneHelper.swift
//  cube
//
//  Created by 4 on 8/11/20.
//  Copyright © 2020 XNO LLC. All rights reserved.
//

import SceneKit

struct SceneHelper {
    func makeCamera(pos: SCNVector3, rot: SCNVector3) -> SCNNode {
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.camera?.usesOrthographicProjection = true
        cameraNode.position = pos
        cameraNode.eulerAngles.x = dToR(rot.x)
        cameraNode.eulerAngles.y = dToR(rot.y)
        cameraNode.eulerAngles.z = dToR(rot.z)
        return cameraNode
    }
    
    func makeOmniLight() -> SCNNode {
        let omniLightNode = SCNNode()
        omniLightNode.light = SCNLight()
        omniLightNode.light?.type = SCNLight.LightType.omni
        omniLightNode.light?.color = UIColor(white: 1.0, alpha: 1.0)
        omniLightNode.position = SCNVector3(x: 100, y: 250, z: -25)
        omniLightNode.light?.attenuationStartDistance = 1000
        return omniLightNode
    }
    
    func makeAmbiLight() -> SCNNode {
        let ambiLightNode = SCNNode()
        ambiLightNode.light = SCNLight()
        ambiLightNode.light?.type = SCNLight.LightType.ambient
        ambiLightNode.light?.color = UIColor(white: 1.0, alpha: 1.0)
        return ambiLightNode
    }
    
    func makeBox(name: String, pos: SCNVector3, size: CGFloat, cmfr: CGFloat, color: UIColor) -> SCNNode {
        let box = SCNBox(width: size, height: size, length: size, chamferRadius: cmfr)
        let boxNode = SCNNode(geometry: box)
        boxNode.name = name
        boxNode.geometry?.firstMaterial?.diffuse.contents = color
        boxNode.position = pos
        return boxNode
    }
    
    func prepSCNView(scene: SCNScene) -> SCNView {
        let scnView = SCNView()
        scnView.scene = scene
        scnView.allowsCameraControl = false
        scnView.showsStatistics = false
        scnView.backgroundColor = UIColor.systemBackground
        return scnView
    }
    
    func dToR(_ degrees: Float) -> CGFloat {
        return CGFloat(GLKMathDegreesToRadians(degrees))
    }
    
    func dToR(_ degrees: Float) -> Float {
        return GLKMathDegreesToRadians(degrees)
    }
}
