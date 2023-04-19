//
//  AddProductViewController.swift
//  StoreApp
//
//  Created by Asadullah Behlim on 17/04/23.
//

import Foundation
import UIKit
import SwiftUI

enum AddProductTextFieldType: Int {
    case title
    case price
    case imageUrl
}

struct AddProductFormState {
    var title: Bool = false
    var price: Bool = false
    var imageUrl: Bool = false
    var description: Bool = false
    
    var isValid:Bool {
        title && price && imageUrl && description
    }
}

class AddProductViewController: UIViewController {
    
    private var selectedCategory: CategoryModel?
    private var addProductFormState = AddProductFormState()
    
    lazy var titleTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Enter title"
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textfield.leftViewMode = .always
        textfield.borderStyle = .roundedRect
        textfield.tag = AddProductTextFieldType.title.rawValue
        textfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textfield
    }()
    
    lazy var priceTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Enter price (Numbers only)"
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textfield.leftViewMode = .always
        textfield.borderStyle = .roundedRect
        textfield.keyboardType = .numberPad
        textfield.tag = AddProductTextFieldType.price.rawValue
        return textfield
    }()
    
    lazy var imageURLTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Enter image url"
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textfield.leftViewMode = .always
        textfield.borderStyle = .roundedRect
        textfield.tag = AddProductTextFieldType.imageUrl.rawValue
        return textfield
    }()
    
    lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.contentInsetAdjustmentBehavior = .automatic
        textView.backgroundColor = UIColor.lightGray
        textView.delegate = self
        return textView
    }()
    
    lazy var categoryPickerView: CategoryPickerView = {
        let pickerView = CategoryPickerView { [weak self] category in print(category)
            self?.selectedCategory = category
        }
        return pickerView
    }()
    
    @objc func textFieldDidChange (_ sender: UITextField) {
        guard let text = sender.text else {
            return
        }
        switch sender.tag {
        case  AddProductTextFieldType.title.rawValue:
            addProductFormState.title = !text.isEmpty
            
        case AddProductTextFieldType.price.rawValue:
            addProductFormState.price = !text.isEmpty && text.isNumeric
            
            
        case AddProductTextFieldType.imageUrl.rawValue:
            addProductFormState.imageUrl = !text.isEmpty
        default:
            break
        }
        
        saveBarButtonItem.isEnabled = addProductFormState.isValid
    }
    
    lazy var saveBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonPressed))
        return barButtonItem
    }()
    
    @objc func saveButtonPressed(_ sender: UIBarButtonItem) {
        
    }
    
    lazy var cancelBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonPressed))
        barButtonItem.isEnabled = false
        return barButtonItem
    }()
    
    @objc func cancelButtonPressed(_ sender : UIBarButtonItem ) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.leftBarButtonItem = cancelBarButtonItem
        navigationItem.rightBarButtonItem = saveBarButtonItem
        setupUI()
    }
    
    private func setupUI() {
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        
        stackView.addArrangedSubview(titleTextField)
        stackView.addArrangedSubview(priceTextField)
        stackView.addArrangedSubview(descriptionTextView)
        
        // category Picker
        let hostingController = UIHostingController(rootView: categoryPickerView)
        stackView.addArrangedSubview(hostingController.view)
        addChild(hostingController)
        hostingController.didMove(toParent: self)
        
        stackView.addArrangedSubview(imageURLTextField)

        view.addSubview(stackView)
        
        
        // add constraints
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        descriptionTextView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
}

struct AddProductViewControllerRepresentable: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        UINavigationController(rootViewController: AddProductViewController())
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

struct AddProductViewController_Previews: PreviewProvider {
    static var previews: some View {
        AddProductViewControllerRepresentable()
    }
}

extension AddProductViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView){
        addProductFormState.description = !textView.text.isEmpty
        saveBarButtonItem.isEnabled = addProductFormState.isValid
    }
}
