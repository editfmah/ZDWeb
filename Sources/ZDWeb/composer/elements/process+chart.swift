//
//  File.swift
//  
//
//  Created by Adrian Herridge on 22/05/2023.
//

import Foundation

public extension WebRequestContext {
    
//    <div>
//      <canvas id="myChart"></canvas>
//    </div>
//
//    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
//
//    <script>
//      const ctx = document.getElementById('myChart');
//
//      new Chart(ctx, {
//        type: 'bar',
//        data: {
//          labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
//          datasets: [{
//            label: '# of Votes',
//            data: [12, 19, 3, 5, 2, 3],
//            borderWidth: 1
//          }]
//        },
//        options: {
//          scales: {
//            y: {
//              beginAtZero: true
//            }
//          }
//        }
//      });
//    </script>

    enum ChartDirection : String {
        case Vertical
        case Horizontal
    }
    
    enum ChartType : String {
        case bar
        case line
    }
    
    func chart(title: String, xLabels: [String]? = nil,direction: ChartDirection, type: ChartType, data: [(String, Int)]) {
        
        let id = UUID().uuidString.lowercased().replacingOccurrences(of: "-", with: "")
        
        self.div {
            self.block("canvas") {
                self.id(id)
            }
        }
        
        var datasets: [(label: String, data: [Int])] = []
        if xLabels == nil {
            for d in data {
                datasets.append((label: d.0, data: [d.1]))
            }
        } else {
            var values: [Int] = []
            for d in data {
                values.append(d.1)
            }
            datasets.append((label: "", data: values))
        }
        
        let chartdata = "\(datasets)".replacingOccurrences(of: "(", with: "{").replacingOccurrences(of: ")", with: "}")
        
        var labels = "[\"\"]"
        
        if let xLabels = xLabels {
            labels = "\(xLabels)"
        }
        
        self.script("""
      const ctx\(id) = document.getElementById('\(id)');

      new Chart(ctx\(id), {
        type: '\(type.rawValue)',
        data: {
          labels: \(labels),
          datasets: \(chartdata)
        },
        options: {
          indexAxis: '\(direction == .Horizontal ? "y" : "x")',
          scales: {
            y: {
              beginAtZero: true,
                stepSize: 1,
            },
            x: {
              ticks: {
                stepSize: 1
              }
            }
          },
          responsive: true,
          maintainAspectRatio: false,
          plugins: {
           legend: {
           position: 'left',
           },
           title: {
              display: true,
              text: '\(title)'
           }
        },
          maxBarThickness: 30,
        },
           title: {
           display: true,
           text: '\(title)'
           }
      });
""")
        
    }
    
    func HorizontalBarChart(title: String, xLabels: [String], data: [(label: String, data: [(y: Int, x: [Int])])]) {
        
        let id = UUID().uuidString.lowercased().replacingOccurrences(of: "-", with: "")
        
        self.div {
            self.block("canvas") {
                self.id(id)
            }
        }
        
        let chartData = "\(data)".replacingOccurrences(of: "(", with: "{").replacingOccurrences(of: ")", with: "}")
        
        self.script("""

      const xScale\(id) = \(xLabels);
      const yScale\(id) = [""];

      const ctx\(id) = document.getElementById('\(id)');

          const data\(id) = {
            datasets: \(chartData)
          };

      new Chart(ctx\(id), {
              type: 'bar',
              data: data\(id),
              options: {
               scales: {
                  x: {
                     max: \(xLabels.count - 1),
                     min: 0,
                      ticks: {
                        callback: (val) => (xScale\(id)[val]),
                        autoSkip: false,
                        stepSize: 1
                      }
                    },
                    y: {
                     max: 1,
                     min: -1,
                      ticks: {
                        callback: (val) => (yScale\(id)[val]),
                        stepSize: 1
                      }
                    }
                  },
                  indexAxis: 'y',
                  // Elements options apply to all of the options unless overridden in a dataset
                  // In this case, we are setting the border of each horizontal bar to be 2px wide
                  elements: {
                     bar: {
                     borderWidth: 2,
                     barWidth: 20,
                     }
                  },
                  responsive: true,
                  maintainAspectRatio: false,
                  plugins: {
                     legend: {
                     position: 'right',
                     },
                     title: {
                     display: true,
                     text: '\(title)'
                     }
                  }
               },
            });


""")
        
    }
    
    func BubbleChart(title: String, xLabels: [String], yLabels: [String], data: [(x: Int, y: Int, r: Int)]) {
        
        let id = UUID().uuidString.lowercased().replacingOccurrences(of: "-", with: "")
        
        self.div {
            self.block("canvas") {
                self.id(id)
            }
        }
        
        let chartData = "\(data)"
        
        self.script("""

      const xScale\(id) = \(xLabels);
      const yScale\(id) = \(yLabels);

      const ctx\(id) = document.getElementById('\(id)');

          const data\(id) = {
            datasets: [{
              label: '\(title)',
              data: \(chartData.replacingOccurrences(of: "(", with: "{").replacingOccurrences(of: ")", with: "}")),
              backgroundColor: 'rgb(255, 99, 132)'
            }]
          };

      new Chart(ctx\(id), {
        type: 'bubble',
        data: data\(id),
        options: {
            scales: {
            x: {
                   max: \(xLabels.count - 1),
                   min: 0,
                    ticks: {
                          callback: (val) => (xScale\(id)[val]),
                          autoSkip: false,
                          stepSize: 1
                    }
              },
            y: {
                   max: \(yLabels.count - 1),
                   min: 0,
                        ticks: {
                              callback: (val) => (yScale\(id)[val]),
                              autoSkip: false,
                              stepSize: 1
                        }
                }
            }
        }
      });


""")
        
    }
    
}
