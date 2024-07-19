document.addEventListener('DOMContentLoaded', function() {
  var ctx = document.getElementById('keywordsRankLineChart').getContext('2d');
  var keywordsRank = JSON.parse(document.getElementById('keywords_rank').value);
  var selectedKeywords = JSON.parse(document.getElementById('selected_keywords').value);

  var labels = keywordsRank.map(function(item) {
    return item[0];
  });

  var data = keywordsRank.map(function(item) {
    return item[1];
  });

  var colors = ['#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0', '#9966FF', '#FF9F40', '#E7298A', '#66C2A5', '#FC8D62', '#8DA0CB'];
  var defaultColor = '#CCCCCC';

  var pointBackgroundColors = labels.map(function(label) {
    var colorIndex = selectedKeywords.indexOf(label);
    if (colorIndex !== -1) {
      return colors[colorIndex % colors.length];
    }
    return defaultColor;
  });

  var pointBorderColors = pointBackgroundColors;

  var keywordLineChart = new Chart(ctx, {
    type: 'line',
    data: {
      labels: labels,
      datasets: [{
        label: '키워드 등장 횟수',
        data: data,
        borderColor: '#000000',
        backgroundColor: '#FFFFFF',
        fill: false,
        pointBackgroundColor: pointBackgroundColors,
        pointBorderColor: pointBorderColors,
        pointRadius: 5
      }]
    },
    options: {
      responsive: true,
      scales: {
        xAxes: [{
          scaleLabel: {
            display: true,
            labelString: '키워드'
          }
        }],
        yAxes: [{
          scaleLabel: {
            display: true,
            labelString: '등장 횟수'
          },
          ticks: {
            beginAtZero: true
          }
        }]
      },
      legend: {
        display: false
      },
      tooltips: {
        callbacks: {
          label: function(tooltipItem, data) {
            var label = data.labels[tooltipItem.index];
            var value = data.datasets[0].data[tooltipItem.index];
            return label + ': ' + value;
          }
        }
      }
    }
  });
});
