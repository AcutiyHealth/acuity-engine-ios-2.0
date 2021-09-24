//
//  AcuityGraph.swift
//  ChartForAcuity
//
//  Created by Bhoomi Jagani on 22/07/21.
//

import Foundation
import Charts

class AcuityGraph:LineChartView{
    
    func initialize(){
        self.dragEnabled = false
        self.setScaleEnabled(false)
       
        self.drawGridBackgroundEnabled = false
        self.xAxis.drawAxisLineEnabled = false
        self.xAxis.drawGridLinesEnabled = false
        self.leftAxis.drawAxisLineEnabled = false
        self.leftAxis.drawGridLinesEnabled = false
        self.rightAxis.drawAxisLineEnabled = false
        self.rightAxis.drawGridLinesEnabled = false
        self.legend.enabled = false
        self.xAxis.enabled = false
        
        self.leftAxis.drawLabelsEnabled = true
        self.rightAxis.drawLabelsEnabled = true
        self.leftAxis.labelTextColor = UIColor.clear
        self.rightAxis.labelTextColor = UIColor.clear
        self.leftAxis.axisMinimum = 0;
    }
    
    func setData(data: [(x: Int, y: Double)],colorForChart:UIColor){
        
        
        let yValues = convertDataToChartDataEntry(data: data)
        
        let set1 = LineChartDataSet(entries: yValues, label: "");
        set1.lineDashLengths = nil
        set1.highlightLineDashLengths = nil
        
        //======Color OF Chart=================//
        set1.setColor(colorForChart)
        
        //======Color Of Small Value Dot..=====//
        set1.setCircleColor(colorForChart)
        
        //=======================Set Gradient Color in Chart=======================//
        let coloTop = colorForChart.withAlphaComponent(0.8).cgColor
        let colorBottom = colorForChart.withAlphaComponent(0.2).cgColor
        let gradientColors = [coloTop, colorBottom] as CFArray // Colors of the gradient
        let colorLocations:[CGFloat] = [1, 0.0] // Positioning of the gradient
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) // Gradient Object
        set1.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0) // Set the Gradient
        set1.drawFilledEnabled = true // Draw the Gradient
        set1.fillAlpha = 0.5
        
        //=======================value Text Color in Chart================//
        set1.valueTextColor = UIColor.white
        set1.lineWidth = 1
        set1.circleRadius = 3
        set1.drawCircleHoleEnabled = false
        
        //================Set Font and Dormat in Value===========================//
        set1.valueFont = getFontAsPerDeviceSize(fontName: Fonts.kValueFont, fontSize: 9)
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        set1.valueFormatter = DefaultValueFormatter(formatter: formatter)
        
        //=========================Feed Data in Chart==============================//
        let data = LineChartData(dataSet: set1)
        self.data = data
        
        //=============Animate Charte Value Display================================//
        self.animate(xAxisDuration: 0.5)
    }
    
    func convertDataToChartDataEntry(data: [(x: Int, y: Double)])->[ChartDataEntry]{
        var yValues:[ChartDataEntry]  = []
        for dataset in data{
            yValues.append(ChartDataEntry(x: Double(dataset.x), y: dataset.y))
        }
        return yValues
    }
    
}
