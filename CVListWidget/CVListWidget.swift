//
//  CVListWidget.swift
//  CVListWidget
//
//  Created by Oleksandr Orlov on 30.06.2021.
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

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
      
      getCVService.getCVs(authToken: "userId") { result in
        switch result {
          case .success(let cvs):
            let entry = SimpleEntry(
              date: Date(),
              cvs: cvs,
              configuration: configuration
            )
            let timeline = Timeline(entries: [entry], policy: .after(Date() + TimeInterval(60)))
            completion(timeline)
          case .failure(let data): print(data)
        }
      }
    }
}

struct SimpleEntry: TimelineEntry {
  var date: Date
  let cvs: [CV]
  let configuration: ConfigurationIntent
  
  static let demo = SimpleEntry(
    date: Date(),
    cvs: [
      CV(
        id: "testId",
        userInfo:
          UserInfo(
            avatarURL: nil,
            name: "Name Surname",
            role: "iOS Developer"
          ),
        contacts:
          Contacts(
            phones: ["+380661231212"],
            emails: ["job.email@gmail.com"],
            messangers: [
              MessangerContact(
                type: .telegram,
                link: URL(string: "https://t.me/luximetr")!
              )
            ]
          ),
        experience: [],
        numbers: [],
        skills: []
      )
    ],
    configuration: ConfigurationIntent()
  )
}

struct CVListWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
      ZStack {
        Color("weatherBackgroundColor")
        WeatherSubView(entry: entry)
      }
    }
}

@main
struct CVListWidget: Widget {
    let kind: String = "CVListWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            CVListWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}



struct WeatherSubView: View {
  @Environment(\.widgetFamily) var widgetFamily
  var entry: Provider.Entry
  
  var body: some View {
    switch widgetFamily {
      case .systemSmall:
        CVListWidgetSmall(entry: entry)
      case .systemMedium:
        CVListWidgetMedium()
      case .systemLarge:
        CVListWidgetLarge()
      @unknown default:
        CVListWidgetSmall(entry: entry)
    }
  }
}

struct CVListWidgetSmall: View {
  var entry: Provider.Entry
  
  var body: some View {
    VStack {
      Text(entry.cvs.first?.userInfo.name ?? "")
      Text(entry.cvs.first?.userInfo.role ?? "")
        .font(.callout)
      Text(entry.cvs.first?.contacts.phones.first ?? "")
        .font(.caption)
        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
    }
    .foregroundColor(.white)
    .padding()
  }
  
}

struct CVListWidgetMedium: View {
  
  var body: some View {
    Text("Medium")
  }
  
}

struct CVListWidgetLarge: View {
  
  var body: some View {
    Text("Large")
  }
  
}

struct CVListWidget_Previews: PreviewProvider {
    static var previews: some View {
        CVListWidgetEntryView(
          entry:SimpleEntry.demo
        )
        .previewContext(WidgetPreviewContext(family: .systemSmall))
      
      CVListWidgetEntryView(
        entry:SimpleEntry.demo
      )
      .previewContext(WidgetPreviewContext(family: .systemMedium))
      
      CVListWidgetEntryView(
        entry:SimpleEntry.demo
      )
      .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
