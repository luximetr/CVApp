//
//  CVDetailsWidget.swift
//  CVDetailsWidget
//
//  Created by Oleksandr Orlov on 12.07.2021.
//  Copyright © 2021 Oleksandr Orlov. All rights reserved.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
  
  private let getCVService = GetNetworkCVWebAPIWorker(session: .shared, requestComposer: URLRequestComposer(baseURL: "https://us-central1-cvapp-8ebd9.cloudfunctions.net"))
  
  func placeholder(in context: Context) -> SimpleEntry {
    SimpleEntry.demo
  }
  
  func getSnapshot(for configuration: SelectCVIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
    let entry = SimpleEntry.demo
    completion(entry)
  }
  
  func getTimeline(for configuration: SelectCVIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
    
    let cvId = configuration.CVDetails?.identifier ?? "userId"
    getCVService.getCVs(
      cvId: cvId,
      completion: { result in
        switch result {
          case .success(let cv):
            let entry = SimpleEntry(
              date: Date(),
              cv: cv,
              configuration: configuration
            )
            let entries = [entry]
            let timeline = Timeline(entries: entries, policy: .after(Date() + TimeInterval(60)))
            completion(timeline)
          case .failure:
            let entry = SimpleEntry(
              date: Date(),
              cv: nil,
              configuration: configuration
            )
            let entries = [entry]
            let timeline = Timeline(entries: entries, policy: .after(Date() + TimeInterval(60)))
            completion(timeline)
        }
      }
    )
  }
}

struct SimpleEntry: TimelineEntry {
  let date: Date
  let cv: CV?
  let configuration: SelectCVIntent
  
  static let demo = SimpleEntry(
    date: Date(),
    cv: CV.getDemoCV(),
    configuration: SelectCVIntent()
  )
}

struct CVDetailsWidgetEntryView : View {
  var entry: Provider.Entry
  
  var body: some View {
    ZStack {
      Color("backgroundColor")
      CVDetailsWidgetSmall(entry: entry)
    }
    .widgetURL(getWidgetURL())
  }
  
  private func getWidgetURL() -> URL? {
    guard let cvId = entry.cv?.id else { return nil }
    let stringURL = "https://heroku-html-buildpack-cvapp.herokuapp.com/cvs/\(cvId)"
    return URL(string: stringURL)
  }
}

@main
struct CVDetailsWidget: Widget {
  let kind: String = "CVDetailsWidget"
  
  var body: some WidgetConfiguration {
    IntentConfiguration(
      kind: kind,
      intent: SelectCVIntent.self,
      provider: Provider()
    ) { entry in
      CVDetailsWidgetEntryView(entry: entry)
    }
    .configurationDisplayName("CV Details")
    .description("Shows details of selected CV.")
    .supportedFamilies([.systemSmall])
  }
}

struct CVDetailsWidgetSmall: View {
  var entry: Provider.Entry
  
  static let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy"
    return formatter
  }()

  var body: some View {
    VStack(alignment: .leading) {
      if let cv = entry.cv {
        Text(cv.userInfo.name)
          .foregroundColor(.primary)
        Text(cv.userInfo.role)
          .foregroundColor(.primary)
          .font(.callout)
        Text(cv.contacts.phones.first ?? "+380551231212")
          .font(.caption)
          .foregroundColor(.blue)
        Spacer()
        if let lastExperience = cv.experience.last {
          Text(lastExperience.companyName)
            .foregroundColor(.secondary)
          Text(createExperienceString(experience: lastExperience))
            .foregroundColor(.secondary)
        }
      } else {
        Text("No data")
          .foregroundColor(.primary)
      }
    }
    .padding()
  }
  
  private func createExperienceString(experience: Experience) -> String {
    return
      Self.dateFormatter.string(from: experience.dateStart) +
      " - now"
  }

}

struct CVDetailsWidget_Previews: PreviewProvider {
  static var previews: some View {
    CVDetailsWidgetEntryView(
      entry: SimpleEntry.demo
    )
    .previewContext(WidgetPreviewContext(family: .systemSmall))
    .colorScheme(.light)
    
    CVDetailsWidgetEntryView(
      entry: SimpleEntry.demo
    )
    .previewContext(WidgetPreviewContext(family: .systemSmall))
    .colorScheme(.dark)
  }
}
