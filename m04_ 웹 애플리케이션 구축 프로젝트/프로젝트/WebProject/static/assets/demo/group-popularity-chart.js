document.addEventListener('DOMContentLoaded', function () {
  // Retrieve JSON data from the hidden input
  const novelsDataElement = document.getElementById('popularityData');
  try {
      const novelsData = JSON.parse(novelsDataElement.value);
      // Prepare data for the chart
      const titles = novelsData.map(novel => novel.title);
      const popularityValues = novelsData.map(novel => novel.popularity);

      // Create the bar chart
      const ctx = document.getElementById('popularityChart').getContext('2d');
      new Chart(ctx, {
          type: 'bar',
          data: {
              labels: titles,
              datasets: [{
                  label: 'Popularity',
                  data: popularityValues,
                  backgroundColor: 'rgba(54, 162, 235, 0.2)',
                  borderColor: 'rgba(54, 162, 235, 1)',
                  borderWidth: 1
              }]
          },
          options: {
              scales: {
                  yAxes: [{
                      ticks: {
                          beginAtZero: true
                      },
                      scaleLabel: {
                          display: true,
                          labelString: 'Popularity'
                      }
                  }],
                  xAxes: [{
                      ticks: {
                          display: false  // x축 라벨 생략
                      },
                      scaleLabel: {
                          display: true,
                          labelString: 'Novel Title'
                      }
                  }]
              },
              legend: {
                  display: true,
                  position: 'top'
              },
              tooltips: {
                  callbacks: {
                      label: function(tooltipItem) {
                          return `Popularity: ${tooltipItem.yLabel}`;
                      }
                  }
              }
          }
      });
  } catch (error) {
      console.error("Error parsing JSON:", error);
  }
});