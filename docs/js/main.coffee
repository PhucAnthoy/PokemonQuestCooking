ingredientsInPot = 0
ingredients = [0, 0, 0, 0, 0]

$(document).ready ->
  $(".button.ingredients").mousedown (e) ->
    # These two lines are totally unnecessary
    switch e.which
      when 1 # left-click
        # Disables drag due to mouse being pressed
        e.preventDefault()

        test = true
        index = 0

        if(ingredientsInPot < 5)
          image = $(this).find("img")[0].src
          filled = $("#pot").find("div")[0].dataset.filled
          while true
            if(filled == "false")
              $("#pot").find("div")[index].dataset.filled = "true"
              ingredients[index] = parseInt(this.dataset.ingredient)
              image = "img/placed/" + image.slice(image.search("img") + 16)
              $($("#pot").find("div")[index]).find("img")[0].src = image
              ingredientsInPot++
              test = false
            index++
            if(index == 5)
              break
            filled = $("#pot").find("div")[index].dataset.filled
            break unless test

$(document).ready ->
  $(".ingredient").mousedown (e) ->
    filled = this.dataset.filled
    if(filled == "true")
      $(this).find("img")[0].src = ""
      this.dataset.filled = "false"
      ingredientsInPot--
    if($("#output").find("img")[0].dataset.filled == "true")
      $("#output").find("img")[0].dataset.filled = "false"
      $("#output").find("img")[0].src = ""
      $("#output").find("img")[1].dataset.filled = "false"
      $("#output").find("img")[1].src = ""
      $("#output").find("img")[2].dataset.filled = "false"
      $("#output").find("img")[2].src = ""


$(document).ready ->
  tiny     = [1, 0, 0, 0, 1, 0, 1, 0, 0, 0]
  bluk     = [0, 1, 0, 0, 1, 0, 0, 1, 0, 0]
  apricorn = [0, 0, 1, 0, 0, 1, 0, 0, 1, 0]
  fossil   = [0, 0, 0, 1, 0, 1, 0, 0, 0, 1]
  root     = [1, 0, 0, 0, 1, 0, 0, 0, 1, 0]
  icy      = [0, 1, 0, 0, 0, 1, 0, 0, 0, 1]
  honey    = [0, 0, 1, 0, 1, 0, 0, 1, 0, 0]
  balm     = [0, 0, 0, 1, 1, 0, 1, 0, 0, 0]

  red      = [4, 0, 0, 0, 0, 0, 0, 0, 0, 0]
  blue     = [0, 4, 0, 0, 0, 0, 0, 0, 0, 0]
  yellow   = [0, 0, 4, 0, 0, 0, 0, 0, 0, 0]
  gray     = [0, 0, 0, 4, 0, 0, 0, 0, 0, 0]
  water    = [0, 3, 0, 0, 4, 0, 0, 0, 0, 0]
  normal   = [0, 0, 0, 2, 0, 0, 0, 3, 0, 0]
  poison   = [0, 0, 0, 3, 0, 0, 4, 0, 0, 0]
  ground   = [0, 0, 0, 0, 3, 0, 0, 0, 0, 2]
  grass    = [0, 0, 0, 0, 2, 0, 0, 0, 4, 0]
  bug      = [0, 0, 3, 0, 0, 0, 0, 4, 0, 0]
  psychic  = [0, 0, 0, 0, 0, 2, 0, 3, 0, 0]
  rock     = [0, 0, 0, 0, 0, 4, 0, 0, 0, 2]
  flying   = [0, 0, 0, 0, 0, 0, 0, 0, 2, 3]
  fire     = [1, 0, 0, 0, 0, 0, 3, 0, 0, 0]
  electric = [0, 0, 3, 0, 4, 0, 0, 0, 0, 0]
  fighting = [0, 0, 0, 0, 0, 0, 2, 3, 0, 0]

  attributes  = [[0, 0, 0, 0, 0, 0, 0, 0, 0, 0], tiny, bluk, apricorn, fossil, root, icy, honey, balm]
  recipes     = [red, blue, yellow, gray, water, normal, poison, ground, grass, bug, psychic, rock, flying, fire, electric, fighting]
  types       = ["red", "blue", "yellow", "gray", "water", "normal", "poison", "ground", "grass", "bug", "psychic", "rock", "flying", "fire", "electric", "fighting"]

  $("#start").mousedown (e) ->
    console.log(ingredients)
    if(ingredientsInPot == 5)
      console.log("cooking")
      total = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

      for ingredient in ingredients
        for attribute, index in attributes[0]
          total[index] += parseInt(attributes[ingredient][index])
          #console.log(total)

      count = 0
      for recipe, index in recipes
        type = index
        check = true
        for attribute, index in attributes[0]
          check &= total[index] >= recipe[index]

        if(check)
          if($("#output").find("img")[0].dataset.filled == "false")
            $("#output").find("img")[0].dataset.filled = "true"
            console.log($("#output").find("img")[0].dataset.filled)
            $("#output").find("img")[0].src = "img/dishes/" + types[type] + ".png"
            console.log($("#output").find("img")[0].src)
            console.log(types[type])
          else if($("#output").find("img")[1].dataset.filled == "false")
            $("#output").find("img")[1].dataset.filled = "true"
            console.log($("#output").find("img")[1].dataset.filled)
            $("#output").find("img")[1].src = "img/dishes/" + types[type] + ".png"
            console.log($("#output").find("img")[1].src)
            console.log(types[type])
          else
            $("#output").find("img")[2].dataset.filled = "true"
            console.log($("#output").find("img")[2].dataset.filled)
            $("#output").find("img")[2].src = "img/dishes/" + types[type] + ".png"
            console.log($("#output").find("img")[2].src)
            console.log(types[type])
        else
          count++

        if(count == 16)
          $("#output")[0].dataset.filled = "true"
          console.log($("#output")[0].dataset.filled)
          $("#output").find("img")[0].src = "img/dishes/mulligan.png"
          console.log("mulligan")