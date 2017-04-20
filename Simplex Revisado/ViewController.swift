//
//  ViewController.swift
//  Simplex Revisado
//
//  Created by Angel Emilio Lopez Fernandez on 27/03/17.
//  Copyright © 2017 Angel Emilio Lopez Fernandez. All rights reserved.
//

import Cocoa
var LabelV = [NSTextField]()
var LabelR = [NSTextField]()
var Matriz = [[NSTextField]]()
let NewLabel :NSTextField = NSTextField(frame:CGRect( x: 10 ,y: 10,width: 40,height: 30))


class ViewController: NSViewController {

    @IBOutlet weak var variables: NSTextField!
    @IBOutlet weak var restricciones: NSTextField!
    @IBOutlet weak var buttonOK: NSButton!
    @IBOutlet weak var siguiente: NSButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func bOK(_ sender: Any) {
        var LabelVR = [[NSTextField]](repeating: [NSTextField](repeating: NewLabel, count: variables.integerValue + restricciones.integerValue + 1 ), count: restricciones.integerValue + 1)
        ImprimeLBS(variables.integerValue , rest: restricciones.integerValue + 1, view: view)
        var X = 70
        var Y = 210
        for A in 0..<restricciones.integerValue+1 {
            for B in 0..<variables.integerValue+restricciones.integerValue+1{
                var NewLabel :NSTextField = NSTextField(frame:CGRect( x: X ,y: Y,width: 50,height: 20))
                view.addSubview(NewLabel)
                NewLabel.doubleValue = 0.0
                NewLabel.alignment = NSTextAlignment.center
                NewLabel.drawsBackground = false;
                NewLabel.isBezeled = true
                
                LabelVR[A][B] = NewLabel
                X =  X + 50
            }
            Y -= 20
            X = 70
        }
        var B1 = 1
        var A1 = 1
        for A in 1..<restricciones.integerValue+1 {
            A1 += 1
            for B in variables.integerValue..<variables.integerValue+restricciones.integerValue{
                B1 += 1
                LabelVR[A][B].isEditable = false
                if A1 == B1 {
                    LabelVR[A][B].doubleValue = 1.0
                    LabelVR[A][B].isEditable = false
                }
            }
            B1 = 1
            }
        Matriz = LabelVR
        buttonOK.isHidden = true
        siguiente.isHidden = false
    }
    
    @IBAction func botonSiguiente(_ sender: Any) {
        var P:Int = 0
        var Q:Int = 0
        var CB = Cb(M: Matriz, vari: variables.integerValue)
        var CJ = Cj(M: Matriz, res: restricciones.integerValue)
        var Bm1 = B1(M:Matriz,vari:variables.integerValue,res: restricciones.integerValue)
        var AJ = Aj(M: Matriz, vari: variables.integerValue, res: restricciones.integerValue)
        var b = B(vari:variables.integerValue,res: restricciones.integerValue)
        P = Zj_Cj(CB: CB, BM1: Bm1, CJ: CJ, Aj: AJ, res: restricciones.integerValue)
        var Xb = XB(B1: Bm1, b: b)
        var Tp = TP(B1: Bm1, P: P)
        Q = Minimo(XB: Xb, TP: Tp, P: P)
        Bm1 = NuevaBm1(B1: Bm1, TP: Tp, Q: Q)
        
        
    }


}

