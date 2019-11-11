// FrogogoTestApp
// Created on 09.11.2019
//
// Copyright © 2019 Oleg Mosyagin. All rights reserved.

import UIKit

class BaseViewController: UIViewController {
    // MARK: - Properties
    /**
     This property using to do some common operations with ViewModel
     */
    var commonTypeViewModel:BaseViewModel!
    
    
    
    // MARK: - Lifecycle methods
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        createViewModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStaticContentForDisplay()
        addBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        commonTypeViewModel.viewWillAppearTrigger()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        commonTypeViewModel.viewDidDisappearTrigger()
    }
    
    
    
    // MARK: - Overridden methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.destination is BaseViewController) {
            let destVC = segue.destination as! BaseViewController
            destVC.commonTypeViewModel?.passedObject.value = commonTypeViewModel?.passingObject
        }
    }
    
    
    
    // MARK: - Custom public/internal methods
    /** Override this method to create instance of ViewModel with proper type. Don't call super in child class implementation
     */
    func createViewModel() {
        fatalError("Do not call super in createViewModel() implementation")
    }
    
    /** Override this method to bind reactions for view model's value changes
    */
    func addBindings() {
        
    }
    
    /** Override this method to set all static content on the screen
     No need to call super implementation, it does nothing
     */
    func setStaticContentForDisplay() {
        
    }
    
    
    
    // MARK: - Custom private methods
    
    
    
}
