import SwiftUI
import Kingfisher

struct CacheImageView: View {
    
    var urlImage: String
    
    var body: some View {
        KFImage.url(URL(string: urlImage))
                  .placeholder {
                      Image("no_image")
                          .resizable()
                          .scaledToFill()
                          .frame(width: 150, height: 200)
                  }
                  .loadDiskFileSynchronously()
                  .cacheMemoryOnly()
                  .fade(duration: 0.25)
                  .frame(width: 200, height: 250)
                  .scaledToFill()
                  .cornerRadius(10)
    }
}

struct CacheImageView_Previews: PreviewProvider {
    static var previews: some View {
        CacheImageView(urlImage: "https://rickandmortyapi.com/api/character/avatar/2.jpeg")
    }
}
