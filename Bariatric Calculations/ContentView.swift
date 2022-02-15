//
//  ContentView.swift
//  Bariatric Calculations
//
//  Created by dana portenier on 2/13/22.
//

import SwiftUI

struct ContentView: View {
    
    
    @State private var mrn_entered: String = ""
    @State private var age_entered: Double = 20
    @State private var height_ft_entered: Double = 5
    @State private var height_inches_entered: Double = 1
    @State private var gender_entered: String = "Female"
    @State private var weight_lbs_entered: Double = 200

    
    let gender = ["Female", "Male"]
    var height_total_inches: Double {
        ((height_ft_entered * 12) + height_inches_entered)
    }
    var height_meters:Double {
        height_total_inches * 0.0254
    }
    var weight_Kg: Double {
        weight_lbs_entered * 0.45359237
    }
    var bmi: Double {
        weight_Kg/(height_meters * height_meters)
    }


func ideal_body_weight() -> Double {
        var x: Double = 0.0
        if gender_entered == "Female" {
            x = (45.5 + 2.3 * (height_total_inches - 60))
            
        }else if gender_entered == "Male" {
            x = (50 + 2.3 * (height_total_inches - 60))
            
        }
        return x
    }
    var ideal_body_weight_kg: Double {
        ideal_body_weight()
    }
    var ideal_body_weight_lbs: Double {
        ideal_body_weight_kg * 2.204
    }
    
//Obesity Classification
    func obesity_classification() -> String {
      var obesity_classification = ""
      if (bmi < 18.5) {
        obesity_classification = "Under Weight"
      } else if (bmi >= 18.5 && bmi <= 24.9) {
        obesity_classification = "Normal Weight"
      } else if (bmi >= 25 && bmi <= 29.9) {
        obesity_classification = "Overweight"
      } else if (bmi >= 30 && bmi <= 34.9) {
        obesity_classification = "Class I Obesity"
      } else if (bmi >= 35 && bmi <= 39.9) {
        obesity_classification = "Class II Obesity"
      } else if (bmi >= 40) {
        obesity_classification = "Class III Obesity"
      }
        return obesity_classification
    }
    var obesityClassification: String { obesity_classification()
    }
    
    
    var excess_wt_lbs: Double {
        weight_lbs_entered - ideal_body_weight_lbs
    }
    
    var excess_wt_Kg: Double {
        weight_Kg - ideal_body_weight_kg
    }
    func body_fat_percentage_calculation()-> Double {
        var x: Double = 1
        var y: Double = 2
        if (gender_entered == "Male"){
            y = 1
        }else if (gender_entered == "Female"){
            y = 0
        }
        x = (1.39 * bmi + 0.16 * age_entered - 10.34 * y - 9)
        return x
    }
    var body_fat_percentage: Double {
        body_fat_percentage_calculation()
    }
    
//    // Weight loss ranges after each bariatric procedure
//
//    /*Higher End of Excess Weight Loss Expected
//    Gastric Bypass: 60%–80%
//    Duodenal Switch: 60%–100%
//
//    Lower End of Excess Weight Loss Expected
//    Lap Band: 10%–80%
//    Gastric Sleeve: 40%–80%  */
//
//    const percent = [0.1, 0.4, 0.6, 0.7, 0.8, 1];
//    function _weight_after_percentage_ewl(percent, weight_lbs, excesswt_lbs) {
//      x = weight_lbs - percent * excesswt_lbs;
//      return x;
//    }
//
//    // The delta in weight predicted with the typical %EWL ranges for the various procedures
//    function _predicted_delta_wt(percent, excesswt_lbs) {
//      let x = percent * excesswt_lbs;
//      return x;
//    }

    
    var body: some View {
        
        NavigationView{
            Form{
                //Demographics
                Section{
                    HStack{
                    TextField("Duke MRN (Optional)", text: $mrn_entered)
                    Text("|   Age:")
                        TextField("Age", value: $age_entered, format: .number)
                            .keyboardType(.decimalPad)
                    }
                    HStack{
                        Text("Ft.")
                            .padding(0)
                        TextField("ft.", value: $height_ft_entered, format: .number)
                            .keyboardType(.decimalPad)
                        Text("Inches")
                            .padding(0)
                        TextField("Inch", value: $height_inches_entered, format: .number)
                            .keyboardType(.decimalPad)
                        Text("Wt.")
                            .padding(0)
                        TextField("Wt.", value: $weight_lbs_entered, format: .number)
                            .keyboardType(.decimalPad)
                    }
                    HStack{
                        Picker("Gender", selection: $gender_entered){
                            ForEach(gender, id:\.self){
                                Text($0)
                            }
                        }.pickerStyle(.segmented)
                    }
                }header: {
                    Text("Demographic Data Entry")
                }
                Section{
                    VStack{
                        //Height
                        HStack{
                            Text("Height: \(Int(height_ft_entered))'\(Int(height_inches_entered))\" |")
                            Text("\(Int(height_total_inches))\" inches |")
                            Text("\(height_meters, specifier: "%0.2f") meters")
                        }
                    }
                    // Weight
                        HStack{
                        Text("BMI:")
                                Text("\(bmi, specifier: "%.0f") ").foregroundColor(bmi < 35 ? .red : .black)
                        Spacer()
                        Text("Weight:")
                        Text("\(weight_lbs_entered, specifier: "%.0f") lbs  |")
                        Text("\(weight_Kg, specifier: "%.0f") Kg")
                        Spacer()
                        Spacer()
                            
                        
                    }
                    // Obesity Classification
                    HStack{
                        Text("Obesity Classification:")
                        Text("\(obesityClassification)")
                    }
                    // Ideal Body Weight
                    HStack{
                        Text("Ideal Body Weight:")
                        Text("\(ideal_body_weight_lbs, specifier: "%0.0f") lbs  |")
                        Text("\(ideal_body_weight_kg, specifier: "%0.0f") Kg")
                    }
                    //Excess Weight
                    HStack{
                        Text("Excess Wt:")
                        Text("\(excess_wt_lbs, specifier: "%0.0f") lbs |")
                        Text("\(excess_wt_Kg, specifier: "%0.0f") Kg")
                        Text(" | % Fat:")
                        Text("\(body_fat_percentage, specifier: "%0.0f")%")
                    }
                    
                }header: {
                    Text("Calculated Data")
                }
            }.navigationTitle("Bariatric Calculator")
//                .toolbar {
//                    ToolbarItemGroup(placement: .keyboard){
//                        Spacer()
//                        Button("Done"){
//                            ***enter code here***
//                        }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
