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
  
  private let getCVService = GetNetworkCVsWebAPIWorker(session: .shared, requestComposer: URLRequestComposer(baseURL: "https://us-central1-cvapp-8ebd9.cloudfunctions.net"))
  
  func placeholder(in context: Context) -> SimpleEntry {
    SimpleEntry.demo
  }
  
  func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
    let entry = SimpleEntry.demo
    completion(entry)
  }
  
  func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
    
    getCVService.getCVs(authToken: "userId") { result in
      switch result {
        case .success(let cvs):
          let entries = cvs.map {
            SimpleEntry(
              date: Date(),
              cv: $0,
              configuration: configuration
            )
          }
          let timeline = Timeline(entries: entries, policy: .after(Date() + TimeInterval(60)))
          completion(timeline)
        case .failure(let data): print(data)
      }
    }
  }
}

struct SimpleEntry: TimelineEntry {
  let date: Date
  let cv: CV
  let configuration: ConfigurationIntent
  
  static let demo = SimpleEntry(
    date: Date(),
    cv: CV.getDemoCV(),
    configuration: ConfigurationIntent()
  )
}

struct CVDetailsWidgetEntryView : View {
  var entry: Provider.Entry
  
  var body: some View {
    ZStack {
      Color("backgroundColor")
      CVDetailsWidgetSmall(entry: entry)
    }
  }
}

@main
struct CVDetailsWidget: Widget {
  let kind: String = "CVDetailsWidget"
  
  var body: some WidgetConfiguration {
    IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
      CVDetailsWidgetEntryView(entry: entry)
    }
    .configurationDisplayName("CV Details")
    .description("Shows details of selected CV.")
    .supportedFamilies([.systemSmall])
  }
}

struct CVDetailsWidgetSmall: View {
  var entry: Provider.Entry

  var body: some View {
    VStack {
      Text(entry.cv.userInfo.name)
        .foregroundColor(.primary)
      Text(entry.cv.userInfo.role)
        .foregroundColor(.primary)
        .font(.callout)
      Text(entry.cv.contacts.phones.first ?? "+380551231212")
        .font(.caption)
        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
    }
    .padding()
  }

}

struct CVDetailsWidget_Previews: PreviewProvider {
  static var previews: some View {
    CVDetailsWidgetEntryView(
      entry: SimpleEntry.demo
    )
      .previewContext(WidgetPreviewContext(family: .systemSmall))
  }
}
