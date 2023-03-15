// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import 'flowbite';


toggleSidebarCategory()
document.addEventListener("turbo:render", function (e) {
  toggleSidebarCategory()
})

function toggleSidebarCategory(){
  var active_article = document.getElementById("sidebar-active-article")
  if (active_article){
    active_article.value.split(" ").forEach(i => {
      var item = document.getElementById(`dropdown-category-${i}`)
      if (item){
        item.classList.remove("hidden");
      }
    });
  }
}