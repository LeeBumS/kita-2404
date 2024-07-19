document.addEventListener("DOMContentLoaded", function() {
  var ctx = document.getElementById('top5KeywordsChart').getContext('2d');

  var top5Keywords = JSON.parse(document.getElementById('top5Keywords').value);
  console.log('top5Keywords:', top5Keywords);  // 데이터 확인
  
  var labels = top5Keywords.map(function(item) { return item[0]; });
  var data = top5Keywords.map(function(item) { return item[1]; });

  new Chart(ctx, {
    type: 'pie',
    data: {
      labels: labels,
      datasets: [{
        label: 'Top 5 Keywords',
        data: data,
        backgroundColor: [
          'rgba(54, 162, 235, 0.6)',
          'rgba(255, 99, 132, 0.6)',
          'rgba(255, 206, 86, 0.6)',
          'rgba(75, 192, 192, 0.6)',
          'rgba(153, 102, 255, 0.6)'
        ]
      }]
    },
    options: {
      responsive: true,
      title: {
        display: true,
        text: 'Top 5 Keywords in Top 10 Novels'
      }
    }
  });
});