import SwiftUI
import Kingfisher

struct HeaderView: View {
    
    @State private var isAnimating: Bool = false
    var character: Character
    
    var body: some View {
        VStack(alignment: .center) {
            
            CacheImageView(urlImage: character.image)
                .scaleEffect( isAnimating ? 1 : 0.5)
            
            Text(character.name)
                .font(.system(.title, design: .rounded))
                .bold()
                .padding(.top, 20)
                .padding(.bottom, 10)
                .offset(y: isAnimating ? 0 : -75)
                
            HStack(alignment: .center, spacing: 30) {
                TextTitleView(title: "gender".localized(), value: character.gender)
                TextTitleView(title: "specie".localized(), value: character.species)
                TextTitleView(title: "origin".localized(), value: character.origin.name.toFirstElement())
                TextTitleView(title: "status".localized(), value: character.status)
            }.padding(.bottom, 20)
            .offset(y: isAnimating ? 0 : -75)
            Divider()
        }
        
        .frame(maxWidth: .infinity)
        .onAppear {
            withAnimation(.easeIn(duration: 0.35)) {
                isAnimating = true
            }
        }
    }
}

#if DEBUG
struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(character: MockCharacterDetailView.mockCharacter())
        .previewLayout(.sizeThatFits)
        .padding()
        
    }
}
#endif
