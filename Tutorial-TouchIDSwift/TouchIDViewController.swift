//
//  ViewController.swift
//  Tutorial-TouchIDSwift
//
//  Created by Fernando Medina on 7/30/14.
//  Copyright (c) 2014 Programadores-iOS.net. All rights reserved.
//

import UIKit
import LocalAuthentication

class TouchIDViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func pruebaTouchID(sender: AnyObject) {
        
        var touchIDContext = LAContext()
        var msgError : NSError?
        var alerta = UIAlertController(title:"", message:"", preferredStyle: UIAlertControllerStyle.Alert)
        
        
        if touchIDContext.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &msgError) {
            
            
            touchIDContext.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics,
                localizedReason: "Probando el nuevo TouchID",
                reply: {(success: Bool, error: NSError!) -> Void in
                    
                    if success {
                        alerta.title = "Verificado"
                        alerta.message = "Funciona"
                    } else {
                        alerta.title = "Error"
                        switch error!.code {
                        case LAError.UserCancel.toRaw():
                            alerta.message = "Accion cancelada"
                        case LAError.AuthenticationFailed.toRaw():
                            alerta.message = "Error verificando tu identidad"
                        case LAError.UserFallback.toRaw():
                            alerta.message = "Usuario quiero ingresar passcode"
                        default:
                            alerta.message = "Error genérico"
                        }
                        self.presentViewController(alerta, animated:true, completion:nil)
                        
                    }
                })
            
            
            
        }
        else {
            
            alerta.title = "Nope!"
            switch msgError!.code {
            case LAError.TouchIDNotAvailable.toRaw():
                alerta.message = "Este dispositivo no tiene Touch ID"
            case LAError.TouchIDNotEnrolled.toRaw():
                alerta.message = "No se ha configurado el Touch ID"
            case LAError.PasscodeNotSet.toRaw():
                alerta.message = "No se ha configurado un PassCode"
            default:
                alerta.message = "Error Genérico"
            }
            
            self.presentViewController(alerta, animated:true, completion:nil)
        }

    }

}

