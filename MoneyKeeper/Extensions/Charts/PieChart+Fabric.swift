import Charts

extension PieChartView {
    static var `default`: PieChartView {
        let chart = PieChartView()
        chart.drawEntryLabelsEnabled = false
        chart.rotationEnabled = false
        chart.highlightPerTapEnabled = false
        
        chart.holeColor = .backgroundWhite
        chart.noDataText = "Тут пусто :("
        chart.legend.font = .systemFont(ofSize: 14)
        
        return chart
    }
}
