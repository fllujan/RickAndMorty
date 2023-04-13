import UIKit

protocol CharacterListAdapterManager {
    var arrayData: [Character] { set get }
    func setManagerView(_ collectionView: UICollectionView)
    func checkCharacterNotFound()
}

final class CharacterListAdapter: NSObject, CharacterListAdapterManager {
    
    private weak var delegate: CharacterListViewControllerDelegate?
    private var collectionView: UICollectionView?
    private var reload: Bool = true
    private let noFoundLabel: UILabel = {
        let label = UILabel()
        label.text = "character_not_found".localized()
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var arrayData = [Character]() {
        didSet {
            collectionView?.reloadData()
            reload = true
        }
    }
    
    init(delegate: CharacterListViewControllerDelegate) {
        self.delegate = delegate
    }
    
    func setManagerView(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
        collectionView.addSubview(noFoundLabel)
        noFoundLabel.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        noFoundLabel.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor).isActive = true
        noFoundLabel.isHidden = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func checkCharacterNotFound() {
        noFoundLabel.isHidden = arrayData.count != 0
    }
}

extension CharacterListAdapter: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard arrayData.count >= indexPath.row else { return UICollectionViewCell() }
        return CharacterListCollectionViewCell.buildIn(collectionView, indexPath: indexPath, character: arrayData[indexPath.row])
    }
}

extension CharacterListAdapter: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row == arrayData.count - 1 && reload) {
            reload = false
            delegate?.getMoreCharacters()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        delegate?.selectedCharacter(self.arrayData[indexPath.row])
    }
}
