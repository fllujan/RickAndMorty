import SwiftUI

struct DetailView: View {
    
    var character: Character
    var episodes: [Episode]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading) {
                HeaderView(character: character)
                
                Text("episodes".localized())
                    .font(.system(.title, design: .rounded))
                    .bold()
                    .padding(.top, 20)
                    .padding(.bottom, 25)
                
                ForEach(episodes) { episode in
                    EpisodeView(episode: episode)
                }
            }
            .padding()
        }
    }
}

#if DEBUG
struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(character: MockCharacterDetailView.mockCharacter(),
                   episodes: [MockCharacterDetailView.mockEpisode()]
        )
    }
}
#endif
