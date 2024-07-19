document.addEventListener('DOMContentLoaded', function() {
  try {
    // 평균 수익 구간별 데이터 가져오기
    const avgProfitByBins = JSON.parse(document.getElementById('avgProfitByBins').value);
    const avgProfitLabels = ['1구간', '2구간', '3구간', '4구간', '5구간', '6구간', '7구간', '8구간', '9구간', '10구간'];
    const avgProfitData = Object.values(avgProfitByBins);

    // 전체 작품의 평균 수익과 중앙값
    const allMean = parseFloat(document.getElementById('allMean').value);
    const allMedian = parseFloat(document.getElementById('allMedian').value);

    // 그룹 데이터의 평균 수익과 4분위 값
    const groupMean = parseFloat(document.getElementById('groupMean').value);
    const quartiles = JSON.parse(document.getElementById('quartiles').value);
    const groupData = [...quartiles, groupMean];

    // 그룹 데이터의 레이블 (Q1, Median, Q3, Mean)
    const groupLabels = ['1분위', '중앙값', '3분위', '평균'];

    // 두 개의 데이터셋을 한 차트에 추가
    const ctx = document.getElementById('profitChart').getContext('2d');

    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: avgProfitLabels,
            datasets: [
                {
                    label: '구간별 평균 수익',
                    data: avgProfitData,
                    backgroundColor: 'rgba(54, 162, 235, 0.6)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    borderWidth: 1,
                    yAxisID: 'y-axis-1'
                },
                {
                    label: '그룹 수익 (분위 및 평균)',
                    data: groupData,
                    type: 'line',
                    backgroundColor: 'rgba(255, 99, 132, 0.6)',
                    borderColor: 'rgba(255, 99, 132, 1)',
                    borderWidth: 2,
                    fill: false,
                    tension: 0.1,
                    yAxisID: 'y-axis-2'
                }
            ]
        },
        options: {
            scales: {
                yAxes: [
                    {
                        id: 'y-axis-1',
                        type: 'linear',
                        position: 'left',
                        ticks: {
                            beginAtZero: true
                        }
                    },
                    {
                        id: 'y-axis-2',
                        type: 'linear',
                        position: 'right',
                        ticks: {
                            beginAtZero: true
                        }
                    }
                ]
            },
            title: {
                display: true,
                text: '수익 분석'
            }
        }
    });
} catch (error) {
    console.error("Error parsing JSON data:", error);
}
});