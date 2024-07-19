Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#292b2c';

document.addEventListener('DOMContentLoaded', function() {
    var ctx = document.getElementById('top5KeywordsSelectedGroup').getContext('2d');
    var topKeywords = JSON.parse(document.getElementById('topKeywordsselectedgroup').value);
    
    var labels = topKeywords.map(function(item) {
        return item[0];
    });

    var data = topKeywords.map(function(item) {
        return item[1];
    });

    // Function to generate gradient color array
    function generateGradientColors(count) {
        var colors = [];
        var minIntensity = 160;
        var maxIntensity = 200;
        for (var i = 0; i < count; i++) {
            var intensity = minIntensity + Math.floor(i * ((maxIntensity - minIntensity) / count));
            colors.push(`rgba(0, ${intensity}, 0, 1)`);
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
                backgroundColor: gradientColors,
                borderColor: gradientColors,
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
                        maxTicksLimit: 5
                    }
                }],
                yAxes: [{
                    ticks: {
                        min: 0,
                        maxTicksLimit: 5
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