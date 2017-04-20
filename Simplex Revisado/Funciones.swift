//
//  Funciones.swift
//  Simplex Revisado
//
//  Created by Angel Emilio Lopez Fernandez on 27/03/17.
//  Copyright © 2017 Angel Emilio Lopez Fernandez. All rights reserved.
//

import Foundation
import Cocoa

func ImprimeLBS(_ vari: Int,rest: Int, view: NSView){
    var res = vari
   
    var X: CGFloat = 70.0
    var Y: CGFloat = 230.0
    for A in 0..<vari {
        var NewLabel :NSTextField = NSTextField(frame:CGRect( x: X ,y: Y,width: 50,height: 20))
        view.addSubview(NewLabel)
        NewLabel.stringValue = "X" + String(A+1)
        NewLabel.alignment = .center
        NewLabel.isEditable = false
        NewLabel.drawsBackground = false;
        NewLabel.isBezeled = false

        LabelV.append(NewLabel)
        X = LabelV[A].frame.origin.x + 50
    }
    X = 30.0
    Y = 207.0
    for A in 0..<rest {
        if A == 0 {
            var NewLabel :NSTextField = NSTextField(frame:CGRect( x: X ,y: Y,width: 40,height: 20))
            view.addSubview(NewLabel)
            NewLabel.stringValue = "Z"
            NewLabel.alignment = .center
            NewLabel.isEditable = false
            NewLabel.drawsBackground = false;
            NewLabel.isBezeled = false
            
            LabelR.append(NewLabel)
            Y = LabelR[A].frame.origin.y - 20
        }else{
            res += 1
            var NewLabel :NSTextField = NSTextField(frame:CGRect( x: X ,y: Y,width: 40,height: 20))
            view.addSubview(NewLabel)
            NewLabel.stringValue = "X" + String(res)
            NewLabel.alignment = .center
            NewLabel.isEditable = false
            NewLabel.drawsBackground = false;
            NewLabel.isBezeled = false
        
            LabelR.append(NewLabel)
            Y = LabelR[A].frame.origin.y - 20
        }
    }
    
    
    

}
func Zj_Cj(CB:[NSTextField], BM1:[[NSTextField]],CJ:[NSTextField],Aj:[[NSTextField]], res:Int ) -> Int {
    var Aux = [NSTextField]()
    var Aux2 = [NSTextField]()
    

    for A in 0..<CB.count {
        let NewLabel2 :NSTextField = NSTextField(frame:CGRect( x: 10 ,y: 10,width: 40,height: 30))
        NewLabel2.doubleValue = 0
        for B in 0..<BM1[0].count {
            
            NewLabel2.doubleValue = (CB[A].doubleValue * BM1[A][B].doubleValue) + NewLabel2.doubleValue
        }
        Aux.append(NewLabel2)
    }
    
    for A in 0..<Aj[0].count {
        let NewLabel2 :NSTextField = NSTextField(frame:CGRect( x: 10 ,y: 10,width: 40,height: 30))
        NewLabel2.doubleValue = 0
        for B in 0..<CB.count {
            NewLabel2.doubleValue = Aux[B].doubleValue * Aj[B][A].doubleValue + NewLabel2.doubleValue
        }
        Aux2.append(NewLabel2)
    }
    
    Aux.removeAll()
    
    for A in 0..<Aux2.count {
        let NewLabel2 :NSTextField = NSTextField(frame:CGRect( x: 10 ,y: 10,width: 40,height: 30))
        NewLabel2.doubleValue = 0
        NewLabel.doubleValue = (Aux2[A].doubleValue + CJ[A].doubleValue)
        Aux.append(NewLabel)
    }
    
    let numbersLength = Aux.count
    for i in 0 ..< numbersLength {
        for j in 1 ..< numbersLength-i {
            if Aux[j-1].doubleValue > Aux[j].doubleValue {
                var swap = Aux[j-1]
                Aux[j-1] = Aux[j]
                Aux[j] = swap
            }
        }
    }
    let valor: Double = Aux[0].doubleValue
    var P:Int = 0
    for A in 0..<Matriz[0].count-res-1 {
        if valor == Matriz[0][A].doubleValue {
            P = A
            return P
        }
    }
return P
}

func B(vari:Int, res:Int) -> [NSTextField] {
    var B1 = [NSTextField]()
    for A in 1..<Matriz.count {
        for B in vari + res..<Matriz[0].count {
            B1.append(Matriz[A][B])
        }
    }
    return B1
}

func XB(B1:[[NSTextField]],b:[NSTextField]) -> [NSTextField] {
    var XB = [NSTextField] ()
    for A in 0..<b.count {
        let NewLabel2 :NSTextField = NSTextField(frame:CGRect( x: 10 ,y: 10,width: 40,height: 30))
        NewLabel2.doubleValue = 0
        for B in 0..<B1.count {
            NewLabel2.doubleValue = (b[B].doubleValue * B1[A][B].doubleValue) + NewLabel2.doubleValue
        }
        XB.append(NewLabel2)
    }
    
    return XB
}

func Minimo(XB:[NSTextField], TP:[NSTextField],P:Int) -> Int {
    var Q:Int = 0
    var Aux = [NSTextField]()
    
    for A in 0..<TP.count {
        let NewLabel2 :NSTextField = NSTextField(frame:CGRect( x: 10 ,y: 10,width: 40,height: 30))
        NewLabel2.doubleValue = 0
        NewLabel2.doubleValue = XB[A].doubleValue/TP[A].doubleValue
        Aux.append(NewLabel2)
    }
    
    let numbersLength = Aux.count
    for i in 0 ..< numbersLength {
        for j in 1 ..< numbersLength-i {
            if Aux[j-1].doubleValue > Aux[j].doubleValue {
                var swap = Aux[j-1]
                Aux[j-1] = Aux[j]
                Aux[j] = swap
            }
        }
    }
    
    let valor: Double = Aux[0].doubleValue
    for A in 1..<Matriz[0].count {
        if valor == (XB[A-1].doubleValue/TP[A-1].doubleValue) {
            Q = A
            return Q
        }
    }
    return Q
}

func TP(B1:[[NSTextField]],P:Int) -> [NSTextField] {
    var Tp = [NSTextField]()
    for A in 1..<Matriz.count {
        let NewLabel2 :NSTextField = NSTextField(frame:CGRect( x: 10 ,y: 10,width: 40,height: 30))
        NewLabel2.doubleValue = 0
        for B in 0..<B1.count {
            NewLabel2.doubleValue = (Matriz[A][P].doubleValue * B1[A-1][B].doubleValue) + NewLabel2.doubleValue
        }
        Tp.append(NewLabel2)
        print(Tp[A-1].doubleValue)
    }
    
    return Tp
    
    
}

func NuevaBm1(B1:[[NSTextField]],TP:[NSTextField],Q:Int) -> [[NSTextField]] {
    var NuevaB1: [[NSTextField]] = B1
    var AuxTP:[NSTextField] = TP
    var Tj = 1/TP[Q-1].doubleValue
    
    for A in 0..<AuxTP.count {
        if A == Q-1 {
            AuxTP[A].doubleValue = Tj
        }else{
        AuxTP[A].doubleValue = AuxTP[A].doubleValue * -Tj
        }
    }
    
    for A in 0..<B1.count {
        NuevaB1[A][Q-1] = AuxTP[A]
    }
    for a in 0..<NuevaB1.count {
        for b in 0..<NuevaB1.count {
            print(NuevaB1[a][b].doubleValue)
        }
    }
    return NuevaB1
    
}

func Cb(M:[[NSTextField]],vari: Int) -> [NSTextField] {
    var Cb = [NSTextField]()
    for A in vari..<M[0].count-1 {
        Cb.append(M[0][A])
    }
    return Cb
}

func Cj(M:[[NSTextField]],res: Int) -> [NSTextField] {
    var Cb = [NSTextField]()
    for A in 0..<M[0].count-res-1 {
        Cb.append(M[0][A])
    }
    return Cb
}

func B1(M:[[NSTextField]],vari:Int,res: Int) -> [[NSTextField]] {
    var B1 = [[NSTextField]](repeating: [NSTextField](repeating: NewLabel, count:res ), count: res)
    var cont:Int = vari
    var cont2:Int = 1
    for A in 0..<M[1].count-vari-1 {
        for B in 0..<M.count-1{
          B1[A][B] = M[cont2][cont]
            cont += 1
        }
        print("\n")
        cont2 += 1
        cont = vari
    }
    
    return B1
}

func Aj(M:[[NSTextField]],vari:Int,res: Int) -> [[NSTextField]] {
    var Aj = [[NSTextField]](repeating: [NSTextField](repeating: NewLabel, count:vari ), count: res)
    var cont:Int = 0
    var cont2:Int = 0
    for A in 1..<M.count-1 {
        for B in 0..<M[1].count-res-1{
            Aj[cont2][B] = M[A][B]
            cont += 1
        }
        print("\n")
        cont2 += 1
        cont = 0
    }
    
    return Aj
}


func MenorEjeX(res:Int,CB:[Double],B1:[Double],Cj:[Double]) -> Int{
    var AuxM = Matriz[0]
    var auxmenor = 0
    for i in 0 ..< AuxM.count-res-1 {
        print(AuxM[i].doubleValue)
    }
    let numbersLength = Matriz[0].count-res-1
    for i in 0 ..< numbersLength {
        for j in 1 ..< numbersLength-i {
            if AuxM[j-1].doubleValue > AuxM[j].doubleValue {
                let swap = AuxM[j-1]
                AuxM[j-1] = AuxM[j]
                AuxM[j] = swap
            }
        }
    }
    for i in 0 ..< AuxM.count-res-1 {
        print(AuxM[i].doubleValue)
    }
    let menor:Double = AuxM[0].doubleValue
    for i in 0 ..< numbersLength {
        if menor == Matriz[0][i].doubleValue{
            auxmenor = i
            return auxmenor
        }
    }
    return auxmenor
}

func MenorEjeY(ejeX:Int, res:Int){

}
