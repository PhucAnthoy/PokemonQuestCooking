ingredientsInPot = 0
ingredients = [0, 0, 0, 0, 0]
potSlots = $("#pot").find("div")
outputBox = $("#output").find("div")[0]
outputSlot = $("#output").find("img")[0]
qualitySlot = $("#quality").find("img")[0]
typeSlot = $("#type").find("img")[0]

reset = () ->
  outputSlot.src = ""
  $("#output")[0].dataset.cooked = "false"
  outputSlot.dataset.filled = "false"
  qualitySlot.src = ""
  typeSlot.src =""

# Tracks when ingredients are selected to be added to the pot
$(document).ready ->
  $(".button.ingredients").mousedown (e) ->
    # Disables drag due to mouse being pressed
    e.preventDefault()

    image = $(this).find("img")[0].src

    for n in [0..4]
      if(potSlots[n].dataset.filled == "false")
        potSlots[n].dataset.filled = "true"
        ingredients[n] = parseInt(this.dataset.ingredient)
        image = "img/placed/" + image.slice(image.search("img") + 16)
        $(potSlots[n]).find("img")[0].src = image
        ingredientsInPot++
        return

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
  tiny     = [1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1]
  bluk     = [0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1]
  apricorn = [0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1]
  fossil   = [0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1]
  root     = [1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 2]
  icy      = [0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 2]
  honey    = [0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 2]
  balm     = [0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 0, 2]
  rainbow  = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3]
  shell    = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 4]

  red      = [4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
  blue     = [0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0]
  yellow   = [0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0]
  gray     = [0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0]
  water    = [0, 3, 0, 0, 4, 0, 0, 0, 0, 0, 0]
  normal   = [0, 0, 0, 2, 0, 0, 0, 3, 0, 0, 0]
  poison   = [0, 0, 0, 0, 3, 0, 4, 0, 0, 0, 0]
  ground   = [0, 0, 0, 0, 3, 0, 0, 0, 0, 2, 0]
  grass    = [0, 0, 0, 0, 2, 0, 0, 0, 4, 0, 0]
  bug      = [0, 0, 3, 0, 0, 0, 0, 4, 0, 0, 0]
  psychic  = [0, 0, 0, 0, 0, 2, 0, 3, 0, 0, 0]
  rock     = [0, 0, 0, 0, 0, 4, 0, 0, 0, 2, 0]
  flying   = [0, 0, 0, 0, 0, 0, 0, 0, 2, 3, 0]
  fire     = [1, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0]
  electric = [0, 0, 3, 0, 4, 0, 0, 0, 0, 0, 0]
  fighting = [0, 0, 0, 0, 0, 0, 2, 3, 0, 0, 0]
  ambrosia = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4]

  attributes  = [tiny, bluk, apricorn, fossil, root, icy, honey, balm, rainbow, shell]
  recipes     = [red, blue, yellow, gray, water, normal, poison, ground, grass, bug, psychic, rock, flying, fire, electric, fighting, ambrosia]
  types       = ["Red Stew", "Blue Soda", "Yellow Curry", "Gray Porridge", "Mouth-Watering Dip", "Plain Crepe", "Sludge Soup", "Mud Pie", "Veggie Smoothie", "Honey Nectar", "Brain Food", "Stone Soup", "Light-as-Air Casserole", "Hot Pot", "Watt a Rissota", "Get Swole", "Ambrosia of Legends"]

  $("#start").mousedown (e) ->
    e.preventDefault()
    if($("#output")[0].dataset.cooked == "true")
      $(".modal").addClass("show")
      $(".modal-content").addClass("show")
      return
    if(ingredientsInPot == 5)
      $(".modal").addClass("show")
      $(".modal-content").addClass("show")

      $("#output")[0].dataset.cooked = "true"
      total = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

      # Checks for quality
      # Totals the attributes of all ingredients in pot
      for ingredient in ingredients
        for n in [0..11]
          total[n] += parseInt(attributes[ingredient][n])

      # Quality checker
      if(total[11] < 6)
        rating = "basic"
        expeditions = 2
      else if(total[11] < 8)
        rating = "good"
        expeditions = 4
      else if(total[11] < 10)
        rating = "very good"
        expeditions = 5
      else
        rating = "special"
        expeditions = 6
      qualitySlot.src = "img/quality/" + rating + ".png"
      $("#expeditions")[0].innerHTML = expeditions

      # Checks to see if the ingredients in the pot match any recipes
      for recipe, index in recipes
        check = true
        for attribute in [0..10]
          check &= total[attribute] >= recipe[attribute]

        # Checks for open output slots
        # Hopefully, there are no recipes with 4 possible dishes
        # I now understand how the game selects the resulting dish
        # Shoutout to @SciresM on Twitter for datamining and for the recipe info dump
        if(check)
          image = "img/dishes/" + types[index] + ".png"
          outputSlot.dataset.filled = "true"
          outputSlot.src = image
          $("h2")[0].innerHTML = types[index] + " &aacute; la Cube"
          return


      # This code only runs when no other dishes were made
      outputSlot.dataset.filled = "true"
      outputSlot.src = "img/dishes/mulligan.png"
      $("h2")[0].innerHTML = "Mulligan Stew &aacute; la Cube"
      console.log("mulligan")


$(document).ready ->
  $("#reset").mousedown (e) ->
    e.preventDefault()
    ingredientsInPot = 0
    for ingredient in $(".ingredient")
      ingredient.dataset.filled = "false"
      $(ingredient).find("img")[0].src = ""
    reset()

$(document).ready ->
  $("span").mousedown (e) ->
    $(".modal").removeClass("show")
    $(".modal-content").removeClass("show")

window.onclick = (e) ->
  if(event.target == $(".modal")[0])
    $(".modal").removeClass("show")
    $(".modal-content").removeClass("show")