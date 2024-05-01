let idx = 0;

$(document).ready(function () {
  window.addEventListener("message", function (event) {
    if (event.data.action == "openmenu") {
      $("body").css("display", "block");
      $(".incars").html(event.data.incars + "/" + event.data.totalcars);
      $(".totalcars").html(event.data.totalcars);
      $(".outcars").html(
        event.data.outcars + event.data.towedcars + "/" + event.data.totalcars
      );
    } else if (event.data.action == "added") {
      html =
        `
          <div class="cars" id="` +
        event.data.plate +
        `" onclick="CarsMenu(this.id)">
          <div class="car-img" style="background-image: url(./img/` +
        event.data.name +
        `.png"></div>
          <div class="car-details">
            <div class="car-bar">
              <div class="car-bar-icon">
                <i class="fa-solid fa-car-side icon"></i>
              </div>
              <div class="car-text">HEALTH</div>
              <div class="car-baro">
                <div class="car-baro-full" style="width:` +
        event.data.engine +
        `%"></div>
              </div>
            </div>
            <div class="car-bar">
              <div class="car-bar-icon">
              <i class="fa-solid fa-gas-pump icon"></i>
              </div>
              <div class="car-text">FUEL</div>
              <div class="car-baro">
                <div class="car-baro-full" style="width:` +
        event.data.fuel +
        `%"></div>
              </div>
            </div>
          </div>
          <div class="car-info">
            <div class="car-status">` +
        event.data.text +
        `</div>
            <div class="car-name">` +
        event.data.name +
        `</div>
            <center>
            <div class="car-plate">` +
        event.data.plate +
        `</div>
          </center>
          </div>
        </div>
      `;
      $(".center-left").prepend(html);
    }
  });
});

$(document).on("keydown", function (event) {
  switch (event.keyCode) {
    case 27: // ESC
      closex();
  }
});

function closex() {
  $("body").css("display", "none");
  $(".alert").css("display", "none");
  $(".center-left").empty();
  const input = document.getElementById("searcher");
  input.value = "";
  $.post("https://kye-garage/close");
}

function Search() {
  var input, filter, cars, carNames, i, txtValue;
  input = document.getElementById("searcher");
  filter = input.value.toUpperCase();
  cars = document
    .getElementsByClassName("center-left")[0]
    .getElementsByClassName("cars");
  for (i = 0; i < cars.length; i++) {
    carNames = cars[i].getElementsByClassName("car-name")[0];
    txtValue = carNames.textContent || carNames.innerText;
    if (txtValue.toUpperCase().indexOf(filter) > -1) {
      cars[i].style.display = "";
    } else {
      cars[i].style.display = "none";
    }
  }
}

function CarsMenu(idu) {
  $(".alert").css("display", "flex");
  idx = idu;
}

function cancel() {
  $(".alert").css("display", "none");
}

function accept() {
  $.post(
    "https://kye-garage/accept",
    JSON.stringify({
      plate: idx,
    })
  );
  closex();
}
