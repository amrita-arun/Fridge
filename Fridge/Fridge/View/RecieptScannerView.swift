//
//  RecieptScannerView.swift
//  Fridge
//
//  Created by Administrator on 1/4/25.
//

import SwiftUI
import PhotosUI
import Vision
import OpenAI

struct ReceiptScannerView: View {
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: UIImage? = nil
    @State private var recognizedText: String = "No text recognized yet."
    let openAI = OpenAI(apiToken: "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")
    @State private var jsonOutput: String = "No JSON generated yet."
    
    var body: some View {
        VStack {
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 300)
                    .overlay(Text("Select a Receipt").foregroundColor(.gray))
            }

            PhotosPicker(
                selection: $selectedItem,
                matching: .images,
                photoLibrary: .shared()
            ) {
                Text("Select Receipt")
            }
            .onChange(of: selectedItem) { newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self),
                       let image = UIImage(data: data) {
                        selectedImage = image
                        recognizeText(from: image)
                    }
                }
            }

            Text("Extracted Text:")
                .font(.headline)
                .padding(.top)

            ScrollView {
                Text(recognizedText)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
            }
            .padding()
            
            Button("Convert to JSON") {
                            Task {
                                await convertTextToJSON(using: recognizedText)
                            }
                        }
                        .padding()
                        .buttonStyle(.bordered)

                        Text("Generated JSON:")
                            .font(.headline)
                            .padding(.top)

                        ScrollView {
                            Text(jsonOutput)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                        }
                        .padding()
        }
    }

    private func recognizeText(from image: UIImage) {
        guard let cgImage = image.cgImage else { return }

        // Vision Text Recognition
        let request = VNRecognizeTextRequest { request, error in
            if let error = error {
                print("Text recognition error: \(error)")
                recognizedText = "Failed to recognize text."
                return
            }

            // Extract recognized text
            var fullText = ""
            if let observations = request.results as? [VNRecognizedTextObservation] {
                for observation in observations {
                    if let topCandidate = observation.topCandidates(1).first {
                        fullText += topCandidate.string + "\n"
                    }
                }
            }
            print(fullText)

            DispatchQueue.main.async {
                recognizedText = fullText.isEmpty ? "No text found." : fullText
            }
        }

        // Configure the request
        request.recognitionLevel = .accurate
        request.usesLanguageCorrection = true

        // Perform the request
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try handler.perform([request])
            } catch {
                print("Failed to perform text recognition: \(error)")
                DispatchQueue.main.async {
                    recognizedText = "Error performing text recognition."
                }
            }
        }
    }
    
    private func convertTextToJSON(using text: String) async {
        let prompt = """
            Convert the following receipt text into a JSON object with this structure:
            {
              "store": "Store Name",
              "ingredients": [
                {
                  "name": "Ingredient Name",
                  "price": 1.99,
                  "amount": "2 lbs",
                  "other_info": "Organic"
                }
              ]
            }
            Only return the JSON object and no additional explanations, comments, or formatting notes.
            
            Receipt Text:
            \(text)
            """
        let query = ChatQuery(messages: [.init(role: .system, content: prompt)!], model: .gpt4_o_mini, responseFormat: .jsonObject)
        do {
            let result = try await openAI.chats(query: query)
            print(result)
            if let jsonObject = result.choices.first?.message.content as? [String: Any] {
// Access the parsed JSON object directly
                print(result.choices.first?.message.content ?? "Something funky happened")
                do {
                    let prettyJsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
                    if let prettyJsonString = String(data: prettyJsonData, encoding: .utf8) {
                        DispatchQueue.main.async {
                            jsonOutput = prettyJsonString
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        jsonOutput = "Error formatting JSON: \(error.localizedDescription)"
                    }
                }
            } else {
                DispatchQueue.main.async {
                    jsonOutput = "No JSON object received in the response."
                }
            }
        } catch {
            DispatchQueue.main.async {
                jsonOutput = "Error generating JSON: \(error.localizedDescription)"
            }
        }
    }
}
