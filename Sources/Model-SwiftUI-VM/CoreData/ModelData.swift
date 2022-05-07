//
//  File.swift
//  
//
//  Created by Joe Maghzal on 5/7/22.
//

import Foundation
import Combine
import CoreData

class ModelData<T: Datable>: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
    var publishedData = CurrentValueSubject<[T], Never>([])
    private let fetchController: NSFetchedResultsController<T.Object>
    override init() {
        let fetchRequest = T.Object.fetchRequest() as! NSFetchRequest<T.Object>
        fetchRequest.sortDescriptors = []
        guard let viewContext = Configurations.shared.managedObjectContext else {
            fatalError("You should set the ViewContext of the Configurations using Configurations.setObjectContext")
        }
        fetchController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: viewContext, sectionNameKeyPath: nil, cacheName: nil)
        super.init()
        fetchController.delegate = self
        do {
            try fetchController.performFetch()
            publishedData.value = fetchController.fetchedObjects?.model() ?? []
        }catch {
            print(String(describing: error))
        }
    }
    deinit {
        print("deinited")
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let data = controller.fetchedObjects as? [T.Object] else {return}
        self.publishedData.value = data.model()
    }
}
