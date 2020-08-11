//
//  ContentView.swift
//  cube
//
//  Created by 4 on 8/11/20.
//  Copyright © 2020 XNO LLC. All rights reserved.
//

import SwiftUI
import SceneKit

struct ContentView: View {
    let cube = CubeView()
    
    var body: some View {
        ZStack {
            Rectangle().foregroundColor(.black)
                .frame(height: 2000)
            cube
                .frame(width: 300, height: 300)
                .onTapGesture(count: 2, perform: { self.cube.resetCube() })
        }
        .statusBar(hidden: true)
        .gesture(DragGesture()
            .onEnded { drag in
                let h = drag.predictedEndTranslation.height
                let w = drag.predictedEndTranslation.width
                if abs(h)/abs(w) > 1 {
                    self.cube.flipCube(up: h > 0)
                } else {
                    self.cube.spinCube(right: w > 0)
                }
            })
    }
}

struct CubeView : UIViewRepresentable {
    let scene = SCNScene()
    let help = SceneHelper()
    let name1 = "cube1"
    let name2 = "cube2"
    let camPos: CGFloat = 2.0

    func makeUIView(context: Context) -> SCNView {
        scene.rootNode.addChildNode(help.makeCamera(pos: SCNVector3(camPos,camPos,camPos), rot: SCNVector3(-36,45,0)))
        scene.rootNode.addChildNode(help.makeAmbiLight())
        scene.rootNode.addChildNode(help.makeBox(name: name1, pos: SCNVector3(0,0,0), size: 1.0, cmfr: 0.03, color: .white))
        scene.rootNode.addChildNode(help.makeBox(name: name2, pos: SCNVector3(0,0,0), size: 0.999, cmfr: 0.0, color: .black))
        scene.background.contents = UIColor.black
        return help.prepSCNView(scene: scene)
    }

    func updateUIView(_ scnView: SCNView, context: Context) {
    }
    
    public func spinCube(right: Bool) {
        let dir: Float = right ? 1.0 : -1.0
        let node1 = scene.rootNode.childNode(withName: name1, recursively: false)
        let node2 = scene.rootNode.childNode(withName: name2, recursively: false)
        let rotateAction = SCNAction.rotate(by: help.dToR(90*dir), around: SCNVector3(0,1,0), duration: 0.35)
        rotateAction.timingMode = .easeInEaseOut
        node1?.runAction(rotateAction)
        node2?.runAction(rotateAction)
    }
    
    public func flipCube(up: Bool) {
        let dir: Float = up ? 1.0 : -1.0
        let node1 = scene.rootNode.childNode(withName: name1, recursively: false)
        let node2 = scene.rootNode.childNode(withName: name2, recursively: false)
        let rotateAction = SCNAction.rotate(by: help.dToR(180*dir), around: SCNVector3(1,0,-1), duration: 0.5)
        rotateAction.timingMode = .easeInEaseOut
        node1?.runAction(rotateAction)
        node2?.runAction(rotateAction)
    }
    
    public func resetCube() {
        let node1 = scene.rootNode.childNode(withName: name1, recursively: false)
        let node2 = scene.rootNode.childNode(withName: name2, recursively: false)
        var rot = abs(node1?.rotation.w ?? 0)
        while rot > 0.5 { rot -= .pi/4 }
        if abs(rot) > 0.001 {
            let rotateAction = SCNAction.rotate(toAxisAngle: SCNVector4(0,0,0,0), duration: 0.3)
            rotateAction.timingMode = .easeInEaseOut
            node1?.runAction(rotateAction)
            node2?.runAction(rotateAction)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
