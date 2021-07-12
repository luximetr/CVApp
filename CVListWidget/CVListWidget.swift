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
  
    func placeholder(in context: Context) -> CharacterDetailEntry {
//      SimpleEntry.demo
      CharacterDetailEntry.demo
    }

    func getSnapshot(for configuration: SelectCharacterIntent, in context: Context, completion: @escaping (CharacterDetailEntry) -> ()) {
//      let entry = SimpleEntry.demo
      let entry = CharacterDetailEntry.demo
      completion(entry)
    }

    func getTimeline(for configuration: SelectCharacterIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
      
      let character = CharacterDetail.availableCharacters.first(where: { $0.name == configuration.character?.name }) ?? CharacterDetail.availableCharacters[0]
      
      let entry = CharacterDetailEntry(
        date: Date(),
        detail: character,
        configuration: configuration
      )
      
      let entries = [entry]
      
      let timeline = Timeline(
        entries: entries,
        policy: .after(Date() + TimeInterval(60))
      )
      completion(timeline)
//      getCVService.getCVs(authToken: "userId") { result in
//        switch result {
//          case .success(let cvs):
//            let entry = SimpleEntry(
//              date: Date(),
//              cvs: cvs,
//              configuration: configuration
//            )
//            let timeline = Timeline(entries: [entry], policy: .after(Date() + TimeInterval(60)))
//            completion(timeline)
//          case .failure(let data): print(data)
//        }
//      }
    }
}

struct SimpleEntry: TimelineEntry {
  var date: Date
  let cvs: [CV]
  let configuration: SelectCharacterIntent
  
  static let demo = SimpleEntry(
    date: Date(),
    cvs: [
      CV.getDemoCV(),
      CV.getDemoCV(),
      CV.getDemoCV(),
      CV.getDemoCV()
    ],
    configuration: SelectCharacterIntent()
  )
}

struct CharacterDetailEntry: TimelineEntry {
  var date: Date
  let detail: CharacterDetail
  let configuration: SelectCharacterIntent
  
  static let demo = CharacterDetailEntry(
    date: Date(),
    detail: CharacterDetail.availableCharacters[0],
    configuration: SelectCharacterIntent()
  )
}

struct CVListWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
      ZStack {
        Color("backgroundColor")
        WeatherSubView(entry: entry)
      }
    }
}

@main
struct CVListWidget: Widget {
    let kind: String = "CVListWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(
          kind: kind,
          intent: SelectCharacterIntent.self,
          provider: Provider()
        ) { entry in
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
        CVListWidgetMedium(entry: entry)
      case .systemLarge:
        CVListWidgetLarge(entry: entry)
      @unknown default:
        CVListWidgetSmall(entry: entry)
    }
  }
}

struct CVListWidgetSmall: View {
  var entry: Provider.Entry
  
  var body: some View {
    VStack {
      Text(entry.detail.name)
//      Text(entry.cvs.first?.userInfo.name ?? "")
//        .foregroundColor(.primary)
//      Text(entry.cvs.first?.userInfo.role ?? "")
//        .foregroundColor(.primary)
//        .font(.callout)
//      Text(entry.cvs.first?.contacts.phones.first ?? "+380551231212")
//        .font(.caption)
//        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
    }
    .padding()
  }
  
}

struct CVListWidgetMedium: View {
  
  var entry: Provider.Entry
  
  var body: some View {
    VStack {
      Text(entry.detail.name)
//      if entry.cvs.isEmpty {
//        Text("No items to display")
//      } else {
//          CVListItem(cv: entry.cvs[0])
//        if entry.cvs.count > 1 {
//          CVListItemDivider()
//          CVListItem(cv: entry.cvs[1])
//        }
//      }
    }
    .foregroundColor(.white)
    .padding()
  }
  
}

struct CVListItemDivider: View {
  
  var body: some View {
    Divider()
      .frame(height: 1)
      .background(Color.secondary)
      .opacity(0.25)
  }
}

struct CVListItem: View {
  
  var cv: CV
  
  var body: some View {
    Link(destination: URL(string: "https://heroku-html-buildpack-cvapp.herokuapp.com/cvs/\(cv.id)")!, label: {
      HStack {
        Image("hail")
          .resizable()
          .frame(width: 40, height: 40, alignment: .center)
          .background(Color.gray)
          .clipShape(Capsule())
        VStack(alignment: .leading, content: {
          Text(cv.userInfo.name)
            .foregroundColor(.primary)
          Text(cv.userInfo.role)
            .foregroundColor(.primary)
            .font(.caption)
        })
        Spacer()
      }
    })
  }
}

struct CVListWidgetLarge: View {
  
  var entry: Provider.Entry
  
  var body: some View {
    VStack {
      Text(entry.detail.name)
//      if entry.cvs.isEmpty {
//        Text("No items to display")
//      } else {
//        CVListItem(cv: entry.cvs[0])
//        if entry.cvs.count > 1 {
//          CVListItemDivider()
//          CVListItem(cv: entry.cvs[1])
//        }
//        if entry.cvs.count > 2 {
//          CVListItemDivider()
//          CVListItem(cv: entry.cvs[2])
//        }
//        if entry.cvs.count > 3 {
//          CVListItemDivider()
//          CVListItem(cv: entry.cvs[3])
//        }
//      }
    }
    .foregroundColor(.white)
    .padding()
  }
  
}

struct CVListWidget_Previews: PreviewProvider {
    static var previews: some View {
        CVListWidgetEntryView(
//          entry:SimpleEntry.demo
          entry: CharacterDetailEntry.demo
        )
        .previewContext(WidgetPreviewContext(family: .systemSmall))
        .colorScheme(.light)
      
      CVListWidgetEntryView(
//        entry:SimpleEntry.demo
        entry: CharacterDetailEntry.demo
      )
      .previewContext(WidgetPreviewContext(family: .systemSmall))
      .colorScheme(.light)
      
      CVListWidgetEntryView(
//        entry:SimpleEntry.demo
        entry: CharacterDetailEntry.demo
      )
      .previewContext(WidgetPreviewContext(family: .systemMedium))
      
      CVListWidgetEntryView(
//        entry:SimpleEntry.demo
        entry: CharacterDetailEntry.demo
      )
      .previewContext(WidgetPreviewContext(family: .systemMedium))
      .colorScheme(.dark)
      
      CVListWidgetEntryView(
//        entry:SimpleEntry.demo
        entry: CharacterDetailEntry.demo
      )
      .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
