import UIKit
import Kingfisher

final class CharacterListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var title: UILabel!
    
    var character: Character! {
        didSet { self.updateData() }
    }
    
    private func updateData() {
        animationCell()
        imageView.kf.setImage(
            with: URL(string: character.image),
            placeholder: UIImage(named: "no_image"),
            options: [.loadDiskFileSynchronously, .cacheOriginalImage, .transition(.fade(0.25))]
        )
        
        title.text = character.name
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        title.text = nil
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        imageView.layer.cornerRadius = 10
        title.font = UIFont().rounded()
    }
    
    private func animationCell() {
        transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        alpha = 0
        
        UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseInOut]) {
            self.alpha = 1
            self.transform = .identity
        }
    }
}

extension CharacterListCollectionViewCell {
    class func buildIn(_ collectionView: UICollectionView, indexPath: IndexPath, character: Character) -> CharacterListCollectionViewCell {
        guard  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterListCollectionViewCell", for: indexPath) as? CharacterListCollectionViewCell else {
            return CharacterListCollectionViewCell()
        }
        cell.character = character
        return cell
    }
}
