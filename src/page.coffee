if location.pathname isnt '/'
  title = document.querySelector('article h1 a').textContent
  document.querySelector('title').textContent = "#{title} - dev.toihrk.me"
  document.getElementById("issue").setAttribute("href", "https://github.com/toihrk-me/dev-blog/issues/new?body=#{encodeURIComponent("Leave a comment \n" + location.href)}")

hljs.initHighlightingOnLoad()
