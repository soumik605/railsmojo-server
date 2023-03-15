// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import 'flowbite';


var active_article = document.getElementById("sidebar-active-article")
if (active_article){
  active_article.value.split(" ").forEach(i => {
    var item = document.getElementById(`dropdown-category-${i}`)
    if (item){
      item.classList.remove("hidden");
    }
  });
}