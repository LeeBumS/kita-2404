document.addEventListener("DOMContentLoaded", function() {
  var ctx = document.getElementById('revenueScatter').getContext('2d');
  var novels = JSON.parse(document.getElementById('revenueData').value);

  var scatterData = novels.map(function(novel) {
    return {
      x: novel.viewCount,
      y: novel.revenue,
      title: novel.title,
      revenue: novel.revenue
    };
  });

  new Chart(ctx, {
    type: 'scatter',
    data: {
      datasets: [{
        label: '소설 수익',
        data: scatterData,
        backgroundColor: 'rgba(54, 162, 235, 0.6)',
        borderColor: 'rgba(54, 162, 235, 1)',
        pointRadius: 5
      }]
    },
    options: {
      responsive: true,
      scales: {
        xAxes: [{
          type: 'linear',
          position: 'bottom',
          scaleLabel: {
            display: true,
            labelString: '조회수'
          }
        }],
        yAxes: [{
          scaleLabel: {
            display: true,
            labelString: '예상 수익'
          },
          ticks: {
            beginAtZero: true
          }
        }]
      },
      tooltips: {
        callbacks: {
          label: function(tooltipItem, data) {
            var item = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index];
            return item.title + ': ' + item.revenue.toLocaleString() + '원';
          }
        }
      }
    }
  });
});