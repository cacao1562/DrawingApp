//
//  ViewController.swift
//  DrawingApp
//
//  Created by hwan ung Yu on 2021/03/04.
//

import UIKit
import PencilKit

class ViewController: UIViewController, PKCanvasViewDelegate, PKToolPickerObserver {
    
    @IBOutlet weak var btnCamera: UIBarButtonItem!
    @IBOutlet weak var btnPencil: UIBarButtonItem!
    @IBOutlet weak var canvasView: PKCanvasView!
    
    let canvasWidth: CGFloat = 760
    let canvvasOverScrollHeight: CGFloat = 500
    
    var drawing = PKDrawing()
    var toolPicker: PKToolPicker!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        canvasView.delegate = self
        canvasView.drawing = drawing
        canvasView.alwaysBounceVertical = true
        canvasView.drawingPolicy = .anyInput
        
        if #available(iOS 14.0, *) {
            toolPicker = PKToolPicker()
        } else {
            // Set up the tool picker, using the window of our parent because our view has not
            // been added to a window yet.
            let window = parent?.view.window
            toolPicker = PKToolPicker.shared(for: window!)
        }
        
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        toolPicker.addObserver(self)
        canvasView.becomeFirstResponder()
        
    }

    /// Hide the home indicator, as it will affect latency.
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }

    @IBAction func saveToAlbum(_ sender: Any) {
    }
    
}

