if(typeof(Stripe) != 'undefined')
  jQuery ->
    subscription =
      setupForm: ->
        $("#new_user, #edit_card_form").submit ->
          $("input[type=submit]").attr "disabled", true
          if $("#card_number").length
            subscription.processCard()
            false
          else
            true

      processCard: ->
        card =
          number: $("#card_number").val()
          cvc: $("#card_code").val()
          exp_month: $("#card_month").val()
          exp_year: $("#card_year").val()

        Stripe.card.createToken(card, subscription.handleStripeResponse)

      handleStripeResponse: (status, response) ->
        if response.error
          $('#credit-card-form, #stripe_error, #card_number, #card_month, #card_year, #card_code').removeClass('error')
          formErrors = ['#credit-card-form', '#stripe_error']

          switch response.error.code
            when 'incorrect_number', 'invalid_number' then formErrors.push '#card_number'
            when 'invalid_expiry_month' then formErrors.push '#card_month'
            when 'invalid_expiry_year' then formErrors.push '#card_year'
            when 'invalid_cvc', 'incorrect_cvc' then formErrors.push '#card_code'

          $(formErrors.join(', ')).addClass('error')
          $("#stripe_error").text response.error.message
          $("input[type=submit]").attr "disabled", false
        else
          $("#user_stripe_token").val response.id
          $("#new_user, #edit_card_form")[0].submit()

    Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
    subscription.setupForm()
