Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#292b2c';

document.addEventListener('DOMContentLoaded', function() {
    var ctx = document.getElementById('top10KeywordsGenre').getContext('2d');
    var topKeywords = JSON.parse(document.getElementById('topKeywordsgenre').value);
    
    var labels = topKeywords.map(function(item) {
        return item[0];
    });

    var data = topKeywords.map(function(item) {
        return item[1];
    });

    // Function to generate gradient color array
    function generateGradientColors(count) {
        var colors = [];
        var minIntensity = 85;
        for (var i = 0; i < count; i++) {
            var intensity = minIntensity + Math.floor(i * ((255 - minIntensity) / count));
            colors.push(`rgba(${intensity}, ${intensity}, 255, 1)`);
        }
        return colors;
    }

    var gradientColors = generateGradientColors(data.length);

    var myBarChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: "Keyword Frequency",
                backgroundColor: gradientColors.reverse(), // 색상 순서를 반대로
                borderColor: gradientColors.reverse(),
                data: data,
            }],
        },
        options: {
            scales: {
                xAxes: [{
                    gridLines: {
                        display: false
                    },
                    ticks: {
                        maxTicksLimit: 10
                    }
                }],
                yAxes: [{
                    ticks: {
                        min: 0,
                        maxTicksLimit: 10
                    },
                    gridLines: {
                        display: true
                    }
                }],
            },
            legend: {
                display: false
            }
        }
    });
});