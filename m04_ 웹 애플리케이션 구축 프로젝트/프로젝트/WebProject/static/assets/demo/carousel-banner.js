document.addEventListener('DOMContentLoaded', function() {
  var myCarousel = document.querySelector('#carouselBanner');
  var carousel = new bootstrap.Carousel(myCarousel, {
    interval: 3000,
    ride: 'carousel'
  });
});