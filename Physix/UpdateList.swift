import SwiftUI

struct UpdateList: View {
    @ObservedObject var store = UpdateStore()
    
    func addUpdate() {
        store.updates.append(Update(image: "quantum", title: "New Item", text: "Text", date: "Jan 1"))
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.updates) { update in
                    NavigationLink(destination: UpdateDetail(update: update)) {
                        HStack {
                            Image(update.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width:80, height: 80)
                                .background(Color.black)
                                .cornerRadius(20)
                                .padding(.trailing, 4)
                            
                            
                            VStack(alignment: .leading, spacing: 8.0) {
                                Text(update.title)
                                    .font(.system(size: 20, weight: .bold))
                                Text(update.text)
                                    .lineLimit(2)
                                    .font(.subheadline)
                                    .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                
                                Text(update.date)
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
                .onDelete{ index in
                    self.store.updates.remove(at: index.first!)
                }
                .onMove{ (source: IndexSet, destination: Int) in
                    self.store.updates.move(fromOffsets: source, toOffset: destination)
                }
            }
            .navigationBarTitle(Text("Updates"))
            .navigationBarItems(leading: Button(action: addUpdate) {
                Text("Add Update")
            }, trailing: EditButton())
        }
    }
}

struct UpdateList_Previews: PreviewProvider {
    static var previews: some View {
        UpdateList()
    }
}

struct Update: Identifiable {
    var id =  UUID()
    var image: String
    var title: String
    var text: String
    var date: String
}

let updateData = [
    Update(image: "relativity", title: "Relativistic mechanics", text: "Quantum mechanics is the branch of physics treating atomic and subatomic systems and their interaction based on the observation that all forms of energy are released in discrete units or bundles called quanta. Remarkably, quantum theory typically permits only probable or statistical calculation of the observed features of subatomic particles, understood in terms of wave functions. The Schrödinger equation plays the role in quantum mechanics that Newton's laws and conservation of energy serve in classical mechanics—i.e., it predicts the future behavior of a dynamic system—and is a wave equation that is used to solve for wavefunctions.", date: "JAN 1"),
    Update(image: "quantum", title: "Quantum mechanics", text: "Quantum mechanics is the branch of physics treating atomic and subatomic systems and their interaction based on the observation that all forms of energy are released in discrete units or bundles called quanta. Remarkably, quantum theory typically permits only probable or statistical calculation of the observed features of subatomic particles, understood in terms of wave functions. The Schrödinger equation plays the role in quantum mechanics that Newton's laws and conservation of energy serve in classical mechanics—i.e., it predicts the future behavior of a dynamic system—and is a wave equation that is used to solve for wavefunctions.", date: "OCT 17"),
    Update(image: "cosmology", title: "Cosmology - Astrophysics", text: "Cosmology studies how the universe came to be, and its eventual fate. It is studied by physicists and astrophysicists.", date: "AUG 27"),
    Update(image: "classical", title: "Classical mechanics", text: "Classical mechanics is a model of the physics of forces acting upon bodies; includes sub-fields to describe the behaviors of solids, gases, and fluids. It is often referred to as Newtonian mechanics after Isaac Newton and his laws of motion. It also includes the classical approach as given by Hamiltonian and Lagrange methods. It deals with the motion of particles and general system of particles.", date: "JUNE 26"),
    Update(image: "thermo", title: "Thermodynamics and statistical mechanics", text: "Thermodynamics studies the effects of changes in temperature, pressure, and volume on physical systems on the macroscopic scale, and the transfer of energy as heat. Historically, thermodynamics developed out of the desire to increase the efficiency of early steam engines.", date: "JUN 11")
]
