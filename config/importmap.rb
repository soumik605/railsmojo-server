# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "https://ga.jspm.io/npm:@hotwired/stimulus@3.2.1/dist/stimulus.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "flowbite", to: "https://unpkg.com/flowbite@1.6.0/dist/flowbite.turbo.js"
# pin "stimulus-popover", to: "https://ga.jspm.io/npm:stimulus-popover@6.2.0/dist/stimulus-popover.mjs"
pin "stimulus-sortable", to: "https://ga.jspm.io/npm:stimulus-sortable@4.1.0/dist/stimulus-sortable.mjs"
pin "@rails/request.js", to: "https://ga.jspm.io/npm:@rails/request.js@0.0.8/src/index.js"
pin "sortablejs", to: "https://ga.jspm.io/npm:sortablejs@1.15.0/modular/sortable.esm.js"
