import UIKit

protocol CharacterListApapterProtocol {
    var arrayData: [Character] { set get }
    var reload: Bool { set get }
    func setCollectionView(_ collectionView: UICollectionView)
}

class CharacterListAdapter: NSObject, CharacterListApapterProtocol {
    
    private weak var controller: CharacterListViewControllerProtrocol?
    
    var arrayData = [Character]()
    var reload: Bool = true
    
    init(controller: CharacterListViewControllerProtrocol) {
        self.controller = controller
    }
    
    func setCollectionView(_ collectionView: UICollectionView) {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension CharacterListAdapter: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        CharacterListCollectionViewCell.buildIn(collectionView, indexPath: indexPath, character: arrayData[indexPath.row])
    }
    
}

extension CharacterListAdapter: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row == arrayData.count - 1 && reload) {
            controller?.getMoreCharacters()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        controller?.goToDetail(self.arrayData[indexPath.row])
    }

}
