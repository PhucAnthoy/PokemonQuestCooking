// Generated by CoffeeScript 2.3.1
(function() {
  var ingredients, ingredientsInPot;

  ingredientsInPot = 0;

  ingredients = [0, 0, 0, 0, 0];

  // Tracks when ingredients are selected to be added to the pot
  $(document).ready(function() {
    return $(".button.ingredients").mousedown(function(e) {
      var filled, image, index, results, test;
      // These two lines are totally unnecessary
      switch (e.which) {
        case 1: // left-click
          // Disables drag due to mouse being pressed
          e.preventDefault();
          test = true;
          index = 0;
          if (ingredientsInPot < 5) {
            image = $(this).find("img")[0].src;
            filled = $("#pot").find("div")[0].dataset.filled;
            results = [];
            while (true) {
              if (filled === "false") {
                $("#pot").find("div")[index].dataset.filled = "true";
                ingredients[index] = parseInt(this.dataset.ingredient);
                image = "img/placed/" + image.slice(image.search("img") + 16);
                $($("#pot").find("div")[index]).find("img")[0].src = image;
                ingredientsInPot++;
                test = false;
              }
              index++;
              if (index === 5) {
                break;
              }
              filled = $("#pot").find("div")[index].dataset.filled;
              if (!test) {
                break;
              } else {
                results.push(void 0);
              }
            }
            return results;
          }
      }
    });
  });

  // Tracks when ingredients are selected to be removed from the pot
  $(document).ready(function() {
    return $(".ingredient").mousedown(function(e) {
      var filled;
      e.preventDefault();
      filled = this.dataset.filled;
      if (filled === "true") {
        $(this).find("img")[0].src = "";
        this.dataset.filled = "false";
        ingredientsInPot--;
      }
      if ($("#output").find("img")[0].dataset.filled === "true") {
        $("#output").find("img")[0].dataset.filled = "false";
        $("#output").find("div")[0].className = "button output hidden";
        $("#output").find("img")[1].dataset.filled = "false";
        $("#output").find("div")[1].className = "button output hidden";
        $("#output").find("img")[2].dataset.filled = "false";
        $("#output").find("div")[2].className = "button output hidden";
        return $("#output")[0].dataset.cooked = "false";
      }
    });
  });

  // Tracks when the start cooking button is pressed and determines what dishes are possible
  $(document).ready(function() {
    var apricorn, attributes, balm, blue, bluk, bug, electric, fighting, fire, flying, fossil, grass, gray, ground, honey, icy, normal, poison, psychic, recipes, red, rock, root, tiny, types, water, yellow;
    tiny = [1, 0, 0, 0, 1, 0, 1, 0, 0, 0];
    bluk = [0, 1, 0, 0, 1, 0, 0, 1, 0, 0];
    apricorn = [0, 0, 1, 0, 0, 1, 0, 0, 1, 0];
    fossil = [0, 0, 0, 1, 0, 1, 0, 0, 0, 1];
    root = [1, 0, 0, 0, 1, 0, 0, 0, 1, 0];
    icy = [0, 1, 0, 0, 0, 1, 0, 0, 0, 1];
    honey = [0, 0, 1, 0, 1, 0, 0, 1, 0, 0];
    balm = [0, 0, 0, 1, 1, 0, 1, 0, 0, 0];
    red = [4, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    blue = [0, 4, 0, 0, 0, 0, 0, 0, 0, 0];
    yellow = [0, 0, 4, 0, 0, 0, 0, 0, 0, 0];
    gray = [0, 0, 0, 4, 0, 0, 0, 0, 0, 0];
    water = [0, 3, 0, 0, 4, 0, 0, 0, 0, 0];
    normal = [0, 0, 0, 2, 0, 0, 0, 3, 0, 0];
    poison = [0, 0, 0, 3, 0, 0, 4, 0, 0, 0];
    ground = [0, 0, 0, 0, 3, 0, 0, 0, 0, 2];
    grass = [0, 0, 0, 0, 2, 0, 0, 0, 4, 0];
    bug = [0, 0, 3, 0, 0, 0, 0, 4, 0, 0];
    psychic = [0, 0, 0, 0, 0, 2, 0, 3, 0, 0];
    rock = [0, 0, 0, 0, 0, 4, 0, 0, 0, 2];
    flying = [0, 0, 0, 0, 0, 0, 0, 0, 2, 3];
    fire = [1, 0, 0, 0, 0, 0, 3, 0, 0, 0];
    electric = [0, 0, 3, 0, 4, 0, 0, 0, 0, 0];
    fighting = [0, 0, 0, 0, 0, 0, 2, 3, 0, 0];
    attributes = [[0, 0, 0, 0, 0, 0, 0, 0, 0, 0], tiny, bluk, apricorn, fossil, root, icy, honey, balm];
    recipes = [red, blue, yellow, gray, water, normal, poison, ground, grass, bug, psychic, rock, flying, fire, electric, fighting];
    types = ["red", "blue", "yellow", "gray", "water", "normal", "poison", "ground", "grass", "bug", "psychic", "rock", "flying", "fire", "electric", "fighting"];
    return $("#start").mousedown(function(e) {
      var attribute, check, count, i, index, ingredient, j, k, l, len, len1, len2, len3, quality, recipe, ref, ref1, total, type;
      e.preventDefault();
      if ($("#output")[0].dataset.cooked === "true") {
        return;
      }
      console.log(ingredients);
      if (ingredientsInPot === 5) {
        $("#output")[0].dataset.cooked = "true";
        total = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
        quality = 0;
// Checks for quality
// Totals the attributes of all ingredients in pot
        for (i = 0, len = ingredients.length; i < len; i++) {
          ingredient = ingredients[i];
          if (ingredient > 4) {
            quality++;
          }
          ref = attributes[0];
          for (index = j = 0, len1 = ref.length; j < len1; index = ++j) {
            attribute = ref[index];
            total[index] += parseInt(attributes[ingredient][index]);
          }
        }
        count = 0;
// Checks to see if the ingredients in the pot match any recipes
        for (index = k = 0, len2 = recipes.length; k < len2; index = ++k) {
          recipe = recipes[index];
          type = index;
          check = true;
          ref1 = attributes[0];
          for (index = l = 0, len3 = ref1.length; l < len3; index = ++l) {
            attribute = ref1[index];
            check &= total[index] >= recipe[index];
          }
          // Checks for open output slots
          // Hopefully, there are no recipes with 4 possible dishes
          if (check) {
            if ($("#output").find("img")[0].dataset.filled === "false") {
              $("#output").find("img")[0].dataset.filled = "true";
              $("#output").find("img")[0].src = "img/dishes/" + types[type] + ".png";
              $("#output").find("div")[0].className = "button output";
              console.log($("#output").find("div")[0].className);
              console.log(types[type]);
            } else if ($("#output").find("img")[1].dataset.filled === "false") {
              $("#output").find("img")[1].dataset.filled = "true";
              $("#output").find("img")[1].src = "img/dishes/" + types[type] + ".png";
              $("#output").find("div")[1].className = "button output";
              console.log(types[type]);
            } else {
              $("#output").find("img")[2].dataset.filled = "true";
              $("#output").find("img")[2].src = "img/dishes/" + types[type] + ".png";
              $("#output").find("div")[2].className = "button output";
              console.log(types[type]);
            }
          } else {
            count++;
          }
          // Will this dish end up being mulligan?
          if (count === 16) {
            $("#output").find("img")[0].dataset.filled = "true";
            $("#output").find("img")[0].src = "img/dishes/mulligan.png";
            $("#output").find("div")[0].className = "button output";
            console.log("mulligan");
          }
        }
        // Quality checker
        if (quality > 4) {
          return console.log("special");
        } else if (quality > 2) {
          return console.log("very good");
        } else if (quality > 0) {
          return console.log("good");
        } else {
          return console.log("bleh");
        }
      }
    });
  });

}).call(this);

//# sourceMappingURL=main.js.map
