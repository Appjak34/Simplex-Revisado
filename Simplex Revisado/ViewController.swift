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
var VC = [NSTextField]()
var MAJ = [[NSTextField]]()
var MI = [[NSTextField]]()
var ME = [[NSTextField]]()
var MBm1 = [[NSTextField]]()
var contador = 0




class ViewController: NSViewController {

    @IBOutlet weak var variables: NSTextField!
    @IBOutlet weak var restricciones: NSTextField!
    @IBOutlet weak var buttonOK: NSButton!
    @IBOutlet weak var siguiente: NSButton!
    @IBOutlet weak var Ptext: NSTextField!
    @IBOutlet weak var Qtext: NSTextField!
    @IBOutlet weak var Ztext: NSTextField!
    @IBOutlet weak var Optimo: NSTextField!
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
        var cont:Int = variables.integerValue
        var cont2:Int = 1
        MI = [[NSTextField]](repeating: [NSTextField](repeating: NewLabel, count:restricciones.integerValue ), count: restricciones.integerValue)

        for A in 0..<Matriz[1].count-variables.integerValue-1 {
            for B in 0..<Matriz.count-1{
                MI[A][B] = Matriz[cont2][cont]
                cont += 1
            }
            cont2 += 1
            cont = variables.integerValue
        }
        buttonOK.isHidden = true
        siguiente.isHidden = false

    }
    
    @IBAction func botonSiguiente(_ sender: Any) {
        if contador == 0 {
            VC = C()
            VC = C2()
            MBm1 = B1(M:Matriz,vari:variables.integerValue,res: restricciones.integerValue)
            MAJ = Aj(M: Matriz, vari: variables.integerValue, res: restricciones.integerValue)
            

        }
        
        var P:Int = 0
        var Q:Int = 0
        var Xb = [NSTextField]()
        var Tp = [NSTextField]()
        var CB = Cb(M: Matriz, vari: variables.integerValue)
        var CJ = Cj(M: Matriz, res: restricciones.integerValue)
        var Bm1 = B1(M:Matriz,vari:variables.integerValue,res: restricciones.integerValue)
        var b = B(vari:variables.integerValue,res: restricciones.integerValue)
        

        

        
        if contador == 0 {
        P = Zj_Cj(CB: CB, BM1: Bm1, CJ: VC, Aj: MAJ, res: restricciones.integerValue)
            Xb = XB(B1: Bm1, b: b)
            Tp = TP(B1: Bm1, P: P)
        }else{
        P = Zj_Cj(CB: CB, BM1: ME, CJ: VC, Aj: MAJ, res: restricciones.integerValue)
            Xb = XB(B1: ME, b: b)
            Tp = TP(B1: ME, P: P)
        }
        
        
        Q = Minimo(XB: Xb, TP: Tp, P: P)
        
        if contador == 0 {
            Bm1 = NuevaBm1(B1: MI, TP: Tp, Q: Q, P: P, vari:variables.integerValue)
            contador = 1
        }else{
            if ChecarZ(CB: CB, E: Bm1, b: VC) == true {
                siguiente.isHidden = true
                Optimo.isHidden = false
            }
            Bm1 = NuevaBm1(B1: MI, TP: Tp, Q: Q, P: P, vari:variables.integerValue)
            otra(XB: Xb, m: Bm1,v: view,res: restricciones.integerValue )
            Bm1 = MEanterior(MAnterior: ME, MBm1: Bm1, vari: variables.integerValue, res: restricciones.integerValue)
        }
        otra(XB: b, m: Bm1, v: view, res: restricciones.integerValue)
   
        CB = NuebaCb(Cb:CB, P:P,Q:Q,M: Matriz)
        ME = Bm1
        
        print(Z(CB: CB, E: Bm1, b: b))
        ImprimeMatriz(M: Bm1, view: view)
        Ptext.intValue = Int32(P + 1)
        Qtext.intValue = Int32(Q + variables.integerValue)
        Ztext.doubleValue = Z(CB: CB, E: Bm1, b: b)
        
        
        
    }


}

