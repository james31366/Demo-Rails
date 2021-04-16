(function () {
    document.addEventListener("turbolinks:load", function () {

        let commentButtons = document.getElementsByClassName("btn-comment")
        Array.from(commentButtons).forEach(function (button) {
            button.addEventListener("click", function () {
                loadComments(this.getAttribute("article"))
            })
        })

        function loadComments(articleId) {
            let host = window.location.protocol + "//" + window.location.host;
            let url = host + "/api/v1/articles/" + articleId + "/comments"
            let http = new XMLHttpRequest()

            http.onreadystatechange = function () {
                if (http.readyState === XMLHttpRequest.DONE) {
                    if (http.status === 200) {
                        let comments = JSON.parse(http.responseText)
                        let commentView = document.getElementById("comments-" + articleId)
                        commentView.innerHTML = ""
                        comments.forEach(function (comment) {
                            let commentRow = document.createElement("div")
                            commentRow.innerHTML = comment.author + ": " + comment.text
                            commentView.append(commentRow)
                        })
                    } else {
                        console.log("The request failed.")
                    }
                }
            }
            http.open("GET", url)
            http.send()
        }
    })
})()