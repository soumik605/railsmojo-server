# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "https://ga.jspm.io/npm:@hotwired/stimulus@3.2.1/dist/stimulus.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "flowbite", to: "https://unpkg.com/flowbite@1.6.0/dist/flowbite.turbo.js"
# pin "stimulus-popover", to: "https://ga.jspm.io/npm:stimulus-popover@6.2.0/dist/stimulus-popover.mjs"
