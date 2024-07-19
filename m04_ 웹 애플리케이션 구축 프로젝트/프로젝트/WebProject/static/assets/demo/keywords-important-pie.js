document.addEventListener('DOMContentLoaded', function() {
  const data = JSON.parse(document.getElementById('keywords_importance').value);

  const ctx = document.getElementById('keywordsPieChart').getContext('2d');

  const selectedLabels = Object.keys(data.selected);
  const selectedData = Object.values(data.selected);

  const labels = [...selectedLabels, 'Others'];
  const dataset = [...selectedData, data.others];

  const pieChart = new Chart(ctx, {
      type: 'pie',
      data: {
          labels: labels,
          datasets: [{
              data: dataset,
              backgroundColor: [
                  'rgba(75, 192, 192, 0.6)',
                  'rgba(54, 162, 235, 0.6)',
                  'rgba(255, 206, 86, 0.6)',
                  'rgba(153, 102, 255, 0.6)',
                  'rgba(255, 159, 64, 0.6)',
                  'rgba(201, 203, 207, 0.6)' // Others 색상 추가
              ],
              borderColor: [
                  'rgba(75, 192, 192, 1)',
                  'rgba(54, 162, 235, 1)',
                  'rgba(255, 206, 86, 1)',
                  'rgba(153, 102, 255, 1)',
                  'rgba(255, 159, 64, 1)',
                  'rgba(201, 203, 207, 1)' // Others 테두리 색상 추가
              ],
              borderWidth: 1
          }]
      },
      options: {
          responsive: true,
          legend: {
              position: 'top',
          },
          tooltips: {
              callbacks: {
                  label: function(tooltipItem, data) {
                      const dataset = data.datasets[tooltipItem.datasetIndex];
                      const total = dataset.data.reduce((acc, value) => acc + value, 0);
                      const currentValue = dataset.data[tooltipItem.index];
                      const percentage = ((currentValue / total) * 100).toFixed(2);
                      return data.labels[tooltipItem.index] + ': ' + percentage + '%';
                  }
              }
          }
      }
  });
});