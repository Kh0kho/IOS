//
//  NoteViewController.swift
//  Assignment 4 - Notes App 2
//
//  Created by Luka Khokhiashvili on 06.07.24.
//

import UIKit

class NoteViewController: UIViewController {
    private let delegate: ViewController
    private var note: NoteEntity?
    private var noteTextViewBottomConstraint: NSLayoutConstraint?
    private var keyboardHeight: CGFloat = 0
    
    private let headerTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Title"
        textfield.font = .systemFont(ofSize: 22, weight: .bold)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private let noteTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .systemFont(ofSize: 16)
        textView.backgroundColor = .clear
        return textView
    }()
    
    init(delegate: ViewController, note: NoteEntity?) {
        self.delegate = delegate
        self.note = note
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setupNavigationBar()
        setupTitleField()
        setupNoteTextView()
        setupKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            removeKeyboardObservers()
        }
    
    private func setupNavigationBar(){
        navigationItem.title = "Edit Notes"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(goBack))
        navigationItem.leftBarButtonItem?.tintColor = .systemYellow
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(rightButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .systemYellow
        
        
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
        if note != nil {
            delegate.updateNote(note: note!, noteHeader: headerTextField.text ?? "", noteText: noteTextView.text)
        }
        else{
            if headerTextField.text != "" || noteTextView.text != "" {
                delegate.createNote(noteHeader: headerTextField.text ?? "", noteText: noteTextView.text)
            }
        }
    }
    @objc func rightButtonTapped() {
        
    }
    
    private func  setupTitleField(){
        view.addSubview(headerTextField)
        headerTextField.text = note?.noteheader ?? ""
        NSLayoutConstraint.activate([
            headerTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            headerTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            headerTextField.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 1/12)
        ])
    }
    private func setupNoteTextView(){
            view.addSubview(noteTextView)
            noteTextView.text = note?.notetext ?? ""
            noteTextView.showsVerticalScrollIndicator = false
            NSLayoutConstraint.activate([
                noteTextView.topAnchor.constraint(equalTo: headerTextField.bottomAnchor),
                noteTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                noteTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            ])
            
            noteTextViewBottomConstraint = noteTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            noteTextViewBottomConstraint?.isActive = true
        }

        private func setupKeyboardObservers() {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        }

        private func removeKeyboardObservers() {
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        }

        @objc private func keyboardWillShow(notification: NSNotification) {
            if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                keyboardHeight = keyboardRectangle.height

                UIView.animate(withDuration: 0.1) {
                    self.noteTextViewBottomConstraint?.constant = -self.keyboardHeight
                    self.view.layoutIfNeeded()
                }
            }
        }

        @objc private func keyboardWillHide(notification: NSNotification) {
            UIView.animate(withDuration: 0.1) {
                self.noteTextViewBottomConstraint?.constant = 0
                self.view.layoutIfNeeded()
            }
        }
    
    
}
