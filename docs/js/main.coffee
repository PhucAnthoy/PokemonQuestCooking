ingredientsInPot = 0
ingredients = [0, 0, 0, 0, 0]

reset = () ->
  $("#quality").find("img")[0].src = ""
  if($("#output").find("img")[0].dataset.filled == "true")
    $("#output").find("img")[0].dataset.filled = "false"
    $("#output").find("div")[0].className = "button output hidden"
    $("#output").find("img")[1].dataset.filled = "false"
    $("#output").find("div")[1].className = "button output hidden"
    $("#output").find("img")[2].dataset.filled = "false"
    $("#output").find("div")[2].className = "button output hidden"
    $("#output")[0].dataset.cooked = "false"

# Tracks when ingredients are selected to be added to the pot
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

# Tracks when ingredients are selected to be removed from the pot
$(document).ready ->
  $(".ingredient").mousedown (e) ->
    e.preventDefault()
    filled = this.dataset.filled
    if(filled == "true")
      $(this).find("img")[0].src = ""
      this.dataset.filled = "false"
      ingredientsInPot--
      reset()

# Tracks when the start cooking button is pressed and determines what dishes are possible
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
    e.preventDefault()
    if($("#output")[0].dataset.cooked == "true")
      return
    console.log(ingredients)
    if(ingredientsInPot == 5)
      $("#output")[0].dataset.cooked = "true"
      total = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
      rating = 0

      # Checks for quality
      # Totals the attributes of all ingredients in pot
      for ingredient in ingredients
        if(ingredient > 4)
          rating++
        for attribute, index in attributes[0]
          total[index] += parseInt(attributes[ingredient][index])

      count = 0
      # Checks to see if the ingredients in the pot match any recipes
      for recipe, index in recipes
        type = index
        check = true
        for attribute, index in attributes[0]
          check &= total[index] >= recipe[index]

        # Checks for open output slots
        # Hopefully, there are no recipes with 4 possible dishes
        if(check)
          if($("#output").find("img")[0].dataset.filled == "false")
            $("#output").find("img")[0].dataset.filled = "true"
            $("#output").find("img")[0].src = "img/dishes/" + types[type] + ".png"
            $("#output").find("div")[0].className = "button output"
            console.log(types[type])
          else if($("#output").find("img")[1].dataset.filled == "false")
            $("#output").find("img")[1].dataset.filled = "true"
            $("#output").find("img")[1].src = "img/dishes/" + types[type] + ".png"
            $("#output").find("div")[1].className = "button output"
            console.log(types[type])
          else
            $("#output").find("img")[2].dataset.filled = "true"
            $("#output").find("img")[2].src = "img/dishes/" + types[type] + ".png"
            $("#output").find("div")[2].className = "button output"
            console.log(types[type])
        else
          count++

        # Will this dish end up being mulligan?
        if(count == 16)
          $("#output").find("img")[0].dataset.filled = "true"
          $("#output").find("img")[0].src = "img/dishes/mulligan.png"
          $("#output").find("div")[0].className = "button output"
          console.log("mulligan")

      # Quality checker
      console.log(rating)
      switch rating
        when 5
          quality = "special"
        when 4
          quality = "very good"
        when 3
          quality = "very good"
        when 2
          quality = "good"
        when 1
          quality = "good"
        else
          quality = "basic"
      console.log(rating)

      $("#quality").find("img")[0].src = "img/quality/" + quality + ".png"

$(document).ready ->
  $("#reset").mousedown (e) ->
    e.preventDefault()
    ingredientsInPot = 0
    for ingredient in $(".ingredient")
      ingredient.dataset.filled = "false"
      $(ingredient).find("img")[0].src = ""
    reset()