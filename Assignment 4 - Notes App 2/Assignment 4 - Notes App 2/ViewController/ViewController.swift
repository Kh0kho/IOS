import UIKit

class ViewController: UIViewController {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var model = [NoteEntity]()
    private var notesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setupNavigationBar()
        setupCollectionView()
        print("Collection view layout: \(notesCollectionView.collectionViewLayout)")
        
        getAllNotes()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Recent Notes"
        navigationController?.navigationBar.backgroundColor = .clear
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "text.alignleft"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(goBack))
        navigationItem.leftBarButtonItem?.tintColor = .systemYellow
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(addButtonHandler))
        navigationItem.rightBarButtonItem?.tintColor = .systemYellow
    }
    
    @objc func goBack() {
        print("Left button tapped")
    }
    
    @objc func addButtonHandler() {
        let noteViewController = NoteViewController(delegate: self, note: nil)
        navigationController?.pushViewController(noteViewController, animated: true)
    }
    
    
    private func setupCollectionView() {
        let layout = CustomLayout()
        layout.delegate = self
        
        notesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        notesCollectionView.backgroundColor = .clear
        notesCollectionView.showsVerticalScrollIndicator = false
        notesCollectionView.delegate = self
        notesCollectionView.dataSource = self
        notesCollectionView.register(NoteCell.self, forCellWithReuseIdentifier: "NoteCell")
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        notesCollectionView.addGestureRecognizer(longPressGesture)
        
        
        view.addSubview(notesCollectionView)
        notesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            notesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            notesCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            notesCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            notesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func handleLongPress(gesture: UILongPressGestureRecognizer) {
        let point = gesture.location(in: self.notesCollectionView)
        if let indexPath = self.notesCollectionView.indexPathForItem(at: point) {
            switch gesture.state {
            case .began:
                showActionSheet(for: indexPath)
            default:
                break
            }
        }
    }
    
    func showActionSheet(for indexPath: IndexPath) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            self.deleteNote(note: self.model[self.model.count - indexPath.item - 1])
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    private func getAllNotes() {
        let request = NoteEntity.fetchRequest()
        
        do {
            model = try context.fetch(request)
            //            notesCollectionView.collectionViewLayout.invalidateLayout()
            notesCollectionView.reloadData()
            DispatchQueue.main.async {
                self.notesCollectionView.collectionViewLayout.invalidateLayout()
                self.notesCollectionView.layoutIfNeeded()
            }
        } catch {
            fatalError("getAllNotes Error")
        }
    }
    
    func createNote(noteHeader: String, noteText: String) {
        let note = NoteEntity(context: context)
        note.noteheader = noteHeader
        note.notetext = noteText
        
        do {
            try context.save()
            getAllNotes()
        } catch {
            fatalError("createNote Error")
        }
    }
    
    func updateNote(note: NoteEntity, noteHeader: String, noteText: String) {
        note.noteheader = noteHeader
        note.notetext = noteText
        
        do {
            try context.save()
            getAllNotes()
        } catch {
            fatalError("updateNote Error")
        }
    }
    
    func deleteNote(note: NoteEntity) {
        context.delete(note)
        do {
            try context.save()
            getAllNotes()
        } catch {
            fatalError("deleteNote Error")
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoteCell", for: indexPath) as! NoteCell
        let note = model[model.count - indexPath.item - 1]
        cell.configure(note: note)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let noteViewController = NoteViewController( delegate: self, note: model[model.count - indexPath.row - 1])
        navigationController?.pushViewController(noteViewController, animated: true)
    }
    
}

extension ViewController: CustomLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, layout: CustomLayout, heightForItemAt indexPath: IndexPath, with width: CGFloat) -> CGFloat {
        let note = model[model.count - indexPath.item - 1]
        let cell = NoteCell()
        cell.configure(note: note)
        let height = cell.calculateHeight(for: width)
        print("Calculated height for item at index \(indexPath.item): \(height)")
        return height
    }
}
