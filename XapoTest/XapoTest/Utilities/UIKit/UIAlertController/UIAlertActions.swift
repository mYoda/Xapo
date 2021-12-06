// XapoTest
//    
// Created by Anton Nechayuk ©
// with 🧡 for Xapo in 2021
// 


import Foundation
import UIKit

extension UIAlertAction {
    
    static func ok(_ action: (() -> Void)? = nil) -> UIAlertAction {
        return UIAlertAction(
            title: String.General.ok,
            style: .default,
            handler: action.map { a in { _ in a() } } )
    }
    
    static func cancel(_ action: (() -> Void)? = nil) -> UIAlertAction {
        return UIAlertAction(
            title: String.General.cancel,
            style: .cancel,
            handler: action.map { a in { _ in a() } } )
    }
    
    static func close(_ action: (() -> Void)? = nil) -> UIAlertAction {
        return UIAlertAction(
            title: String.General.close,
            style: .cancel,
            handler: action.map { a in { _ in a() } } )
    }
    
    static func update(_ action: (() -> Void)? = nil) -> UIAlertAction {
        return UIAlertAction(
            title: String.General.update,
            style: .default,
            handler: action.map { a in { _ in a() } } )
    }
    
    static func remove(_ action: (() -> Void)? = nil) -> UIAlertAction {
        return UIAlertAction(
            title: String.General.remove,
            style: .destructive,
            handler: action.map { a in { _ in a() } } )
    }
    
    static func retry(_ action: (() -> Void)? = nil) -> UIAlertAction {
        return UIAlertAction(
            title: String.General.retry,
            style: .default,
            handler: action.map({ a in { _ in a() } })
        )
    }
}
