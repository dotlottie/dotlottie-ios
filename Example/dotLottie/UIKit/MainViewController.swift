//
//  MainViewController.swift
//  dotLottie_Example
//
//  Created by Evandro Harrison Hoffmann on 03/07/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import SwiftUI

class MainViewController: UIViewController {
    @IBAction func openSwiftUIExamples(_ sender: Any) {
        let viewController = UIHostingController(rootView: ContentView(viewModel: ContentViewModel()))
        present(viewController, animated: true, completion: nil)
    }
}
