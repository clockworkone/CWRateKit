//
//  CWRateViewControllerDelegate.swift
//  CWRateKit
//
//  Created by Ilia Aparin on 01.04.2020.
//  Copyright © 2020 Clockwork, LLC. All rights reserved.
//

import Foundation

public protocol CWRateKitViewControllerDelegate {
    func didChange(rate: Int)
    func didDismiss()
    func didSubmit(rate: Int)
}
