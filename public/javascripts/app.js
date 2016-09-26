$(document).ready(function() {
  $('#item-form').on("submit", function(event) {
    event.preventDefault();

    var newItem = $('#item_content').val();

    var request = $.ajax({
      method: "POST",
      url: "/api/v1/items.json",
      data: { name: newItem }
    }).success(function(data) {
      $("ul").append("<li>" + newItem + "</li>");
      alert("New bucket list item added!");
    }).error(function(data) {
      alert("Invalid bucket list submission! Try again!")
    })
  });
})
